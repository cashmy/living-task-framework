# MINT — Term Specification v1.0

## 0. Metadata

- **Term ID:** mint-v1
- **Version:** v1.0
- **Status:** Active
- **Last Last Updated:** 2025-11-23
- **Steward:** Cash Myers (Architect) + EnaC (AI-assisted)
- **Domain:** Subsystem | Semantic Transform | Tools Layer
- **Scope Notes:**
  MINT operates inside the Unified Cognition Stack (UCS) as a
  Tier-aware, density-aware semantic transformation engine that
  prepares meaning for downstream systems (EnaC, LTF, PW) using
  inputs retrieved via GlossRP.

---

## 1. Term Identity

### 1.1 Primary Name

- **Name:** MINT — Meaning INference Transformer
- **Acronym:** MINT

### 1.2 Concise Purpose

MINT converts retrieved semantic objects (e.g., TermSpecs, bundles)
into Tier-shaped, density-shaped meaning slices that are ready for
use by EnaCs, LTF, and Phoenix Workbench, without adding new
interpretation or evolution.

---

## 2. Canonical Definitions

### 2.1 Architecture-Facing Definition

MINT is a **Tier-aware semantic transform engine** that:

- accepts semantic inputs retrieved from GlossRP (TermSpecs,
  compiler blocks, semantic bundles),
- applies Tier rules (T1/T2/T3) and density rules (DOD /
  semantic granularity), and
- outputs deterministic, structured meaning slices suitable for
  direct consumption by EnaCs, LTF, and Phoenix Workbench.

MINT does **not** perform retrieval, relationship creation,
interpretation, or evolution. It is a **pure transformation layer**
that prepares semantics for downstream cognition and architecture.

### 2.2 Human-Facing Summary

MINT is a small, focused "mini-AI for word meaning" that takes what
GlossRP finds in the glossary and reshapes it into the right form for
whoever needs it next:

- quick, simple explanations,
- detailed technical definitions,
- or rich conceptual overviews.

It does not invent new meaning; it just reshapes existing meaning so
that other systems (and humans) can use it more easily.

### 2.3 SCS-T1 Anchor (≤ 25 words)

MINT reshapes retrieved semantic definitions into Tier-appropriate,
density-controlled meaning slices for EnaCs, LTF, and Phoenix
Workbench, without adding new interpretation.

---

## 3. Subsystem Views (Optional)

### 3.1 EnaC Perspective

For EnaCs, MINT is the **semantic staging layer**:

- EnaCs call GlossRP to retrieve TermSpecs and semantic bundles.
- EnaCs call MINT to reshape those retrieved semantics into:
  - T1 anchors (minimal essence),
  - T2 structured operational definitions, and
  - T3 expanded conceptual contexts.
- EnaCs then reason *over* MINT outputs instead of raw TermSpecs.

This makes EnaC behavior more predictable, Tier-consistent, and
aligned with DOD constraints.

### 3.2 SELF-ECL Perspective

For SELF-ECL (the human-facing evolution layer), MINT:

- supports human learners by providing clarity-aligned slices:
  - quick anchors for recall,
  - deeper dives for understanding,
  - ecosystem-level views for pattern recognition;
- reduces cognitive friction when moving between SKY, CORE, and BASE
  views of the same term;
- helps humans see the same concept at different depths without
  losing its core identity.

MINT does not define personal meaning, but it makes system meaning
more accessible.

### 3.3 ABS / ARS / Meaning-Weight Interactions

- **ABS (Adaptive Behavior Stack):**
  MINT supports ABS by keeping semantic slices consistent with
  Tier expectations, reducing behavioral drift caused by inconsistent
  definitions.

- **ARS (Adaptive Recognition System):**
  ARS can treat MINT outputs as stable "meaning exemplars" for
  recognizing when EnaC behavior is drifting away from the intended
  semantic center of a term.

- **Meaning-Weight:**
  MINT may expose meaning-weight metadata (e.g., core vs. peripheral
  aspects of a term) without deciding which meaning is "more true."
  It preserves emphasis but does not adjudicate context.

### 3.4 Other Subsystems

