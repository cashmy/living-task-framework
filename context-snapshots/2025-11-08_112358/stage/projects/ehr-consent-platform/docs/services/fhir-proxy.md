# FHIR Proxy Service

## Overview

The FHIR Proxy is the enforcement plane that fronts the upstream FHIR server through the EHR Gateway. It accepts read-only FHIR requests, validates them against consent decisions, forwards permitted traffic to the configured upstream, and captures observability signals (audit events and Prometheus metrics). The proxy shares the same deployment footprint as the PDP, using the gateway process and configuration file set in `services/ehr-gateway`.

JWT validation is handled by the shared `@ehr/service-auth` package. The gateway imports the package's `createAuthenticationMiddleware`, which verifies broker-issued tokens via JWKS and places the resulting principal on `req.internalToken` for the proxy and PDP flows.

### Capabilities

- **Consent Enforcement:** Every inbound `GET /fhir/{ResourceType}` request is evaluated through the PDP before the proxy calls the upstream FHIR service.
- **Upstream Resilience:** Axios-based client with configurable timeout, retry, jitter, and circuit-breaker behaviour to protect downstream systems.
- **Telemetry:** Structured audit events, per-resource request counters, and upstream latency histograms wired to Prometheus.
- **Correlation:** Incoming `x-corr-id` headers are preserved end-to-end and automatically generated when missing.

## Request Flow

1. Client calls `GET /fhir/{ResourceType}` with standard FHIR query parameters. The proxy currently accepts `Observation` and `DiagnosticReport` by default (configurable).
2. The proxy extracts the `patient` search parameter (required) and an optional `grantee`/`granteeId`. Missing patient identifiers are rejected with `400 invalid_input`.
3. The PDP evaluates the request via `ConsentService.evaluateAccess`. Denied decisions return the PDP response (typically `403 no_active_consent`).
4. Granted decisions trigger a call to the upstream FHIR service (specified via `FHIR_BASE_URL`). Headers include `Accept`, propagated `Authorization`, and the correlation ID.
5. Responses stream back to the caller with upstream status codes and payloads. Timeouts become `504 upstream_timeout`; circuit-breaker trips surface as `503 upstream_unavailable`; other failures return `502 upstream_error`.

Each outcome emits a structured audit event with action `ehr.gateway.fhir.proxy` and records a metric via `fhir_proxy_requests_total` labelled by decision and resource type.

## REST Surface

| Method | Path | Purpose | Notes |
| --- | --- | --- | --- |
| `GET` | `/fhir/{ResourceType}` | Read-only FHIR proxy endpoint | Resources must exist in the configured allowlist. Requires `patient` query param. Returns upstream payloads verbatim on success. |

### Error Reference

| HTTP Status | Reason Code | Description |
| --- | --- | --- |
| `400` | `invalid_input` | Missing or malformed patient/grantee parameters, or PDP reports invalid input. |
| `403` | `no_active_consent` | Consent evaluation denies access. |
| `403` | `indexer_unreachable` | PDP cannot reach the consent indexer (fail-closed path). |
| `404` | `unsupported_resource` | Resource type not listed in the allowlist. |
| `502` | `upstream_error` | Upstream FHIR call returned a non-success status after retries. |
| `503` | `upstream_unavailable` | Circuit breaker open; includes `retryAfterMs` hint. |
| `504` | `upstream_timeout` | Upstream FHIR call exceeded configured timeout. |

## Configuration

Environment variables (parsed in `services/ehr-gateway/src/config.ts`) tailor proxy behaviour in addition to the PDP settings documented in `ehr-gateway.md`.

| Variable | Default | Description |
| --- | --- | --- |
| `FHIR_BASE_URL` | `http://localhost:8080/fhir` | Upstream FHIR server base URL. Must be `http` or `https`. Trimmed of trailing slash at startup. |
| `FHIR_ALLOWED_RESOURCES` (alias `ALLOWED_RESOURCES`) | `Observation,DiagnosticReport` | Comma-delimited list of resource types the proxy will serve. Entries must match `/^[A-Z][A-Za-z0-9]+$/`. |
| `FHIR_CLIENT_TIMEOUT_MS` | `5000` | Request timeout in milliseconds for upstream FHIR calls. Must be positive. |
| `FHIR_CLIENT_MAX_RETRIES` | `2` | Number of retry attempts when upstream responds with `5xx` or network errors. |
| `FHIR_CLIENT_RETRY_DELAY_MS` | `250` | Base delay (ms) between retries. |
| `FHIR_CLIENT_RETRY_JITTER_MS` | `250` | Maximum random jitter added to retry delay. |
| `FHIR_CLIENT_CIRCUIT_BREAKER_THRESHOLD` | `4` | Consecutive failures required to trip the circuit breaker. |
| `FHIR_CLIENT_CIRCUIT_BREAKER_RESET_MS` | `60000` | Cooldown period (ms) before the breaker half-opens and allows a new attempt. |

The readiness endpoint (`/ready`) exposes the normalized FHIR base URL and current allowlist via the `details.fhirProxy` payload to aid operational checks.

## Metrics

The proxy contributes additional telemetry on top of the PDP suite documented in `ehr-gateway-metrics.md`.

| Metric | Type | Labels | Description |
| --- | --- | --- | --- |
| `fhir_proxy_requests_total` | Counter | `decision`, `resource` | Counts proxy outcomes (permit/deny) per resource type. Useful for traffic mix and denial trends. |
| `fhir_upstream_latency_ms` | Histogram | `resource` | Measures upstream FHIR call latency in milliseconds. Buckets: `25, 50, 100, 200, 500, 1000, 2000, 5000`. |

Both metrics are exposed via `GET /metrics` when `METRICS_ENABLED` is truthy, alongside the PDP counters.

## Audit Events

- Action: `ehr.gateway.fhir.proxy`
- Decision: `permit` or `deny`
- Reason: Mirrors the response reason (`granted`, `no_active_consent`, `upstream_error`, etc.)
- Scope: Populated with the resource name used for evaluation.
- Consent: Included when PDP returns a matching consent and proxied response.

Audit events emit to the configured publisher (`ConsoleAuditPublisher` by default) and follow the schema described in `services/ehr-gateway/src/middleware/audit-logger.ts`.

## Testing

Vitest suites ensure enforcement and resiliency paths behave as expected.

- `tests/server.test.ts` – Unit coverage for proxy route validation, audit hooks, and error translation (including timeout and circuit-breaker cases).
- `tests/fhir-proxy.integration.test.ts` – Integration-style tests using synthetic FHIR fixtures from `qa/synthetic-data/fhir/Observation-bundle.json`. Scenarios cover permit, deny, upstream timeout (`504`), and circuit-breaker trip/recovery while asserting metrics and audit outputs.
- `tests/fhir-client.test.ts` – Validates retry, circuit-breaker, and timeout semantics of the upstream client.

Run with:

```powershell
pnpm --filter @ehr/ehr-gateway vitest run
```

## Future Enhancements

- Extend allowlist management to accept per-resource policy configuration and dynamic reloads.
- Add write-method guarding (POST/PUT/PATCH/DELETE) once business rules are defined.
- Integrate distributed tracing (e.g., OpenTelemetry) for upstream call chains.
- Emit richer audit contexts (FHIR request ID, response size) when required by compliance stakeholders.
