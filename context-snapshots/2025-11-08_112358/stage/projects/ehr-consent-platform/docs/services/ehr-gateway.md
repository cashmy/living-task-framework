# EHR Gateway Service

## Overview

The EHR Gateway is the policy decision and enforcement entrypoint that fronts downstream EHR/FHIR systems. It exposes a REST API that callers can use to verify whether an access request is backed by an active on-chain consent and proxies approved traffic to the configured FHIR service. The gateway consumes consent state that is indexed from the ConsentRegistry smart contract and stored by the Consent Indexer service.

### Recent Enhancements

- Hardened PDP decision core with consent validation, retry/backoff, and fail-open handling.
- Added structured audit logging, correlation IDs, and Prometheus metrics (decisions, denials, latency, cache efficiency).
- Introduced short-lived in-memory caching with manual invalidation hooks to absorb indexer latency.
- Expanded automated test coverage for consent evaluation, server routes, metrics, and audit middleware.
- Wired the audit logger to the compliance pipeline via an HTTP publisher with retry/backoff and bearer-token auth.
- Enforces broker-issued internal JWTs via JWKS validation and injects authenticated principals into PDP and FHIR proxy decisions using the shared `@ehr/service-auth` package.

## Responsibilities

- **Policy Decision Point (PDP):** Evaluate incoming access decisions against the indexed consent ledger.
- **Policy Enforcement Point (PEP):** Provide REST endpoints that upstream clients can call before retrieving protected health data, including a read-only FHIR proxy that forwards permitted requests to the configured upstream server.
- **Service Health Surface:** Report liveness/readiness states so orchestrators can route traffic safely.

## Architecture & Data Flow

Clients must present an internal JWT issued by the Auth Service in the `Authorization: Bearer …` header. The gateway verifies the token against the configured JWKS, validates issuer/audience, and uses the embedded subject/claims to drive PDP decisions and FHIR proxy enforcement.

### Authentication Middleware

Token verification is powered by the shared workspace package `@ehr/service-auth`. The module exposes:

- `InternalTokenVerifier` – validates broker-issued JWTs using JWKS discovery, audience/issuer checks, and scoped claim extraction.
- `createAuthenticationMiddleware` – Express middleware that enforces the bearer token requirement and attaches the verified token to `req.internalToken` for downstream handlers.

All gateway imports now reference the shared package so other services (FHIR proxy, Consent Indexer API, Audit pipeline) can reuse the same verifier without duplicating crypto or Express augmentation logic.

1. A client submits an access decision request (`/v1/access/decision`) containing a `patientId`, optional `granteeId`, and optional `scopeId`.
2. The gateway normalizes identifiers, falls back to the authenticated token subject when `granteeId` is not provided, and queries the Consent Indexer (`GET /consents`) for all matching records. Successful responses are cached in-memory for up to 30 seconds per `(patientId, granteeId, scopeId)` tuple to absorb bursts.
3. The PDP logic selects the most relevant consent by enforcing:
   - `status === "Active"` (case-insensitive)
   - Current time (or supplied `asOf`) falls within `[validFrom, validTo]`; `validTo === 0` is treated as open-ended.
   - Scope matches when `scopeId` is provided.
4. If an active consent is found, the gateway responds with `200 OK` and the matching consent record; otherwise it returns `403` with reason `no_active_consent`.
5. The `/fhir/*` route reuses the PDP result to guard outbound FHIR calls to the configured backend (`FHIR_BASE_URL`). Permitted requests are proxied with correlation IDs, propagated authorization headers, audit logging, and Prometheus metrics; denials mirror PDP reasons.

| Method | Path | Purpose | Notes |
|--------|------|---------|-------|
| `GET` | `/health` | Liveness probe | Returns `{ status: "ok" }`. |
| `GET` | `/ready` | Readiness probe | Checks Consent Indexer health; returns `503` with `reason: "consent-indexer-unreachable"` when downstream is unavailable. |
| `POST` | `/v1/access/decision` | PDP decision | Requires `patientId`. Optional `granteeId`, `scopeId`, `asOf`. Response shape matches `AccessDecision` interface. Emits audit events and metrics. |
| `GET` | `/metrics` | Prometheus metrics | Exposes PDP counters/histograms (`pdp_decisions_total`, `pdp_denies_reason_total`, `pdp_indexer_latency_ms`, `pdp_cache_hits_total`, `pdp_cache_misses_total`). |
| `GET` | `/fhir/:resource` | FHIR proxy | Enforces the allowlist, checks consent via PDP, and proxies permitted reads to the configured FHIR backend. Unsupported verbs still return `501`. |

### AccessDecision schema

```json
{
  "permitted": true,
  "reason": "granted",
  "consent": {
    "consentId": "0x...",
    "patientId": "0x...",
    "granteeId": "0x...",
    "scopeId": "0x...",
    "status": "Active",
    "validFrom": 1717564800,
    "validTo": 1719993600,
    "txHash": "0x...",
    "blockNo": 12345,
    "logIndex": 0
  }
}
```

When access is denied, `permitted` is `false`, `reason` is `no_active_consent`, and `consent` is `null`.

## Configuration

