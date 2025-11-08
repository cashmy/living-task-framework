# Consent Indexer Service

## Overview

The Consent Indexer mirrors the on-chain `ConsentRegistry` contract into a Postgres database and exposes a REST API that downstream services (such as the EHR Gateway) can query. It continuously tails blockchain events, reconciles reorganizations, and maintains a queryable ledger of consent records.

## Responsibilities

- **On-chain ingestion:** Subscribe to `ConsentCreated`, `ConsentRevoked`, and `ConsentExpired` events and normalize them into database records.
- **Registry projection:** Mirror `ProviderIdentity` and `HospitalRegistry` contract events into provider/hospital read models for downstream authorization.
- **Reorg resilience:** Detect chain reorganizations by comparing stored block hashes with current chain data and roll back affected rows.
- **Read API:** Serve consent snapshots via REST (`/consents`) for PDP components and provide basic health reporting.
- **Registry lookup API:** Expose provider and hospital projections at `/registry/providers/:address` and `/registry/hospitals/:address` so the auth-service can derive roles and scopes without hitting the chain.

## Architecture & Flow

1. **Polling loop (`src/indexer.ts`):** Uses an `ethers` `JsonRpcProvider` to fetch successive blocks starting from `START_BLOCK` (or the latest indexed block). For each block it retrieves logs for the configured `CONSENT_REGISTRY_ADDRESS`, decodes them, and upserts consent records.
2. **Repository (`src/repository.ts`):** Implements persistence logic, block bookkeeping, and filtered queries for consents.
3. **Database schema (`src/db.ts`):** Ensures tables (`consents`, `indexed_blocks`, `providers`, `hospitals`, `hospital_memberships`) and supporting indexes exist at startup.
4. **Registry projection helpers (`src/repository.ts`):** Apply ProviderIdentity/HospitalRegistry events to the Postgres read model and expose typed query helpers for auth-service consumption.
5. **HTTP surface (`src/server.ts`):** Exposes `/health`, `/consents`, and registry projection endpoints. `/consents` accepts optional `patient` and `grantee` query parameters; registry endpoints expose provider and hospital metadata for claim mapping.
6. **Startup (`src/index.ts`):** Loads configuration, initializes the database schema, launches the indexer loop, and starts the Express server.

## REST API

| Method | Path | Purpose | Notes |
| --- | --- | --- | --- |
| `GET` | `/health` | Liveness probe | Returns `{ status: "ok" }`. |
| `GET` | `/consents` | Query consents | Optional `patient` and `grantee` query params; returns `{ data: ConsentRecord[] }`. |
| `GET` | `/registry/providers/:address` | Lookup provider projection | Returns status, organization, credential metadata, and effective membership flags for the provider wallet. |
| `GET` | `/registry/hospitals/:address` | Lookup hospital projection | Returns hospital profile/status, enablement, and membership epoch metadata. |

> All endpoints except `/health` require a valid internal service token supplied as a `Bearer` authorization header.

The `ConsentRecord` payload matches the structure stored in the database:

```json
{
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
```

## Configuration

Configuration is loaded via `dotenv` in `src/config.ts`. `CONSENT_REGISTRY_ADDRESS` can be obtained either from environment variables or the shared `contracts/deployed-contracts.json` file.

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `CONSENT_REGISTRY_ADDRESS` | ✅ | _none_ | Address of the deployed `ConsentRegistry` contract. Falls back to `contracts/deployed-contracts.json`. |
| `RPC_URL` / `PROVIDER_URL` | ✅ | `http://localhost:8545` | Ethereum JSON-RPC endpoint used for log polling. |
| `DATABASE_URL` | ✅ | `postgres://ehr_admin:postgres@localhost:5432/ehr` | Postgres connection string. |
| `HTTP_PORT` / `PORT` | ✅ | `4100` | Port exposed by the Express server. |
| `POLL_INTERVAL_MS` | ❌ | `2000` | Delay between polling iterations (in milliseconds). |
| `START_BLOCK` | ❌ | `0` | First block to inspect when no state has been recorded. |
| `AUTH_JWKS_URL` | ✅ | _none_ | JWKS endpoint for verifying internal service tokens. |
| `AUTH_JWT_ISSUER` | ✅ | _none_ | Expected issuer (`iss`) claim for internal tokens. |
| `AUTH_JWT_AUDIENCE` | ✅ | _none_ | Comma-separated audience list expected in internal tokens. |

## Database Schema

The schema is managed programmatically:

- `consents` table stores flattened consent attributes plus provenance (`block_no`, `log_index`, `tx_hash`). A unique index on `(block_no, log_index)` preserves ordering.
- `indexed_blocks` table tracks processed blocks (`block_no`, `block_hash`) so the indexer can detect gaps and reorganizations.
- `providers` / `hospitals` / `hospital_memberships` tables store the latest projection of identity registries, enabling claim derivation without on-chain calls.

## Reorganization Handling

- Before processing new blocks, `ensureChainConsistency` compares the stored hash for the latest indexed block against the current chain. If a mismatch or missing block is detected, it deletes rows in `consents` and `indexed_blocks` from that block onwards and retries.
- During block processing, the indexer verifies parent hash continuity and triggers rollback when a fork is detected mid-stream.
- The loop retries after each rollback, ensuring the database reflects the canonical chain.

## Running Locally

```powershell

# from repository root

pnpm install
pnpm --filter @ehr/consent-indexer dev
```

Provide a `.env.local` inside `services/consent-indexer` (or export variables) with at least `CONSENT_INDEXER_ADDRESS`, `RPC_URL`, and `DATABASE_URL`. For local development, you can point at Hardhat/Anvil and a dockerized Postgres instance.

## Testing

Vitest powers the test suite. Repository tests use `pg-mem` for in-memory Postgres emulation.

```powershell
pnpm --filter @ehr/consent-indexer test -- --run
```

Current coverage includes:

- Repository behaviors (`tests/repository.test.ts`) covering upsert, filtered queries, block bookkeeping, and rollback helpers.

## Operational Notes & Roadmap

- **Metrics & logging:** Consider adding structured logs per block cycle and metrics for processed logs, rollbacks, and latency.
- **Backfill improvements:** Introduce batch log retrieval or pagination for large historical imports.
- **API enhancements:** Add consent lookup by `consentId`, pagination, and affiliation metadata when the schema expands.
