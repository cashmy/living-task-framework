# Audit Pipeline

The audit pipeline ingests access decision events from the EHR Gateway and persists them to immutable storage (S3 Object Lock in the MVP). The service relies on the shared `@ehr/audit-schema` package to validate every payload before it leaves the critical path.

## Event Normalization

`@ehr/audit-schema` exports the canonical schema and helper utilities used throughout the platform. The pipeline wraps these helpers inside `normalizeAuditEvent`, which:

1. Validates the shape of the raw event.
2. Adds a `receivedAt` timestamp for pipeline observability.
3. Calculates a deterministic partition and storage key (`YYYY-MM-DD/<service>/<action>/<eventId>.json`).

```ts
import { normalizeAuditEvent } from '@ehr/audit-pipeline';

const record = normalizeAuditEvent(rawEvent, { receivedAt: context.timestamp });
await storageClient.putObject({
  bucket: process.env.AUDIT_BUCKET,
  key: record.storageKey,
  body: JSON.stringify(record)
});
```

The helper returns a typed structure that can be written directly to S3, databases, or streaming sinks.

## Schema Compatibility

Use the `isCurrentSchema` guard to detect when upstream emitters upgrade the schema version:

```ts
if (!isCurrentSchema(record.event)) {
  throw new Error('Incompatible audit event version');
}
```

Any schema change must update `AUDIT_EVENT_VERSION` in the shared package and be coordinated with the pipeline to avoid ingestion failures.

## Collector Service

The Fastify-based collector exposes a small surface area while AWS credentials are pending:

- `GET /health` – basic liveness check.
- `GET /ready` – reports storage readiness (mock vs. s3).
- `POST /audit/event` – ingest a single event payload and normalize it.
- `POST /audit/events` – ingest a batch; responds with 207 when partial failures occur.
- `GET /audit/events?corrId=` – compliance lookup that reads from the in-memory cache first and falls back to recent storage prefixes; supports pagination and optional time filters.
- `GET /metrics` – Prometheus exposition endpoint sourced from `prom-client` counters, gauges, and histograms.

> Health (`/health`), readiness (`/ready`), and metrics remain unauthenticated; all other routes require an internal service token in the `Authorization: Bearer` header.

By default the collector uses the in-memory `MockAuditStorage`, enabling local development and integration tests without S3 credentials. Switching `AUDIT_STORAGE_MODE=s3` prepares the service for the future object store integration while keeping readiness checks honest (reported as `initializing` until the S3 client lands in AUD-3).

> TODO (AUD-3): replace the mock S3 maps with the real AWS SDK client and prefix scanning once credentials and infrastructure are available.

### Compliance Lookup Endpoint

The compliance route exposes a read surface tailored for investigations:

- **Required query**: `corrId`
- **Optional queries**: `pageSize`, `pageToken`, `startTime`, `endTime`
- **Defaults**: window of the most recent 24 hours, page size of 50 (capped at 200)
- **Pagination token**: opaque base64 payload encoding the numeric offset

Example lookup:

```http
GET /audit/events?corrId=corr-123&pageSize=2

200 OK
{
  "ok": true,
  "corrId": "corr-123",
  "events": [
    {
      "schemaVersion": "audit-event.v1",
      "ts": "2025-10-31T10:05:00.000Z",
      "actor": { "service": "ehr-gateway" },
      "action": "ehr.gateway.fhir.proxy",
      "result": { "decision": "permit", "reason": "granted", "latencyMs": 12 },
      "policyHash": "0xabc",
      "chainRef": null,
      "corrId": "corr-123"
    }
  ],
  "total": 6,
  "nextPageToken": "eyJvZmZzZXQiOjJ9"
}
```

- `404 Not Found` when the correlation identifier has no matching events in cache or storage.
- `400 Bad Request` for missing `corrId`, invalid pagination, or malformed time ranges.

The handler consults a TTL-based in-memory cache before scanning recent storage partitions, deduplicates events by `eventId`, and returns them in ascending timestamp order.

### Instrumentation

- `audit_events_ingested_total{status,storage}` counts accepted vs rejected events for each backend.
- `audit_events_validation_failures_total{kind}` isolates schema-level failures.
- `audit_ingest_duration_ms{storage}` captures persist latency, while `audit_batch_size` tracks incoming batch cardinality.
- `audit_storage_backlog{storage}` gauges the current buffer occupancy allowing alerts on backpressure.

## Configuration

The collector reads configuration from environment variables (`src/config.ts`).

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `PORT` | ❌ | `4100` | TCP port exposed by the Fastify server. |
| `AUDIT_STORAGE_MODE` | ❌ | `mock` | Storage backend (`mock` for in-memory, `s3` for future object store integration). |
| `AUDIT_S3_BUCKET` | Conditional | _none_ | Target bucket when `AUDIT_STORAGE_MODE=s3`. Ignored for mock mode. |
| `AWS_REGION` | Conditional | _none_ | AWS region resolving the S3 client when `AUDIT_STORAGE_MODE=s3`. |
| `AUTH_JWKS_URL` | ✅ | _none_ | JWKS endpoint used to validate internal service tokens. |
| `AUTH_JWT_ISSUER` | ✅ | _none_ | Expected issuer (`iss`) claim for internal tokens. |
| `AUTH_JWT_AUDIENCE` | ✅ | _none_ | Comma-separated audience list accepted by the collector. |
| `AUDIT_MAX_BATCH_SIZE` | ❌ | `50` | Maximum buffered events before flushing a batch. |
| `AUDIT_FLUSH_INTERVAL_MS` | ❌ | `5000` | Maximum time (ms) before forcing a batch flush. |
| `COMPLIANCE_CACHE_TTL_MS` | ❌ | `120000` | TTL (ms) for compliance lookup cache entries. |
| `COMPLIANCE_CACHE_MAX_ENTRIES` | ❌ | `500` | Maximum cached compliance results. |
| `COMPLIANCE_SEARCH_WINDOW_HOURS` | ❌ | `24` | Hours of history scanned for compliance lookups. |
| `COMPLIANCE_DEFAULT_PAGE_SIZE` | ❌ | `50` | Default page size served by compliance lookups. |
| `COMPLIANCE_MAX_PAGE_SIZE` | ❌ | `200` | Upper bound for compliance lookup paging. |

## Buffering & Batching

- Each normalized event enters an in-memory queue with configurable `AUDIT_MAX_BATCH_SIZE` and `AUDIT_FLUSH_INTERVAL_MS` thresholds.
- When either threshold is reached the collector serializes the batch to NDJSON, compresses it with gzip, and computes a SHA-256 digest before writing it to the mock S3 store under `YYYY/MM/DD/HH/events-{uuid}.ndjson.gz`.
- Companion metadata (reason, first/last timestamps, event count, byte size) is tracked alongside the payload so the future S3 uploader can preserve manifest semantics.
- `audit_storage_backlog` reflects the queue depth, enabling alerting when flushes lag behind ingress.
- Shutdown hooks call `storage.shutdown()` to drain the queue gracefully.

> TODO (AUD-3): swap the mock queue writer for the real S3 `PutObject` + manifest companion once AWS credentials and Object Lock policies are available.

## Next Steps

- Wire the normalization output to the Object Storage client (S3/Azure Blob/MinIO).
- Publish metrics to dashboards/alerts once the S3 pipeline is live.
- Add streaming fan-out (e.g., Kinesis, Kafka) once downstream consumers are active.
