
```mermaid
flowchart LR
  subgraph UserSpace[User & Clients]
    U[User / Tools / UI]
  end

  subgraph Edge["ECL-Edge (Vertical Adapters)"]
    GE1["GlossRP-Edge-T1\n(Consumer Slice)"]
    GE2["GlossRP-Edge-T2\n(Builder Slice)"]
    GE3["GlossRP-Edge-T3\n(Meta-Architect Slice)"]
  end

  subgraph Kernel[EnaC Kernel v3]
    K["Kernel Orchestrator\n(Tier, UMP/USP, EBP)"]
  end

  subgraph Core["ECL-Core (Horizontal Substrate)"]
    TS[Term Specs DB\n+ Graph + Embeddings]
    GC["GlossRP-Core\n(Semantic Retrieval)"]
    COS["COS/SCL/FIM\n(EnaC Cognitive Stack)"]
  end

  subgraph LLM[Reasoning Models]
    M["LLM / Agents\n(e.g., GPT-5 Codex, Claude Sonnet)"]
  end

  %% Flows
  U -->|"task"| K

  K -->|"query + metadata"| GC
  GC -->|"candidate bundle"| K

  K -->|"bundle + tier T1/T2/T3"| GE1
  K -->|"bundle + tier T1/T2/T3"| GE2
  K -->|"bundle + tier T1/T2/T3"| GE3

  GE1 -->|"T1 glossary slice"| K
  GE2 -->|"T2 glossary slice"| K
  GE3 -->|"T3 glossary slice"| K

  K -->|"task + tier + glossary\n+ UMP/USP + EBP"| COS
  COS -->|"ordered reasoning context"| M
  M -->|"answer + rationale"| K
  K -->|"final answer (+ trace, glossary)"| U

  TS <-->|read/write| GC


```

Read it top-to-bottom:

- User / tools send a task → Kernel.
- Kernel talks to GlossRP-Core (Core), then sends the neutral bundle to the correct GlossRP-Edge-Tx (Edge) based on Tier.
- Kernel takes the Tier-shaped slice + UMP/USP + EBP and runs it through COS/SCL/FIM, then into the LLM.
- LLM returns an answer; Kernel wraps it with trace + glossary back to the user.
- Term Specs DB + graph + embeddings sit in Core under GlossRP-Core.
