# Milestone 4 Audit Deliverables

Structured plan to deliver Milestone 4 with the Compliance API included.

## Shared Audit Schema (AUD‑1) -- DONE

- Create audit-schema exporting the TypeScript types and Zod schema for AuditEvent v1 (include schemaVersion, corrId, actor, requester, result, policyHash, chainRef, payload hash, etc.).
- Publish it as a workspace package so both the gateway and audit service can consume it.
- Add schema validation unit tests.

## Collector Service Skeleton (AUD‑2) -- DONE (MOCK S3)

Scaffold the `audit-pipeline` service (Express or Fastify) with:

- Config loader (`S3_BUCKET`, `AWS_REGION`, `BATCH_SIZE`, `FLUSH_INTERVAL_MS`, `PORT`, …).
- `/health` liveness endpoint.
- `/ready` readiness probe that verifies S3 write access (e.g., `HEAD` bucket or noop write).
- `POST /audit/events` (bulk) and `POST /audit/event` (single) accepting JSON/NDJSON, validating against the schema, and enqueueing for batching.
- `GET /audit/events` lookup by `corrId` using an in-memory index with S3 fallback.
- Authentication placeholder middleware (shared secret) for future hardening.

## Buffering & Batching (AUD‑3) -- DONE

- Implement an in-memory queue with size/time flush triggers.
- Serialize batches to NDJSON, gzip the payload, compute a SHA-256 digest, and write to `s3://bucket/YYYY/MM/DD/HH/events-{uuid}.ndjson.gz`.
- Persist manifest metadata (either alongside the object or as a `.meta.json` companion).
- Wire normalizeAuditEvent into the actual audit pipeline transport (S3 writer or queue consumer).
- Ensure graceful shutdown flushes pending batches.

## Compliance API (AUD‑6)

- Add `GET /audit/events?corrId=` to search:
  - In-memory cache first.
  - If missing, scan recent S3 prefixes (bounded search window).
- Return matching events (or 404) and consider pagination/time-range filters.
- Add unit/integration tests for the new endpoint.
- Add a purpose document (markdown file) describing the compliance API design and usage.
- Document the API (request/response examples, error handling).

## Integration with Gateway/Proxy (AUD‑4) -- DONE

- Implement an HTTP publisher in `ehr-gateway` targeting the pipeline (`AUDIT_PIPELINE_URL`, `AUDIT_PIPELINE_TOKEN`). ✅ `HttpAuditPublisher` forwards events with bearer auth.
- Add retries/backoff; log failures but do not block the primary request. ✅ Exponential backoff with bounded retries; failures bubble for logging only.
- Extend gateway tests with a mocked pipeline (e.g., `nock`) verifying POST calls. ✅ Vitest + Nock cover success, retry, and failure paths.

## Metrics & Observability (AUD‑5) -- DONE

- Instrument Prometheus counters and histograms:
  - `audit_events_ingested_total{source}`
  - `audit_events_invalid_total`
  - `audit_s3_uploads_total`
  - `audit_s3_upload_failures_total`
  - Upload latency histogram
- Expose `/metrics` via `prom-client`.
- Emit structured logs for batch flush summaries.

## Tests

- Schema validation (happy path and failure cases).
- Collector handlers: payload validation, queue behaviour, fake timers.
- S3 uploader integration tests with an SDK mock.
- Compliance API tests over synthetic gzipped fixtures.
- Gateway integration verifying the publisher posts to the pipeline.
- End-to-end flow: inject sample events, trigger batch flush, capture S3 output.

## Documentation

- Add `docs/services/audit-pipeline.md` (architecture, endpoints, configuration, metrics).
- Update the milestone roadmap/README to highlight completion.
