# GlossRP Execution Path Quickflow

``` mermaid
sequenceDiagram
  participant U as User
  participant K as EnaC Kernel
  participant GC as GlossRP-Core (ECL-Core)
  participant GE as GlossRP-Edge-Tx (ECL-Edge)
  participant COS as COS/SCL/FIM
  participant M as LLM

  U->>K: task + context
  K->>K: determine Tier (T1/T2/T3 via UMP/USP)
  K->>GC: task + domain/project
  GC-->>K: candidate bundle (neutral)
  K->>GE: bundle + Tier
  GE-->>K: Tier-specific glossary slice
  K->>COS: task + tier + glossary + behavior rules
  COS->>M: ordered reasoning context
  M-->>COS: answer draft
  COS-->>K: structured answer
  K-->>U: answer + (optional) glossary + trace

```

---

This gives a single mental picture:

- Core = TS + GlossRP-Core + COS/SCL/FIM
- Edge = GlossRP-Edge-T1/T2/T3
- Kernel = broker/orchestrator
- LLM = execution engine
