# Token Exchange API Purpose and Design

This document captures the intent, scope, and operating model for the Token Exchange API hosted by the auth-service. The API verifies external identity provider (IdP) tokens, returns normalized identity context plus derived authorization claims, and issues brokered internal JWTs trusted by downstream services.

## Objectives

- Accept tokens issued by trusted IdPs (HS256 shared-secret or RS256/ES256 via JWKS) and validate issuer, signature, and audience.
- Normalize external identity hints into an internal representation (`externalSubjectId`, `email`, `walletAddress`).
- Invoke the `ClaimMapper` to enrich responses with platform-specific roles, scopes, and organization metadata.
- Mint a short-lived internal JWT containing brokered claims and external context for downstream verification.
- Provide deterministic error semantics so frontends and partner services can react to verification failures or configuration gaps.

## Supported Use Cases

- Exchanging a social or enterprise login token for brokered claims used by downstream JWT issuance.
- Allowing clinic consoles or patient portals to retrieve current role/scope information before requesting an internal session token.
- Enabling service-to-service identity delegation flows where a partner system presents a signed JWT for verification.

## Non-Goals

- Acting as a generic OAuth authorization server or refresh token endpoint.
- Managing long-lived provider metadata; JWKS caches are ephemeral and regenerated on restart.

## High-Level Flow

1. Client submits `POST /auth/token/exchange` with `{ provider, token }`.
2. The Token Exchange Service selects the configured verifier for the provider (HS256 or JWKS-backed).
3. External token is verified (issuer, audience, signature, expiry). JWKS providers support metadata discovery and cached key retrieval.
4. Verified payload is normalized into a `NormalizedIdentity` structure.
5. `ClaimMapper` joins patient directory data with consent-indexer projections to derive role, scopes, org identifiers, and metadata.
6. Response returns derived claims, normalized identity hints, a signed internal JWT, and the raw external payload for auditing.

## Endpoint Contract

- **Route**: `POST /auth/token/exchange`
- **Body**:
  - `provider` (string, required): Matches the configured provider name.
  - `token` (string, required): External JWT (ID token or access token) to validate.
- **Success (`200 OK`)**:

  ```json
  {
    "ok": true,
    "token": {
      "value": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImtpZC0xIn0...",
      "issuedAt": "2025-11-02T16:12:00.000Z",
      "expiresAt": "2025-11-02T16:27:00.000Z",
      "expiresInSeconds": 900,
      "jti": "2bfcf1d6-41b1-4c0b-8cf2-69e0c517e226",
      "kid": "kid-1"
    },
    "claims": {
      "subject": "0xtester",
      "role": "provider",
      "scopes": ["provider:request-consent"],
      "patientId": null,
      "orgId": "0xhospital",
      "providerAddress": "0xtester",
      "metadata": {
        "membershipEpoch": 1700000000
      }
    },
    "identity": {
      "externalSubjectId": "user-123",
      "email": "user@example.com",
      "walletAddress": "0xtester"
    },
    "external": {
      "provider": "enterprise",
      "subject": "user-123",
      "email": "user@example.com",
      "payload": {
        "iss": "https://example.okta.com/oauth2/default",
        "aud": "ehr-auth",
        "exp": 1730000000,
        "sub": "user-123"
      }
    }
  }
  ```

- **Unauthorized (`401 Unauthorized`)**: `{ "ok": false, "error": "token_verification_failed" }`
- **Unconfigured Provider (`422 Unprocessable Entity`)**: `{ "ok": false, "error": "provider_not_configured" }`
- **Validation Error (`400 Bad Request`)**: `{ "ok": false, "error": "invalid_request" }`

## Refresh Endpoint

- **Route**: `POST /auth/token/refresh`
- **Body**:
  - `token` (string, required): Previously issued internal JWT to refresh.
- **Success (`200 OK`)**:

  ```json
  {
    "ok": true,
    "token": {
      "value": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImtpZC0xIn0...",
      "issuedAt": "2025-11-02T16:27:00.000Z",
      "expiresAt": "2025-11-02T16:42:00.000Z",
      "expiresInSeconds": 900,
      "jti": "d91e6a3d-44ad-4a36-9cff-394775b3a2d9",
      "kid": "kid-1"
    },
    "claims": {
      "subject": "0xtester",
      "role": "provider",
      "scopes": ["provider:request-consent"],
      "patientId": null,
      "orgId": "0xhospital",
      "providerAddress": "0xtester",
      "metadata": {
        "membershipEpoch": 1700000001
      }
    },
    "identity": {
      "externalSubjectId": "user-123",
      "email": "user@example.com",
      "walletAddress": "0xtester"
    },
    "external": {
      "provider": "enterprise",
      "subject": "user-123",
      "email": "user@example.com",
      "payload": {
        "iss": "https://example.okta.com/oauth2/default",
        "aud": "ehr-auth"
      }
    },
    "previous": {
      "jti": "2bfcf1d6-41b1-4c0b-8cf2-69e0c517e226",
      "issuedAt": "2025-11-02T16:12:00.000Z",
      "expiresAt": "2025-11-02T16:27:00.000Z"
    }
  }
  ```

