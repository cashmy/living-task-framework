<!-- markdownlint-disable MD036 -->

# 🚧 Roadmap — POC → MVP (Contracts → Off-chain → FHIR → UX)

> Repo structure confirmed (contracts, services, frontends, sdk, infra, qa, scripts). This plan lands a working POC first, then hardens toward an MVP in measured increments. :contentReference[oaicite:1]{index=1}

## Milestone Map

- **M0. Environments & Skeletons (D0–D2) -- DONE**
- **M1. Smart Contracts v1 (Wk1) -- DONE**
- **M2. Consent Indexer & DB (Wk2) -- DONE**
- **M3. EHR Gateway (PEP/PDP) + FHIR Proxy (Wk3) -- PARTIAL**
- **M4. Audit Pipeline → S3 (Wk3, parallel) -- PARTIAL**
- **M5. Auth Service (Unified OAuth2) (Wk4)**
- **M6. UX POCs: Patient Portal & Clinic Console (Wk4–Wk5)**
- **M7. SDKs (JS & Python) lightweight (Wk5, parallel)**
- **M8. Hardening toward MVP (Wk6+) -- PARTIAL**

- --

## M0 — Environments & Skeletons (Day 0–2) -- DONE

- *Goals**

- Local dev starts cleanly with one command; everyone can build, run, and smoke-test.
- Lock workspace wiring to existing folders: `contracts/`, `services/`, `frontends/`, `sdk/`, `infra/`, `qa/`, `scripts/`. :contentReference[oaicite:2]{index=2}

- *Tasks**

- Ensure `docker-compose` brings up: local EVM, Postgres, FHIR server.
- Verify `pnpm` workspaces (`pnpm-workspace.yaml`) and `turbo.json` pipeline.
- Add a root **smoke** script that pings Gateway health and lists chain height.

- *Acceptance**

- `pnpm dev` runs services/frontends; smoke passes.

- --

## M1 — Smart Contracts v1 (Week 1) -- DONE

- *Why first**

- Defines the source of truth and stable events the rest of the stack consumes.

- *Scope**

- `contracts/src/ConsentRegistry.sol`
  - Minimal fields: `subject`, `grantee`, `scopeId`, `status(active|revoked)`, `validFrom`, `validTo`.
  - Events: `ConsentCreated`, `ConsentRevoked`, `ConsentExpired`.
- Optional stubs (interfaces only) for `ProviderIdentity` / `HospitalRegistry` to keep deployment simple now (full verification later).
- Scripts under `contracts/scripts/` for deploy to local chain; tests in `contracts/test/`. :contentReference[oaicite:3]{index=3}

- *Acceptance**

- Local deploy address + ABI exported to `services/consent-indexer` and `sdk`.

- --

## M2 — Consent Indexer & DB (Week 2) -- DONE

- *Scope**

- `services/consent-indexer/`
  - Consume chain events → write Postgres tables:
    - `consents(patientId, granteeId, scopeId, status, validFrom, validTo, txHash, blockNo)`
  - Idempotency via `(blockNo, logIndex)`; handle reorgs.
  - Read API: `GET /consents?patient=..&grantee=..`.

- *Acceptance**

- Event arrives on chain → visible via Indexer API within seconds.
- Basic unit/integ tests; synthetic fixtures in `qa/synthetic-data/`. :contentReference[oaicite:4]{index=4}

- --

## M3 — EHR Gateway (PEP/PDP) + FHIR Proxy (Week 3) -- PARTIAL

- *Scope**

- `services/ehr-gateway/`
  - PDP queries Indexer; denies unless active consent matches.
  - PEP proxies selected FHIR reads (Phase 1: `Observation`, `DiagnosticReport`) to local FHIR server; cache TTL only (no PHI persisted).
- Config driven endpoints; start with the dev FHIR server defined in repo. :contentReference[oaicite:5]{index=5}

- *Acceptance**

- With consent active, FHIR GET via Gateway returns; otherwise 403/denied.
- Access decision includes a correlation ID for audit.

- --

## M4 — Audit Pipeline → S3 (Week 3, parallel) -- PARTIAL

- *Scope**

- `services/audit-pipeline/`
  - Consume decision events from Gateway and write to S3 (Object Lock/WORM).
  - Event schema v1: `eventId`, `ts`, `actor`, `requester`, `action`, `result`, `policyHash`, `chainRef`, `corrId`.

- *Acceptance**

- 100% of Gateway decisions observed in S3 within a few seconds.
- Daily counts dashboard (simple CLI or SQL/Athena) available.

- --

## M5 — Auth Service (Unified OAuth2) (Week 4)

- *Scope**

- `services/auth-service/`
  - Persona scopes: `patient:*`, `provider:*`, `admin:*`, `system:*`.
  - Frontends & services validate tokens; Gateway checks scopes + consent.
- Keep SSO federation for later; document hooks for SMART/Okta.

- *Acceptance**

- End-to-end flows require tokens; unauthorized calls are blocked.

- --

## M6 — UX POCs (Week 4–5)

- *Patient Portal POC** (`frontends/patient-portal/`)

