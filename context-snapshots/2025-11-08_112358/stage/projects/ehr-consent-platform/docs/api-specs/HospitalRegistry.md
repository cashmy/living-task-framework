# HospitalRegistry Contract Reference

## Purpose

`HospitalRegistry` manages trusted healthcare organizations on-chain so downstream services can enforce access decisions against verified institutions. It tracks registration metadata, verification status, compliance attestations, and provider memberships managed by approved registry operators. No PHI is stored; only organizational identity and audit-critical state transitions are captured.

## Data Model

| Field | Type | Description |
| --- | --- | --- |
| `Hospital.name` | `string` | Legal or trading name for the hospital/clinic. |
| `Hospital.did` | `string` | Decentralized identifier or external directory pointer for the organization. |
| `Hospital.regionCode` | `string` | Residency or jurisdiction tag (e.g., `us-east-1`). |
| `Hospital.metadataURI` | `string` | Optional URI for extended profile metadata (JSON, IPFS, etc.). |
| `Hospital.complianceHash` | `bytes32` | Hash of latest compliance/attestation artifact. `0x0` when none recorded. |
| `Hospital.status` | `VerificationStatus` | Enum: `Unverified`, `Pending`, `Verified`, `Suspended`, `Removed`. Only `Verified` hospitals may be enabled. |
| `Hospital.enabled` | `bool` | Indicates whether the organization is active for enforcement once verified. |
| `Hospital.attestedBy` | `address` | Operator that last attested the hospital as verified. Cleared on suspension/removal. |
| `Hospital.createdAt` | `uint64` | Block timestamp when the record was first registered. |
| `Hospital.updatedAt` | `uint64` | Timestamp of the most recent update. |
| `Hospital.membershipEpoch` | `uint64` | Logical counter that invalidates prior memberships when the hospital leaves verified state. |

Membership records are kept in a nested mapping keyed by hospital and member address:

| Field | Type | Description |
| --- | --- | --- |
| `Membership.active` | `bool` | True when the member is currently affiliated in the active epoch. |
| `Membership.updatedAt` | `uint64` | Last update timestamp. |
| `Membership.updatedBy` | `address` | Operator that recorded the change. |
| `Membership.epoch` | `uint64` | Snapshot of the hospital epoch at the time of update. Stale epochs are treated as inactive. |

## Events

| Event | When | Notes |
| --- | --- | --- |
| `AdminTransferred(previousAdmin, newAdmin)` | Admin role rotates. | Enables secure operational handoff. |
| `RegistryOperatorUpdated(operator, allowed)` | Admin grants or revokes operator permissions. | Operators can manage hospitals and memberships. |
| `HospitalRegistered(hospital, name, did, regionCode, metadataURI)` | Registry entry created in `Pending` status. | Attestation and enablement happen later. |
| `HospitalProfileUpdated(hospital, name, did, regionCode, metadataURI, updatedAt)` | Profile metadata changes. | Does not alter status or enablement. |
| `HospitalStatusUpdated(hospital, status, enabled, attestedBy, complianceHash, updatedAt)` | Verification state or compliance artifacts change. | Emits on transitions to/from `Verified`, suspension, or removal. |
| `HospitalMembershipUpdated(hospital, member, active, updatedBy, updatedAt, epoch)` | Membership affiliation added/removed. | Epoch allows off-chain consumers to invalidate stale entries. |

## Errors

- `Unauthorized()` – caller lacks admin/operator privileges for the attempted action.
- `HospitalAlreadyRegistered(hospital)` – duplicate registration attempt.
- `HospitalNotRegistered(hospital)` – looked up a hospital that has not been registered.
- `InvalidStringField(field)` – empty `name`, `did`, or `regionCode` provided, or misuse of sentinel values.
- `InvalidAddress(field)` – zero address provided where not allowed.
- `InvalidStatus(status)` – attempted to set status back to `Unverified`.
- `HospitalNotVerified(hospital)` – membership updates attempted on a hospital that is not currently verified.

## Public Functions

| Function | Caller | Description |
| --- | --- | --- |
| `admin()` | View | Returns the current admin address. |
| `transferAdmin(newAdmin)` | Admin | Moves the admin role to another address. |
| `setRegistryOperator(operator, allowed)` | Admin | Grants or revokes operator permissions. |
| `registerHospital(hospital, name, did, regionCode, metadataURI)` | Admin or operator | Creates a new hospital record in `Pending` status. Initializes timestamps and membership epoch. |
| `updateHospitalProfile(hospital, name, did, regionCode, metadataURI)` | Admin or operator | Refreshes the descriptive metadata of an existing hospital. |
| `setHospitalStatus(hospital, status, enabled, complianceHash)` | Admin or operator | Updates verification status, toggles enablement when verified, records compliance hash, and bumps membership epoch when leaving verified state. |
| `setMembership(hospital, member, active)` | Admin or operator | Adds or removes a provider membership for a verified hospital. Records epoch and audit trail. |
| `registryOperators(operator)` | View | Returns whether an address is authorized as an operator. |
| `getHospital(hospital)` | View | Reads the full `Hospital` struct. Reverts if not registered. |
| `hospitalExists(hospital)` | View | Checks if the registry entry exists. |
| `getMembership(hospital, member)` | View | Returns membership record; inactive if epoch is stale. |
| `isMember(hospital, member)` | View | Convenience check that enforces epoch alignment to ensure only current members return `true`. |

## Typical Workflow

1. **Register** – Admin or operator calls `registerHospital` to seed the record (status `Pending`, disabled). Off-chain verification workflows are triggered.
2. **Verify** – Once compliance checks pass, an operator calls `setHospitalStatus` with `VerificationStatus.Verified`, sets `enabled = true`, and provides a compliance artifact hash.
3. **Associate Members** – Operators add affiliated provider addresses via `setMembership`. Membership remains valid while the hospital stays verified.
4. **Suspend or Remove** – If compliance fails, operators call `setHospitalStatus` with `Suspended` or `Removed`. This bumps the membership epoch and causes `isMember` to return `false` for prior associations until reaccredited.
5. **Update Metadata** – Administrative changes (name, DID, region) use `updateHospitalProfile`, keeping audit timestamps intact.

## Integration Notes

- Off-chain services should listen to status and membership events to mirror organization directories and trust roots.
- Membership epochs allow consumers to prune stale affiliations without iterating on-chain storage. Check both `active` and `epoch` when syncing.
- Only verified hospitals can be marked `enabled = true`. Attempting to manage memberships on non-verified hospitals reverts.
- Compliance hashes are arbitrary `bytes32` values—store attestation documents off-chain (e.g., S3, IPFS) and hash them before recording here.
- Admin can delegate day-to-day operations through registry operators, enabling shared responsibility without exposing the main admin key.
