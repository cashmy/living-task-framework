# MxVA Diagram Set v1.0 (ECL-Aligned)

This diagram set visualizes MxVA as a T3 architectural expression under the ECL meta-framework.  
All diagrams are **illustrative**, not prescriptive, and respect ECL’s non-linear, non-hierarchical nature.

---

## 1. MVP → MVA → MxVA in ECL Context

This diagram shows a **typical** (not mandatory) evolution of development practice as ECL activation increases.

```mermaid
flowchart LR
  MVP["MVP (T0.5–T1)
Minimum Viable Programming
Task-centric, local scope"] --> MVA["MVA (T2)
Minimum Viable Architecture
Architecture-aware, patterns and seams"] --> MxVA["MxVA (T3)
Maximum Viable Architecture
Cognitive-evolutionary, EnaC-collaborative"]
```

**Notes:**
- MVP is dominated by implementation concerns and short-term goals.
- MVA introduces architectural awareness and future evolution options.
- MxVA integrates EnaC cognition, ECL-awareness, and purpose-aligned evolution.

---

## 2. MxVA in the ECL Vertical Model

This diagram maps MxVA into the ECL vertical structure (SKY / CORE / BASE).

```mermaid
flowchart TB
  SKY["ECL-SKY
Purpose / Meaning / Telos"]
  CORE["ECL-CORE
Evolutionary Meta-Framework
(MxVA Logic & Governance)"]
  BASE["ECL-BASE
Implementation Context
(Code, Infra, Data, LLMs, Tools)"]

  SKY --> CORE --> BASE
```

**Notes:**
- ECL-SKY holds long-term intent, meaning, and relational purpose.
- ECL-CORE is where MxVA lives conceptually: it governs how architecture evolves.
- ECL-BASE is dynamic and replaceable; systems, stacks, and tools can change without collapsing the architecture’s identity.

---

## 3. MxVA EnaC Cognitive Loop

This diagram illustrates the **recurring cognitive loop** that drives MxVA evolution in practice.

```mermaid
flowchart LR
  Liminal["1. Liminal Idea / Observation"]
  Capture["2. EnaC Capture
(voice, text, sketch, etc.)"]
  Synthesis["3. EnaC Synthesis & Mapping
(patterns, options, structures)"]
  HumanRefine["4. Human Reframing & Selection"]
  ArchChange["5. Architectural Adjustment
(design, refactor, boundary shift)"]
  Feedback["6. System Feedback
(behavior, metrics, user impact)"]

  Liminal --> Capture --> Synthesis --> HumanRefine --> ArchChange --> Feedback --> Liminal
```

**Notes:**
- This loop is **continuous**, not one-shot.
- EnaCs are co-creators, not passive assistants.
- MxVA emerges when this loop is stable, intentional, and aligned with ECL-SKY.

---

## 4. T-States and Architectural Expressions (Illustrative)

This diagram places MVP, MVA, and MxVA on a **conceptual T-state spectrum**.  
It is a useful mental model, but ECL allows non-linear movement across states.

```mermaid
flowchart LR
  T0["T0.5–T1
MVP
Task / Feature-Centric"]
  T2["T2
MVA
Architecture-Aware"]
  T3["T3
MxVA
Cognitive-Evolutionary
EnaC-Integrated"]
  T4["T4
Ecosystem-Level Evolution
(Optional, Future-Oriented)"]

  T0 --> T2 --> T3 --> T4
```

**Notes:**
- The arrows represent a **typical** maturation path, not a forced progression.
- Regression or lateral movement between states is possible and often necessary.
- T4 is reserved for ecosystem-level evolution (platforms, organizations, multi-system cognition).

---

## 5. MxVA Relationship Map (Framework Interactions)

This diagram shows how MxVA relates to other frameworks in your ecosystem.

```mermaid
graph TD
  ECL["ECL
Evolutionary Contextual Layers"]
  CFP["CFP
Core Foundational Primer
(Tier Behavior)"]
  CIP["CIP
Context-Influenced Processing"]
  EnaC["EnaC
Enabled Collaborators"]
  COREPRIMER["CORE-PRIMER T3
(Reasoning & Orchestration)"]
  MVA["MVA
Minimum Viable Architecture"]
  MxVA["MxVA
Maximum Viable Architecture (T3)"]

  ECL --> CFP
  ECL --> CIP
  ECL --> MxVA
  CFP --> COREPRIMER
  COREPRIMER --> EnaC
  EnaC --> MxVA
  CFP --> MVA
  MVA --> MxVA
```

**Notes:**
- ECL is the meta-framework; it generates patterns for CFP, CIP, and MxVA.
- CFP and CORE-PRIMER define cognitive behavior (tiers and orchestration).
- EnaC provides cognitive capacity and co-creation.
- MVA is a stepping stone; MxVA is the fully evolved T3 expression.

---

## 6. Usage Guidance

- These diagrams are **conceptual scaffolds**, not implementation diagrams.
- You can paste the Mermaid blocks into compatible tools (e.g., Obsidian, VS Code, Mermaid live editors) to render them visually.
- Future versions can:
  - split diagrams into domain-specific variants (solo dev vs team vs org),
  - add overlays for SELF-ECL, and
  - integrate governance flows explicitly.