- Create consent (select provider + scope + duration).
- View/revoke consent; see “recent access” summary.

- *Clinic Console POC** (`frontends/clinic-console/`)

- Request consent from a patient (creates `REQUESTED` state).
- Track statuses: `REQUESTED`, `ACTIVE`, `DENIED`.

- *Acceptance**

- Click-through demo: provider requests → patient approves → provider fetches permitted resource through Gateway.

- --

## M7 — SDKs (Week 5, parallel)

- *Scope** (`sdk/js-sdk`, `sdk/py-sdk`)

- Lightweight wrappers: auth bootstrap, contract read/write, policy hash helper, Indexer & Gateway clients.
- Examples under `sdk/examples/`:
  - `createConsent.ts/py`, `revokeConsent.ts/py`, `fetchIfPermitted.ts/py`. :contentReference[oaicite:6]{index=6}

- *Acceptance**

- Example scripts run against local stack; README instructions added.

- --

## M8 — Hardening → MVP (Week 6+) -- PARTIAL

- *Contract & Workflow**

- Add dual-initiation states to `ConsentRegistry`: `Requested, Active, Denied, Revoked, Expired`.
- Off-chain **Provider Verification** table (stub) pending full `ProviderIdentity` anchor.

- *Gateway & Indexer**

- Rate-limits, input validation, correlation IDs, backoff/retries.
- Event bus (Kafka/Redpanda) for `consent.*` and `access.*` topics (REST/gRPC remain as fallbacks).

- *Compliance & Residency**

- HIPAA now; config flags for GDPR later (region routing + retention knobs).
- Audit log legal holds.

- *Acceptance**

- Load/smoke runs stable; basic resiliency verified (restart indexer, replay logs, etc).

- --

## Issue Templates & Labels

- Use GitHub Issues in this repo (`Issues` tab) and create labels:
  - `M0` … `M8`, `contracts`, `indexer`, `gateway`, `fhir`, `auth`, `audit`, `sdk`, `frontend`, `infra`, `qa`.
- Add issue templates: **Feature**, **Task**, **Bug**, **ADR**.
- Create a Project board (“POC→MVP”) to visualize milestones. (Repo has Projects available.) :contentReference[oaicite:7]{index=7}

- --

## Immediate Issue Backlog (create now)

- *M1 Contracts**

- CONS-1: ConsentRegistry v1 (events, fields, tests).
- CONS-2: Deploy script & ABI export to `services` and `sdk`.

- *M2 Indexer**

- IDX-1: Postgres schema v1; migrations.
- IDX-2: Event consumer (idempotent, reorg-safe).
- IDX-3: `/consents` read API + tests.

- *M3 Gateway/FHIR**

- GW-1: PDP allow/deny using Indexer.
- GW-2: FHIR proxy routes for `Observation` + `DiagnosticReport`.
- GW-3: Health & readiness endpoints.

- *M4 Audit**

- AUD-1: Event schema v1; writer to S3 WORM.
- AUD-2: Daily counts report.

- *M5 Auth**

- AUTH-1: OAuth2 scopes & token issuance.
- AUTH-2: Gateway token verification middleware.

- *M6 Frontends**

- PP-1: Create/View/Revoke consent.
- CC-1: Request consent; status list.

- *M7 SDK**

- SDK-JS-1 / SDK-PY-1: minimal clients + examples.

- --

## Notes

- Keep **PHI off-chain**; only hashes/refs on chain.
- Prefer **event-driven** internally as you harden, with REST/gRPC as pragmatic fallbacks.
- Document decisions as **ADRs** in `/docs/architecture/adr/`.

- --

## Addendum (Status update as of 11/2/2026)

With M1–M4 landed and M5 scoped, the core backend story is mostly there once we build the auth-service broker (patient directory, claim mapper, token issuance, JWKS, service hardening). After that you’re basically ready for end-to-end wiring—but a few substantial items will still be pending before a full slice is “done”:

- Auth-service implementation: token exchange, claim derivation against the registry/patient projections, internal JWT signing, refresh/rotation, audit/metrics, plus updates to every service to enforce the new trust boundary. Nothing’s coded yet; that’ll be the bulk of M5.
- Real storage integration: audit pipeline still uses mock S3; we’ll need the actual AWS client, prefix scanning, and configuration when the credentials land (even though the Compliance API is stubbed for it).
- On-chain and indexer plumbing: provider/patient read models depend on registry events; we’ll need to ensure the indexer publishes them and the auth-service can consume the projection.
- Environment/ops: secrets management, CI/CD, infrastructure for the new auth components (keys, KMS, JWKS hosting, cron jobs for rotation).
- Frontends: all three apps still need to hook the login flow and start using the internal JWT; they’re untouched so far.
- E2E testing & hardening: once auth is in place we’ll want integration suites that cover the full workflow (login → consent → FHIR access → audit).

So the plan is solid, but milestone 5 is still a sizable block of work, and there are operational pieces (real S3, rotation automation, infra) that have to follow. Nothing obvious is missing from the roadmap; it’s mainly execution on the auth broker plus the remaining integration work.