Environment variables are loaded with `dotenv` and validated at startup (`src/config.ts`).

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `CONSENT_INDEXER_URL` | ✅ | _none_ | Base URL of the Consent Indexer REST API. |
| `HTTP_PORT` (or `PORT`) | ✅ | `4000` | Port the gateway listens on. |
| `FHIR_BASE_URL` | ❌ | `http://localhost:8080/fhir` | Downstream FHIR server base URL (proxy target). |
| `GATEWAY_IDENTITY` | ❌ | _none_ | Hex address used for backwards compatibility when a token lacks subject metadata (should be rare). |
| `AUTH_JWKS_URL` | ✅ | _none_ | JWKS endpoint exposed by the Auth Service for verifying internal JWT signatures. |
| `AUTH_JWT_ISSUER` | ✅ | _none_ | Expected issuer (`iss`) claim for internal JWTs. |
| `AUTH_JWT_AUDIENCE` | ✅ | _none_ | Comma-separated audiences that the gateway accepts for internal JWTs. |
| `CONSENT_INDEXER_MAX_RETRIES` | ❌ | `2` | Retry attempts before surfacing indexer outage. |
| `CONSENT_INDEXER_RETRY_DELAY_MS` | ❌ | `200` | Backoff delay (ms) between indexer retries. |
| `CONSENT_FAIL_OPEN` | ❌ | `false` | When `true`, PDP will temporarily permit requests if the indexer is unreachable. |
| `CONSENT_CACHE_TTL_MS` | ❌ | `30000` | Cache duration (ms) for consent snapshots, capped at 30 000. Use `0` to disable caching. |
| `METRICS_ENABLED` | ❌ | `true` | Controls whether Prometheus metrics are collected and `/metrics` serves counters. |
| `AUDIT_PIPELINE_URL` | ❌ | _none_ | When set, enables the HTTP audit publisher targeting the audit pipeline (e.g., `https://audit-pipeline.internal`). |
| `AUDIT_PIPELINE_TOKEN` | ❌ | _none_ | Bearer token presented to the audit pipeline (`Authorization: Bearer …`). |
| `AUDIT_PUBLISHER_MAX_RETRIES` | ❌ | `2` | Retry attempts for audit delivery on transient failures (HTTP ≥500 or network errors). |
| `AUDIT_PUBLISHER_RETRY_DELAY_MS` | ❌ | `200` | Base delay (ms) for exponential backoff between audit retries. |
| `AUDIT_PUBLISHER_TIMEOUT_MS` | ❌ | `2000` | HTTP client timeout (ms) applied to audit pipeline requests. |

Replica deployments should also ensure the process has outbound connectivity to both the Consent Indexer and the target FHIR system.

## Running Locally

```powershell

# from repository root

pnpm install
pnpm --filter @ehr/ehr-gateway dev
```

Set up a `.env.local` inside `services/ehr-gateway` (or export env vars) with at least `CONSENT_INDEXER_URL`. During development, the gateway expects a running Consent Indexer service that exposes `/health` and `/consents`.

## Testing

Vitest is used for unit and integration-style tests.

```powershell
pnpm --filter @ehr/ehr-gateway test -- --run
```

Current coverage includes:

- PDP unit tests (`tests/consent-service.test.ts`) for consent evaluation edge cases (status, validity window, scope matching, identity fallback).
- Server route tests (`tests/server.test.ts`) covering health, readiness, and access decision responses.

## Observability

- **Audit events:** Every decision (permit or deny) produces an `access.decision.logged` JSON event with correlation ID, actor identity, latency, and blockchain provenance. Payloads are validated with the shared `@ehr/audit-schema` package before they leave the gateway. Events stream to stdout locally and, when `AUDIT_PIPELINE_URL` is configured, are forwarded to the audit pipeline via an authenticated HTTP client with retries.
- **Structured logs:** The gateway emits `decision.log` JSON lines that capture correlation ID, sanitized identifiers, decision, and reason for quick troubleshooting (no PHI).
- **Prometheus metrics:** When `METRICS_ENABLED` is true, `/metrics` exposes counters and histograms for PDP decisions, denial reasons (`no_active_consent`, `indexer_unreachable`, `invalid_input`, `internal_error`), consent indexer latency, cache efficiency (hits vs misses), and FHIR proxy throughput/latency (`fhir_proxy_requests_total`, `fhir_upstream_latency_ms`). Integrate the endpoint with scraping infrastructure for dashboards and alerts.

## Caching & Performance

- **In-memory PDP cache:** Access decisions reuse cached consent snapshots for up to 30 seconds per `(patientId, granteeId, scopeId)` key (configurable via `CONSENT_CACHE_TTL_MS`). Entries expire automatically, and a manual invalidation hook is available for future blockchain event triggers.
- **Cache observability:** `pdp_cache_hits_total` and `pdp_cache_misses_total` counters surface reuse efficacy and when the gateway falls back to the indexer.
- **TTL guardrail:** Custom TTLs can be configured (capped at 30 seconds) or disabled by setting the TTL to `0`.

## Extensibility Roadmap

- **FHIR Proxy Enforcement:** Replace the `/fhir/*` stub with a proxy that reuses the PDP result, adds request context, and forwards responses downstream.
- **Observability:** Continue wiring structured logs/metrics into the deployment stack and add end-to-end tracing once infrastructure is ready.
- **Caching:** Extend invalidation mechanisms to react to consent-change events from the indexer or blockchain, and explore distributed cache coordination for multi-instance deployments.
- **Auditing:** Emit audit events for granted/denied decisions to feed compliance reporting pipelines.
