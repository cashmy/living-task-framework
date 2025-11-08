<!-- markdownlint-disable MD036 -->

# 🎯 Goal — Milestone 5 Auth (Hybrid + Brokered)

- *Purpose:**

Implement a hybrid authentication model that accepts social or enterprise OAuth for usability, then routes identities through an internal Identity Broker which verifies the external token and issues a HIPAA-compliant internal JWT with scoped claims. Backend services trust only the brokered token. This builds on the repo’s planned auth-service and existing gateway/service boundaries.

## 🧩 Why It Matters

1. Compliance by Design: External IdPs (Google, Microsoft, Okta) are convenient, but backend must not rely on their tokens directly; the broker enforces least privilege and PHI-safe claims.
2. Role & Scope Governance: Central place to derive role=patient/provider/admin/system and consent/organization scopes.
3. Uniform Trust Model: All services (Gateway, Indexer, Proxy, Audit) validate a single internal JWT and verification key.
4. Future Extensibility: Paves the way for SSO federation and fine-grained scopes without changing downstream services.

## 🏗️ Scope & Deliverables

| Component | Deliverable | Description |
|--------------|--------------|-------------|
| Identity Broker (auth-service) | Token Exchange Endpoint | Accept external OAuth tokens; verify, normalize identity, issue internal JWT with claims. (Service exists in repo plan.) |
| Provider Integrations | Social & Enterprise OAuth | Support at least Google and OIDC enterprise providers in dev; wire secrets via env. (NEXTAUTH/SSO hooks referenced in env.) |
| Internal JWT | Signed, short-lived token | RS256 or ES256; embedded claims: sub, role, orgId?, granteeId?, scopes[], iat, exp, jti. |
| Service AuthN/Z | Trust boundary | Gateway, FHIR Proxy, Indexer, Audit only accept internal JWT; external tokens rejected. |
| Audit Hooks | Login & Exchange events | Log auth.login, auth.token_issued, auth.token_denied, auth.token_revoked to Audit Pipeline (M4). |
| Ops & Keys | KMS/Key Rotation | Key pair management, rotation schedule, JWKS endpoint for public keys. |

## 🔄 Data Flow Overview (Hybrid + Brokered)

```pgsql
Client → (Social/Enterprise OAuth) → External IdP
      ← OAuth Access / ID Token
Client → Auth-Service /token/exchange (presents external token)
Auth-Service → Verify external token (issuer, audience, signature, expiry)
Auth-Service → Build internal claims (role/scopes/org/grantee)
Auth-Service → Issue internal JWT (RS256/ES256) + record audit
Client → Calls Gateway/Services with internal JWT (Bearer)
Gateway/Services → Verify internal JWT (JWKS) → authorize
```

## ⚙️ Implementation Tasks

- *AUTH-0 – Patient Directory & Onboarding** -- PARTIAL

- ✅ Patient directory service (auth-service) delivering invite/activate/revoke flows with Fastify endpoints backed by Postgres.
- ✅ Audit emitter hooks in place for invite/activate/revoke/referral actions and covered by unit tests.
- ✅ Patient-initiated referral flow captured in `provider_referrals`, exposing pending referral listings for admins.
- ⏳ Remaining: hook patient directory cache refresh into the brokered claim derivation flow.
- ⏳ Remaining: finish audit pipeline configuration for production environments.

- *AUTH-1 – Token Exchange API** -- COMPLETE

- ✅ `POST /auth/token/exchange` accepts `{ provider, token }` and returns derived broker claims.
- ✅ HS256 verification implemented via static provider configuration with shared secrets; integrates `ClaimMapper` for role/scope derivation.
- ✅ RS256/ES256 providers supported via JWKS discovery (metadata or explicit URI) with cached key material.

- *AUTH-2 – Claim Derivation & Policy Mapper** -- PARTIAL

- ✅ Consent indexer now projects `ProviderIdentity` and `HospitalRegistry` events into Postgres tables (`providers`, `hospitals`, `hospital_memberships`) and exposes lookup APIs for auth-service.
- ✅ `ClaimMapper` in auth-service combines patient directory records with registry projections to derive roles (`patient`, `provider`, `admin`, `guest`) and scopes.
- ✅ Claim derivation now feeds the token exchange response, exposing role/scopes/org metadata for clients.
- ✅ Added a dedicated `token-exchange-api.md` doc covering external token verification, claim derivation, and configuration guidance.
- ⏳ Remaining: emit derived context into issued JWTs and surface org/grantee scopes to downstream services.

