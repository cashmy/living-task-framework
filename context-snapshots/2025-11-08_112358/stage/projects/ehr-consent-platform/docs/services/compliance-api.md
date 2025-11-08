# Compliance API Purpose and Design

This document captures the intent, scope, and operating model for the new Compliance API that surfaces audit evidence to governance, privacy, and security stakeholders.

## Objectives

- Provide a deterministic way to retrieve audit events tied to a correlation identifier (`corrId`).
- Offer responsive lookups by consulting in-memory cache before falling back to object storage.
- Bound storage scans to recent prefixes so the service remains predictable under load.
- Supply compliance and legal teams with an auditable data access interface and durable error semantics.

## Supported Use Cases

- Investigating a specific user or system access attempt via `corrId`.
- Pulling the sequence of audit events involved in an incident response runbook.
- Verifying evidence for regulatory reporting or attestation workflows.

## Non-Goals

- Serving as a full-text search interface across the audit lake.
- Performing bulk export or analytics queries (delegated to downstream data warehousing tools).
- Persisting long-term caches beyond the service lifetime; cache is ephemeral.

## High-Level Flow

1. Client issues `GET /audit/events?corrId=<value>`.
2. The Compliance API normalizes the correlation identifier (trim, case handling) and checks the in-memory cache.
3. If the event set is cached, results return immediately.
4. On cache miss, the API enumerates recent S3 prefixes (default: trailing 24 hours, configurable) and streams matching NDJSON objects.
5. Retrieved events are validated against `@ehr/audit-schema`, de-duplicated, and stored back in cache for subsequent lookups.
6. Response is delivered with ordering guarantees (ascending event timestamp) and optional pagination tokens.

## Endpoint Contract

- **Route**: `GET /audit/events`
- **Query Parameters**:
  - `corrId` (required): correlation identifier bound to the audit event cluster.
  - `pageSize` (optional): maximum events per page (default 50, capped at 200).
  - `pageToken` (optional): opaque token pointing to the next page when results exceed `pageSize`.
  - `startTime` / `endTime` (optional, ISO 8601): constrains S3 prefix scan window.
- **Success (`200 OK`)**:

  ```json
  {
    "ok": true,
    "corrId": "corr-123",
    "events": [
      {
        "schemaVersion": "audit-event.v1",
        "eventId": "88c33c00-b08c-421a-9c3d-600d3c682cc2",
        "ts": "2025-10-31T12:34:56.789Z",
        "actor": { "service": "ehr-gateway" },
        "requester": { "patientId": "0xpatient" },
        "action": "ehr.gateway.fhir.proxy",
        "result": { "decision": "permit", "reason": "granted", "latencyMs": 12 },
        "policyHash": "0x1234",
        "chainRef": "l2-mainnet:0xabc",
        "corrId": "corr-123"
      }
    ],
    "total": 5,
    "nextPageToken": "eyJvZmZzZXQiOjJ9"
  }
  ```

- **No Matches (`404 Not Found`)**: `{ "error": "corrId_not_found" }`
- **Validation Error (`400 Bad Request`)**: `{ "error": "invalid_query", "details": [...] }`
- **Upstream Failure (`502 Bad Gateway`)**: `{ "error": "storage_unavailable", "retryAfterMs": 5000 }`

## Internal Components

- **Query Controller**: Validates inputs, orchestrates cache lookup, and shapes HTTP responses.
- **Cache Layer**: LRU cache keyed by normalized correlation ID with configurable TTL.
- **S3 Scanner**: Iterates prefix hierarchy (`YYYY/MM/DD/HH`) within bounded time window, decompresses NDJSON batches, and emits parsed `AuditEvent` objects.
- **Result Normalizer**: Applies schema validation, sorts by event timestamp, and deduplicates by `eventId` when present.

## Operational Considerations

- **Performance**: Cache hit target ≥ 90% for hot incidents. S3 scans execute with concurrency limits and timeout budgets.
- **Observability**: Expose Prometheus metrics (`compliance_requests_total`, `compliance_cache_hits_total`, `compliance_s3_scan_seconds`) and structured logs with corrId context.
- **Error Budget**: Short-lived storage outages surface as 5xx with guidance to retry; circuit breakers prevent cascading failures.
- **Security**: Endpoint guarded by shared secret or JWT (aligned with audit pipeline auth). Responses redact sensitive payload fields per policy.

## Testing Strategy

- Unit tests for the controller (validation, cache hit/miss paths) and cache layer.
- Integration tests with localstack or mock S3 to validate prefix scanning, pagination behavior, and deduplication.
- Contract tests ensuring JSON output adheres to the shared audit schema types.

## Future Enhancements

- Add filters by `action`, `actor.id`, or decision result.
- Introduce streaming responses for large event sets.
- Support cryptographic proofs (Merkle paths) when audit data is anchored on-chain.