- **Invalid Token (`401 Unauthorized`)**: `{ "ok": false, "error": "invalid_token" }`
- **Inactive Token (`401 Unauthorized`)**: `{ "ok": false, "error": "token_inactive" }`

## Configuration

Providers are defined via the `TOKEN_EXCHANGE_PROVIDERS` environment variable (JSON array) or the mock HS256 settings used in local development.

| Field | Description |
| --- | --- |
| `name` | Provider identifier used in the API request. |
| `issuer` | Expected JWT issuer value. |
| `audience` | Expected audience claim. |
| `algorithm` | `HS256`, `RS256`, or `ES256`. |
| `secret` | Shared secret (HS256 only). |
| `jwksUri` | Direct JWKS endpoint (RS/ES). Optional when `metadataUrl` is present. |
| `metadataUrl` | OpenID discovery document used to resolve `jwks_uri`. |
| `jwksCacheSeconds` | Optional TTL for cached JWKS keys. |

### Provider Shortcuts

- `GOOGLE_CLIENT_ID` registers a ready-to-use `google` provider that validates Google ID tokens via the public discovery document. Override behaviour with `GOOGLE_OIDC_AUDIENCE`, `GOOGLE_OIDC_METADATA_URL`, `GOOGLE_OIDC_JWKS_URI`, `GOOGLE_OIDC_PROVIDER_NAME`, or `GOOGLE_OIDC_JWKS_CACHE_SECONDS`.
- `ENTERPRISE_OIDC_ISSUER` + `ENTERPRISE_OIDC_CLIENT_ID` register a generic `enterprise` provider. Optional overrides: `ENTERPRISE_OIDC_PROVIDER_NAME`, `ENTERPRISE_OIDC_AUDIENCE`, `ENTERPRISE_OIDC_METADATA_URL`, `ENTERPRISE_OIDC_JWKS_URI`, `ENTERPRISE_OIDC_ALGORITHM`, and `ENTERPRISE_OIDC_JWKS_CACHE_SECONDS`.

When `TOKEN_EXCHANGE_PROVIDERS` is empty, providing `MOCK_TOKEN_EXCHANGE_SECRET` registers a local `mock` HS256 provider for development.

## Internal Components

- **TokenExchangeService**: Coordinates provider selection, token verification, identity normalization, and claim derivation.
- **HS256 Verifier**: Uses the configured shared secret to validate tokens with `jose.jwtVerify`.
- **JWKS Verifier**: Fetches JWKS keys (direct URI or via metadata discovery), caches them with optional TTL, and refreshes on key mismatch.
- **ClaimMapper**: Combines patient directory and consent-indexer projections to output role, scopes, org metadata, and audit flags.
- **InternalTokenService**: Signs the internal JWT, embeds derived claims plus external context, and exposes JWKS metadata.
- **Fastify Route Handler**: Validates request body, invokes the services, and shapes HTTP responses with deterministic error codes.
- **JWKS Endpoint**: `GET /auth/.well-known/jwks.json` delivers the active signing key for downstream verification.

## Operational Considerations

- **Security**: Restrict provider list to trusted IdPs. Secrets or JWKS URLs should be managed via environment configuration with least privilege.
- **Caching**: JWKS keys are cached in-memory; configure `jwksCacheSeconds` to balance rotation responsiveness and network usage.
- **Observability**: Emit metrics for verification successes/failures (e.g., `auth_token_exchange_total{provider,status}`) and log errors with correlation IDs.
- **Error Handling**: Distinguish between verification failures (401) and configuration or upstream issues (422/502). JWKS fetch failures surface as 502 with retry guidance.
- **Rate Limiting**: Front door services should enforce throttling to prevent brute-force attempts against the exchange endpoint.
- **Auditing**: Successful exchanges persist metadata in the `issued_tokens` table and emit `auth.token_issued`; verification failures emit `auth.token_denied` for downstream correlation.
- **Revocation**: Admins can POST to `/admin/tokens/:jti/revoke` with an optional reason to persist revocation state and emit `auth.token_revoked` for audit trails.
- **Refresh**: Refreshing a token re-derives claims, stores a new row annotated with `refreshedFrom`, and emits `auth.token_issued` with `refreshOf` metadata, allowing services to correlate session extensions.

## Testing Strategy

- Unit tests for TokenExchangeService covering HS256 verification, unconfigured provider errors, and JWKS discovery flows.
- Route-level tests to ensure Fastify handler validates input and returns standardized JSON shapes.
- Internal token unit tests verifying claim propagation and JWKS metadata (`tests/internal-token.test.ts`).
- Integration smoke tests hitting a sandbox IdP (when available) to validate end-to-end configuration.

## Future Enhancements

- Support additional algorithms (e.g., PS256) and mutual TLS-bound access tokens if required by partners.
- Expose JWKS fetch metrics and health checks for proactive monitoring of provider metadata availability.
