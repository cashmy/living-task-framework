# EHR Gateway Metrics

This note documents the Prometheus telemetry emitted by the EHR Gateway PDP service. It captures the signals implemented in `services/ehr-gateway/src/metrics.ts` so downstream dashboards can track decision volume, denial reasons, cache efficiency, and consent indexer health.

## Exposure and configuration

- Metrics are collected with `prom-client` and exposed on `GET /metrics`.
- Default process metrics (CPU, memory, event loop) are registered alongside the gateway counters and histogram.
- Set `METRICS_ENABLED=false` to return a no-op recorder that disables collection and responds with a static `# metrics disabled` payload.
- All counters and histograms reset when the process restarts; persist the data in your Prometheus backend.

## Metric catalog

| Metric name              | Type       | Labels                 | Description |
|--------------------------|------------|------------------------|-------------|
| `pdp_decisions_total`    | Counter    | `decision` (`permit`, `deny`) | Counts every PDP decision outcome emitted by the gateway. |
| `pdp_denies_reason_total`| Counter    | `reason` (`no_active_consent`, `indexer_unreachable`, `invalid_input`, `internal_error`) | Breaks down denial traffic by cause so alerting can target specific failure modes. |
| `pdp_indexer_latency_ms` | Histogram  | *(none)*               | Observes the round-trip latency in milliseconds for consent indexer requests. Buckets: `5,10,20,50,100,200,500,1000`. |
| `pdp_cache_hits_total`   | Counter    | *(none)*               | Increments when an access decision is served from the in-memory consent cache. |
| `pdp_cache_misses_total` | Counter    | *(none)*               | Increments when the PDP must fetch fresh consent data from the indexer. |

## Suggested dashboard slices

- **Decision throughput:** Sum `pdp_decisions_total` by `decision` to show permit vs deny trends. A sudden drop in permits or spike in denies can indicate indexer or policy issues.
- **Denial root-cause:** Break down `rate(pdp_denies_reason_total[5m])` to distinguish malformed requests (`invalid_input`) from infrastructure faults (`indexer_unreachable`).
- **Cache efficiency:** Compare the derivative of hits vs misses. Alert if misses exceed hits for an extended window, suggesting the TTL is too low or cache invalidations are noisy.
- **Indexer latency:** Graph `histogram_quantile` over `pdp_indexer_latency_ms_bucket` to monitor external dependency performance. Combine with denial reasons to validate fail-open vs fail-closed behavior.

## Implementation references

- Metrics interface: `services/ehr-gateway/src/metrics.ts`
- Server exposure: `services/ehr-gateway/src/server.ts`
- Configuration flags: `METRICS_ENABLED` (toggle), `CONSENT_CACHE_TTL_MS` (indirectly influences hit/miss counters)