- *AUTH-3 – Internal JWT Issuance** -- COMPLETE

- ✅ Broker now signs internal JWTs (RS256/ES256) with configurable TTL and includes derived claims plus external context.
- ✅ `/auth/.well-known/jwks.json` serves the active signing key for downstream verification.
- ✅ Issued token metadata is persisted in Postgres (`issued_tokens`) and audit events `auth.token_issued` / `auth.token_denied` are emitted.
- ✅ Admin revocation endpoint (`POST /admin/tokens/:jti/revoke`) records revocations and emits `auth.token_revoked`.
- ✅ Refresh endpoint (`POST /auth/token/refresh`) verifies internal JWTs, re-derives claims, issues new tokens, and annotates audit events with `refreshOf` context.

- *AUTH-4 – Service Gatekeeping**

- ✅ Gateway now validates Auth Service-issued JWTs via JWKS, rejects missing/invalid tokens, and injects the authenticated subject into PDP/PEP flows.
- ✅ Introduced the shared workspace package `@ehr/service-auth` containing the reusable verifier and Express middleware that attach principals to `req.internalToken`.
- ✅ Proxy, Indexer, and Audit services now depend on `@ehr/service-auth` and reject external tokens via shared middleware/hooks.

- *AUTH-5 – Providers**

- ✅ Google OIDC provider registered automatically when `GOOGLE_CLIENT_ID` is present (uses Google discovery metadata by default).
- ✅ Generic OIDC provider registered from `ENTERPRISE_OIDC_*` environment variables (name, issuer, audience, JWKS overrides).
- ✅ Environment-driven configuration matches the NextAuth secret pattern, stubbing Google OIDC for local development without editing JSON.

- *AUTH-6 – Audit & Metrics**

- Emit events: auth.login, auth.token_issued, auth.token_denied, auth.token_revoked.
- Counters: auth_token_issued_total{provider=...}, auth_denied_total{reason=...}.

- *AUTH-7 – Keys & Rotation**

- Generate key pair; publish JWKS; implement rotation schedule and grace period.
- Prototype an automated rotation flow (e.g., scheduled job + overlapping JWKS entries).

- *AUTH-8 – Docs & Onboarding**

- Developer doc: how to add a new IdP; env var matrix; example cURL.

## 🧠 Technical Considerations

- Zero Trust to External Tokens: Services never accept Google/Okta tokens directly—only internal JWTs.
- Short TTL + Refresh: Reduce blast radius; use refresh tokens with extra checks (IP/UA).
- Multi-Tenant Readiness: Keep orgId in claims for routing / future residency policies.
- Scopes vs Roles: Prefer scopes for enforcement, roles for UI gates.
- Registry Read Model: Treat on-chain registries as canonical, but serve broker decisions from the indexer-projected Postgres tables to keep lookups fast while retaining cryptographic authority.
- Key Management: JWKS with kid; rotate every N days; keep last k keys active.
- PII Minimization: Do not pack PHI/PII into tokens; store references server-side.
- Configuration: Centralize provider config via env (consistent with existing env patterns).

## ✅ Acceptance Criteria

- Exchange flow works: External OAuth token → internal JWT with correct claims.
- Service boundary enforced: Gateway/Proxy/Indexer/Audit reject non-internal tokens.
- JWKS served & used: Services validate signature and aud/iss/exp.
- Audit events present: auth.login, auth.token_issued, auth.token_denied, auth.token_revoked visible in M4 pipeline; refresh extensions emit `auth.token_issued` with `refreshOf` metadata.
- Metrics exposed: token issuance/denial counters; auth latency histogram.
- Docs ready: Example for Google OIDC and Generic OIDC (enterprise).
- Tests passing: Unit tests for token verification & claim mapping; integration tests for full exchange.

## 🧭 Integration Points

- Gateway & FHIR Proxy: Use internal JWT to derive granteeId and enforce PDP/PEP decisions (already expecting identity context).
- Audit Pipeline (M4): Receive auth events; store immutable records.
- Frontends: Patient Portal & Clinic Console use social/enterprise login, then exchange for internal JWT before API calls (endpoints defined in README access points).

## Milestone 5 Summary

M5 introduces a brokered identity layer: users log in with familiar IdPs; the auth-service converts that identity into a HIPAA-compliant internal JWT with scoped claims that your services trust. This creates a uniform, compliant foundation for PDP/PEP enforcement, auditing, and future SSO federation.
