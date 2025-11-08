# ConsentRegistry Contract Reference

## Purpose

`ConsentRegistry` stores minimal consent state on-chain so downstream services and auditors can prove when a patient authorized access. Each consent record links a `subject`, `grantee`, and off-chain `scopeId` for policy expansion. No PHI is persisted on-chain; detailed policy documents remain off-chain and are connected via `scopeId` hashes or identifiers.

## Data Model

| Field | Type | Description |
| --- | --- | --- |
| `Consent.subject` | `address` | Patient wallet that created the consent. |
| `Consent.grantee` | `address` | Provider or system allowed to access data. |
| `Consent.scopeId` | `bytes32` | Hash or ID for the consent policy stored off-chain. |
| `Consent.validFrom` | `uint64` | Start of the consent window. Defaults to `block.timestamp` when `0` is provided. |
| `Consent.validTo` | `uint64` | End of the consent window, must be greater than `validFrom`. |
| `Consent.status` | `ConsentStatus` | Enum: `None`, `Active`, `Revoked`, `Expired`. Only `Active` consents authorize access. |

Records are keyed by `consentId` (`bytes32`), which should be generated off-chain using a deterministic scheme (e.g., hash of `subject`, `grantee`, `scopeId`, and nonce).

## Events

| Event | When | Notes |
| --- | --- | --- |
| `ConsentCreated(consentId, subject, grantee, scopeId, validFrom, validTo)` | When a consent is first registered. | Gateway/indexer ingest this event to mirror state. |
| `ConsentRevoked(consentId, subject, grantee, revokedAt)` | When the subject revokes an active consent. | Emitted only if the revocation occurs before the validity window closes. |
| `ConsentExpired(consentId, subject, grantee, expiredAt)` | When anyone marks an out-of-window consent as expired. | Off-chain automation or providers can trigger expiry. |

## Errors

- `ConsentAlreadyExists(consentId)` – attempting to create a consent that is already initialized.
- `InvalidConsentParameters()` – zero `grantee` or `scopeId` supplied.
- `InvalidConsentWindow()` – invalid `validFrom`/`validTo` combination or premature expiry attempt.
- `ConsentNotActive(consentId)` – operations that require an active consent encountered a non-active record.
- `UnauthorizedSubject(caller, subject)` – caller tried to revoke a consent created by another subject.

## Public Functions

| Function | Caller | Description |
| --- | --- | --- |
| `createConsent(consentId, grantee, scopeId, validFrom, validTo)` | Patient (`msg.sender`). | Writes a new consent. `validFrom` defaults to current block when `0`. Emits `ConsentCreated`. |
| `revokeConsent(consentId)` | Patient | Revokes an active consent. If the consent already expired, the call emits `ConsentExpired` and reverts with `ConsentNotActive`. |
| `markExpired(consentId)` | Any caller | Marks an active consent as expired once `block.timestamp > validTo`. Emits `ConsentExpired`. |
| `getConsent(consentId)` | View | Returns the stored `Consent` struct. |
| `isActive(consentId)` | View | Returns `true` only when `status == Active` and the current block time is within `[validFrom, validTo]`. |

## Typical Workflow

1. **Create** – Patient generates a deterministic `consentId`, signs, and calls `createConsent`. Indexer records the `ConsentCreated` event and expands policy metadata off-chain.
2. **Enforce** – Gateway checks `isActive(consentId)` (or reads the struct) before serving data. Off-chain PDP layers validate the same `scopeId` against policy blobs.
3. **Revoke** – Patient calls `revokeConsent`. Off-chain systems stop honoring the consent immediately after the event is observed.
4. **Expire** – Automation watches `validTo` and calls `markExpired` to push the chain to `Expired` status for auditing. Patients or providers can also trigger this manually.

## Integration Notes

- `consentId` collisions are prevented off-chain. Use a salted hash that includes the patient identifier to maintain determinism while protecting against replay.
- The contract does not store consent content. Persist policy documents (FHIR Consent, JSON blob, etc.) in the indexer or object storage and reference them by `scopeId`.
- Status transitions are one-way: `None → Active → (Revoked | Expired)`. Reactivation requires creating a new record.
- Off-chain services should subscribe to events and reconcile storage using the struct getters for correctness (e.g., after reorgs).