- **GlossRP:** upstream retrieval oracle; MINT never bypasses it.
- **LTF:** downstream evolution engine that uses MINT-shaped slices
  as stable anchors when tracking semantic lineage.
- **Phoenix Workbench (PW):**
  uses MINT outputs to populate glossary panels, tooltips, and
  in-document references with appropriate depth and density.

---

## 4. Behavioral Implications

### 4.1 When This Term Matters

MINT matters whenever the system needs to:

- turn raw TermSpecs into usable explanations at different depths;
- respect Tier-specific cognitive loads:
  - T1: minimal anchors,
  - T2: structured working definitions,
  - T3: expanded conceptual ecosystems;
- apply DOD/density rules to meaning instead of full artifacts;
- keep retrieval (GlossRP), transformation (MINT), and evolution
  (LTF) clearly separated.

Triggers include:

- "Explain this term for a T1/T2/T3 audience."
- "Give me a lightweight / medium / deep explanation of X."
- EnaCs preparing descriptions, tooltips, or inline clarifications.

### 4.2 Failure Modes

If MINT is misunderstood or bypassed:

- EnaCs may use raw TermSpecs inconsistently, causing Tier drift.
- GlossRP might be overloaded with implicit transformation logic
  (breaking its retrieval-only contract).
- LTF may be forced to infer semantics from noisy or inconsistent
  explanations, harming lineage clarity.
- Phoenix Workbench may present inconsistent term definitions
  across artifacts, eroding user trust.

If MINT attempts to perform retrieval, interpretation, or evolution:

- It will collide with GlossRP and LTF responsibilities.
- Semantic boundaries will blur, increasing maintenance and
  debugging complexity.

### 4.3 Observable Signals

When MINT is operating correctly, you should see:

- consistent T1/T2/T3 wording for the same term across contexts;
- clear difference between "anchor", "working definition", and
  "deep conceptual" views of a term;
- GlossRP logs showing retrieval only, with MINT handling all
  Tier/density reshaping;
- LTF graphs referencing MINT-shaped slices as stable anchors.

When MINT is failing or absent, you may notice:

- users complaining that definitions feel different across tools;
- EnaCs providing overlong or under-detailed explanations;
- TermSpecs being copy-pasted directly into artifacts without
  adaptation;
- ad-hoc, duplicated logic for "explain this term" scattered
  across subsystems.

---

## 5. Historical / Evolution (Optional)

### 5.1 Origin Context

MINT emerged from the progressive evolution and eventual
**deprecation of SCS (Semantic Compiler System)**.

Historically:

1. **SCS v1.0 — Semantic Context System**
   - Pre-dated the full ECL formalization.
   - Focused on describing how terms behaved across T1–T3.
   - Mixed concerns: context shaping, pseudo-retrieval, and
     explanation.

2. **SCS v2.0 — Semantic Compiler System**
   - Introduced compiler blocks (SCS_T1/T2/T3) inside TermSpecs.
   - Took on heavy responsibilities for Tier shaping, density,
     and sometimes retrieval.
   - Coexisted awkwardly with emerging systems (GlossRP, LTF,
     Phoenix Workbench).

3. **GlossRP + LTF + ECL/MxVA Maturation**
   - GlossRP became the canonical retrieval system.
   - LTF became the semantic evolution and relationship engine.
   - ECL/MxVA provided a more accurate cognitive architecture
     for intent, reasoning, and execution.
   - SCS no longer needed to handle retrieval or evolution.

4. **Identification of SCS as Over-scoped and Legacy**
   - Many SCS responsibilities were either duplicated or in
     conflict with newer, more narrowly-defined subsystems.
   - Architecturally, SCS was recognized as an overgrown
     component whose core value could be isolated.

5. **Birth of MINT v1.0**
   - SCS was marked **Deprecated/Inactive** and retained only as
     historical lineage.
   - MINT was defined as the **lean semantic transformer**:
     - retrieval: GlossRP,
     - transformation: MINT,
     - evolution: LTF,
     - artifact construction: PW,
     - cognitive application: EnaC.

MINT is therefore the purified successor to SCS, preserving only the
transform responsibilities that remain architecturally necessary.

