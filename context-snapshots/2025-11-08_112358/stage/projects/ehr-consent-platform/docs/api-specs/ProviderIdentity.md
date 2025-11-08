# ProviderIdentity Contract Reference

## Purpose

`ProviderIdentity` anchors verification state for individual clinicians and service accounts on-chain. It records deterministic identifiers, decentralized identifiers (DIDs), credential metadata, and organizational affiliations so the EHR Gateway and Indexer can enforce access policies only for trusted providers. The contract coordinates with `HospitalRegistry` to ensure memberships remain in sync before verification.

## Data Model

| Field | Type | Description |
| --- | --- | --- |
| `Provider.identifierHash` | `bytes32` | Stable hash (e.g., NPI or license) used for deduplication without exposing raw identifiers. |
| `Provider.did` | `string` | Decentralized identifier or directory handle for the provider. |
| `Provider.credentialURI` | `string` | Optional URI to extended credential metadata (JSON, IPFS, etc.). |
| `Provider.credentialHash` | `bytes32` | Latest attestation or credential hash captured during verification. |
| `Provider.organization` | `address` | Associated hospital/clinic in `HospitalRegistry` (optional for independent providers). |
| `Provider.status` | `VerificationStatus` | Enum: `None`, `Pending`, `Verified`, `Suspended`, `Revoked`. Only `Verified` providers are trusted. |
| `Provider.attestedBy` | `address` | Operator that last verified the provider. Cleared when status exits `Verified`. |
| `Provider.createdAt` | `uint64` | Block timestamp when the record was first created. |
| `Provider.updatedAt` | `uint64` | Timestamp of the most recent change. |

## Events

| Event | When | Notes |
| --- | --- | --- |
| `AdminTransferred(previousAdmin, newAdmin)` | Admin rotates to a new address. | Supports secure key rollover. |
| `RegistryOperatorUpdated(operator, allowed)` | Admin grants or revokes operator privileges. | Operators manage provider entries. |
| `HospitalRegistryUpdated(registry)` | Admin points to the active `HospitalRegistry` instance. | Required for organization validation. |
| `ProviderRegistered(provider, identifierHash, did, organization)` | Provider record created with `Pending` status. | Captures baseline metadata. |
| `ProviderProfileUpdated(provider, identifierHash, did, credentialURI, updatedAt)` | Profile fields refreshed. | Identifier hash cannot be empty. |
| `ProviderOrganizationUpdated(provider, organization, updatedAt)` | Affiliation updated. | Organization must exist when supplied. |
| `ProviderStatusUpdated(provider, status, attestedBy, credentialHash, updatedAt)` | Verification status or credential hash changed. | When status becomes `Verified`, membership is revalidated and `attestedBy` is set. |

## Errors

- `Unauthorized()` – Caller lacks admin/operator permission for a mutating action.
- `ProviderAlreadyRegistered(provider)` – Duplicate registration attempt.
- `ProviderNotRegistered(provider)` – Requested provider record does not exist.
- `InvalidAddress(field)` – Zero address supplied where not allowed.
- `InvalidStringField(field)` – Required string input was empty.
- `InvalidIdentifierHash()` – `identifierHash` zero value supplied.
- `InvalidStatus(status)` – Attempted to set status to `None`.
- `HospitalRegistryNotSet()` – Organization touching logic called before linking a hospital registry.
- `OrganizationNotFound(organization)` – Affiliation references a hospital that is not registered.
- `OrganizationMembershipInactive(organization, provider)` – Verification attempted without an active membership in `HospitalRegistry`.

## Public Functions

| Function | Caller | Description |
| --- | --- | --- |
| `admin()` | View | Returns the current admin address. |
| `transferAdmin(newAdmin)` | Admin | Reassigns the admin role. |
| `setRegistryOperator(operator, allowed)` | Admin | Grants or revokes operator privileges. |
| `setHospitalRegistry(registry)` | Admin | Sets the associated `HospitalRegistry` contract used for validation. |
| `registerProvider(provider, identifierHash, did, credentialURI, organization)` | Admin or operator | Creates a provider record in `Pending` status. Validates non-empty identifier/did and optional organization existence. |
| `updateProviderProfile(provider, identifierHash, did, credentialURI)` | Admin or operator | Refreshes deterministic identifier, DID, and credential URI metadata. |
| `updateProviderOrganization(provider, organization)` | Admin or operator | Updates the affiliated hospital. Ensures the hospital exists if provided. |
| `setProviderStatus(provider, status, credentialHash)` | Admin or operator | Changes verification status. When setting `Verified`, requires active membership in `HospitalRegistry` if an organization is specified, records `attestedBy`, and stores the credential hash. |
| `getProvider(provider)` | View | Returns the `Provider` struct. |
| `providerExists(provider)` | View | Indicates whether a provider record has been registered. |

## Typical Workflow

1. **Register** – Operator records provider metadata with `registerProvider`, optionally referencing a hospital. Status defaults to `Pending`.
2. **Affiliation** – Hospital operators add the provider to the hospital via `HospitalRegistry.setMembership`. Independents leave `organization = address(0)`.
3. **Verify** – Operator calls `setProviderStatus(..., Verified, credentialHash)` after confirming credential documents. The contract ensures hospital membership is active when an organization is supplied.
4. **Monitor** – Suspension, revocation, or profile updates emit events consumed by the Indexer and Gateway to update enforcement state.

## Integration Notes

- Always configure `setHospitalRegistry` before registering providers with affiliations so validation can succeed.
- Off-chain services should subscribe to status and profile events to maintain cached provider directories and credential proofs.
- When a provider leaves a hospital, call `updateProviderOrganization(provider, address(0))` (and remove membership in `HospitalRegistry`) before suspending or revoking access.
- Credential hashes can represent signed JSON/VC payloads stored in object storage; update the hash whenever attestation content changes.
