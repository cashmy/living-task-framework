<!-- markdownlint-disable MD036 -->

# 🏗️ EHR Consent Platform — Conceptual Architecture v0.1

> **Purpose:** Establish a coherent conceptual foundation for the blockchain-enabled EHR Consent Management Platform, aligning the existing codebase layout, architectural intent, and early design decisions.

- --

## 1. System Context & Responsibilities

- *Actors**

- **Patient** – grants/revokes consent.
- **Provider/Clinic Staff** – requests access to patient data.
- **Admin** – oversees registry and compliance.
- **External EHR Systems** – communicate through FHIR interfaces.

- *Major Components**

Frontends: Patient Portal, Clinic Console, Admin Dashboard → EHR Gateway → Auth Service, Consent Indexer, Audit Pipeline → Blockchain (ConsentRegistry, ProviderIdentity, HospitalRegistry) → FHIR Server & S3 Archive.

- *High-level Responsibilities**

- **Frontends:** request or view consent; retrieve permitted data.
- **EHR Gateway:** policy enforcement and FHIR proxy/cache layer.
- **Auth Service:** unified OAuth2 provider; future SSO integration.
- **Consent Indexer:** synchronizes blockchain events for queryable off-chain state.
- **Audit Pipeline:** compliance and real-time analytics feed.
- **Blockchain Layer:** source of truth for consent and identities.
- **FHIR Server:** proxy/cache in phase one; potential full FHIR store later.

- --

## 2. Consent Model & Lifecycle

- *On-Chain (ConsentRegistry)**

- Records minimal but authoritative consent metadata:
  - `subject`, `grantee`, `scopeId`, `status`, `validFrom`, `validTo`.
- Revocation & expiry stored on-chain for verifiability.

- *Off-Chain (Policy Blob)**

- JSON or FHIR Consent resource defining detailed policy (resource types, duration, purpose).
- Stored in versioned, hash-verified object storage (e.g., S3).
- Hash (`scopeId`) links on-chain to off-chain policy.

- *Lifecycle**

1. **Create:** Patient initiates, system signs, transaction to `ConsentRegistry`, indexed by `Consent Indexer`.
2. **Use/Enforce:** Provider request → Gateway evaluates consent & roles → allow/deny/partial access.
3. **Revoke/Expire:** On-chain status update or time-based expiry → indexer refresh.
4. **Audit:** All actions logged immutably to S3.

- --

## 3. Access Decision Flow (PEP/PDP Split)

- **Policy Enforcement Point (PEP):** EHR Gateway.
- **Policy Decision Point (PDP):**
  - Checks on-chain consent validity.
  - Consults `ProviderIdentity` / `HospitalRegistry`.
  - Evaluates expanded policies in indexer database.
  - Considers FHIR resource metadata.

- *Result:** `Permit | Deny | Permit with redaction`.

- --

## 4. Authentication & Authorization

- Unified **OAuth2 Provider** issues tokens for all user and service roles:
  - `patient:*`, `provider:*`, `admin:*`, `system:*`.
- SSO integration planned (SMART on FHIR, Okta, AzureAD).
- **Consent-aware authorization:** token + consent evaluation = final access decision.

- --

## 5. Blockchain Interaction Model

- *To Be Designed Next**

Two operational models:

- **A. Patient Non-Custodial:** patient signs transactions via wallet.
- **B. Server Custodial/Hybrid:** backend signs on behalf of patient using pre-approved, off-chain attestations.

- *Multi-Chain Support (Confirmed)**

- Chain adapters abstracted through configuration.
- `Consent Indexer` supports multiple EVM-compatible L2s (Polygon, Arbitrum).
- SDKs read from configuration registry.

- --

## 6. Data, Schema & Storage Boundaries

- **PHI never on-chain.**
- Blockchain holds only references, hashes, and status.
- **S3 Archive:** immutable (WORM) log storage for compliance.
- **FHIR Server:** proxy/cache during phase one, later may become authoritative data source.

- --

## 7. SDK Design Intent

- *Capabilities**

- Authentication bootstrap.
- Contract read/write wrappers.
- Consent policy hashing tools.
- Indexer & Gateway clients.

- *Design**

- Lightweight, typed SDKs (JS & Python) with parity.
- Retries, backoff, and circuit-breaker patterns.

- --

## 8. Observability & Audit

- *Event Schema (v1):**

- `eventId`, `timestamp`, `actor`, `action`, `result`, `policyHash`, `chainRef`, `decisionInputs`.

- *Pipelines**

- Gateway emits structured events → Audit Pipeline → S3 archive.
- Optional Kinesis/Firehose → OpenSearch for real-time dashboards.

- --

## 9. Security &