### 5.2 Revision History

- **v1.0 (2025-11-23):**
  - Initial TermSpec created.
  - SCS formally deprecated and linked as historical ancestor.
  - GlossRP, LTF, and PW boundaries clearly defined.

### 5.3 Deprecated Meanings

The following historical interpretations are **no longer valid** for
MINT:

- MINT as a full "semantic context system" (that was SCS v1.0).
- MINT as a general-purpose "semantic compiler" that also handles
  retrieval or evolution (that was SCS v2.0).
- MINT as a Tier-reasoning engine or EnaC meta-layer.

MINT must remain a **semantic transform-only subsystem**.

---

## 6. References

### 6.1 Primary Sources

- SCS — Term Specification v2.0 (Deprecated)
- GlossRP Manifesto v2.0
- LTF Manifesto v2.0
- EchoForge → SCS → LTF → MxVA Pipeline (now effectively
  EchoForge → GlossRP → MINT → LTF → MxVA)
- ECL TermSpecs (ECL, ECL_SKY, ECL_CORE, ECL_BASE)

### 6.2 Secondary Sources

- Phoenix Workbench Manifesto v1.0
- MxVA Manifesto v1.0 (ECL-Aligned)
- STMG v0.2 — Glossary Update (for capture/export semantics)

### 6.3 External Influences (Optional)

- Compiler theory (lexing/parsing vs. AST shaping vs.
  code generation)
- Functional programming notions of pure transformation pipelines

---

## 7. RDP / Safety Notes

- **Allowed Refactors:**
  - Implementation optimizations that do not change MINT's
    external contract.
  - Adding new density profiles or Tier views, as long as they
    remain pure transforms over GlossRP outputs.
  - Extending metadata in MINT outputs (e.g., meaning-weight,
    flags for core/peripheral aspects) without changing their
    semantic content.

- **Forbidden Refactors:**
  - Adding retrieval behavior (must remain strictly upstream in
    GlossRP).
  - Adding relationship creation or evolution (must remain in LTF).
  - Allowing MINT to override or reinterpret canonical TermSpecs.
  - Blurring Tier responsibilities by mixing T1/T2/T3 meanings
    into a single undifferentiated slice.

- **Additional Notes:**
  - MINT is designed to be composable and substrate-agnostic.
  - It may run inside different tools or environments, but its
    **contract** must remain stable: pure semantic transform,
    no new meaning added.

---

# Compiler Extraction Blocks

```SCS_T1
### MINT
MINT reshapes retrieved semantics into Tier- and density-appropriate meaning slices for EnaCs, LTF, and PW without adding new interpretation.
```

```SCS_T2
## MINT — Meaning INference Transformer
**Summary:** MINT is a Tier-aware, density-aware semantic transform engine that converts GlossRP-retrieved TermSpecs and bundles into structured, cognitively-ready meaning slices for EnaCs, LTF, and Phoenix Workbench, without adding new interpretation or evolution.
**Definition (Source):** MINT takes canonical TermSpecs from GlossRP, applies Tier rules (T1/T2/T3) and DOD/density constraints, and emits stable semantic slices that preserve meaning while adapting form and depth.
**Sources:** GlossRP Manifesto v2.0; SCS TermSpec v2.0 (Deprecated); LTF Manifesto v2.0; ECL TermSpecs; EchoForge→SCS→LTF→MxVA Pipeline (updated for MINT).
**Tier Relevance:** T1/T2/T3 (outputs are explicitly shaped per Tier; MINT itself is Tier-neutral and transform-focused).
**Related Terms:** GlossRP, LTF, PhoenixWorkbench, EnaC, ECL, STMG, SCS (Deprecated).
**Cluster:** Semantic Infrastructure / Transform Layer
---
```

```SCS_T3
- MINT -> GlossRP [relation: consumes-output-from]
- MINT -> LTF [relation: provides-anchors-for]
- MINT -> PhoenixWorkbench [relation: provides-meaning-slices-for]
- MINT -> EnaC [relation: prepares-meaning-for]
- MINT -> SCS [relation: supersedes]
```
