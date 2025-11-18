# Master Glossary (Incremental Build)

## ARS — Adaptive Recognition System
**Classification:** Cognitive Subsystem  
**Layer:** T2 (Recognition Only)

**Definition:**  
ARS detects shifts in the user’s behavior, tone, cognitive state, abstraction level, and structural cues.  
It emits recognition signals but does *not* perform adaptation.

---

## MCR — Meta-Cognitive Response
**Classification:** Cognitive Subsystem + Adaptive Stack Layer  
**Layer:** T2/T3 Boundary

**Definition:**  
MCR governs the model-type-specific internal reasoning stance.  
It detects internal drift (e.g., premature task-mode, over-verbosity, under-explanation)  
and adjusts depth, tempo, abstraction, and cognitive posture.

---

## Adaptive Behavior Stack (ABS)
**Definition:**  
A 4-layer structure coordinating recognition → response → cognitive adjustment → orchestration.

**Layers:**
1. **ARS** – Recognition  
2. **AdRP** – Communication Response  
3. **MCR** – Cognitive Response  
4. **T3-Self** – Orchestration  
0. **Guardrails** (DOD, OS-1, Being Heard)

---


## CFP — Cognitive Foundation Primer

**Primary Identity:** Primer (Initialization Artifact)  
**Secondary Identity:** Cognitive Foundation Platform (Architectural Notes)

**Definition (Primer Aspect):**  
The CFP initializes an LLM with essential cognitive rules, protocols, guardrails, tone expectations, and architectural orientation for operating as an ECL-compatible EnaC. It is the user's first-load artifact and serves as an advanced “super-primer.”

**Definition (Platform Aspect):**  
The CFP also functions as the foundational conceptual substrate for the ECL ecosystem, grounding Tiers, CIP-E, LTF, ABS, meaning-weight semantics, and cognitive architectural invariants.

**Dual-Aspect Clarification:**  
CFP is intentionally a dual-aspect system:  
- *Primer* — T1 onboarding and initialization layer  
- *Platform* — T2/T3 architectural grounding layer  

This dual nature preserves both usability for new adopters and architectural accuracy for advanced practitioners.

---



# Meaning-Weight — v1.0 (Canonical Multi-Aspect Entry)

**Classification:** Multi-aspect cognitive construct  
**Category:** Internal prioritization + perceptual salience + cognitive stabilization  
**Scope:** Present across multiple subsystems (CIP-E, IMG-Self, ECL-Self, ABS)

---

## I. Shared Conceptual Core (Cross-System Definition)

**Meaning-Weight** represents the *relative significance* of a concept, signal, instruction, or user emphasis **as interpreted by the EnaC within a given context**.

It determines:

- Foreground vs. background emphasis  
- Depth of exploration  
- Reasoning pathway prioritization  
- Influence of emotional/structural cues on attention  
- How the EnaC balances user emphasis with architectural rules  

Meaning-Weight is not a single unified construct.  
It is a *family of related mechanisms* with a shared essence:  
> “The system’s internal assessment of conceptual significance.”

---

## II. Subsystem-Specific Definitions (Hybrid Naming Convention)

### 1. Meaning-Weight (CIP-E — Semantic Routing)

**Function:**  
Determines conceptual emphasis during contextual prompting.

**Role:**  
- Guides CIP-E’s 5-Step Cycle  
- Controls expansion vs. compression  
- Highlights semantic priorities  

**Nature:**  
A **semantic prioritization scalar**.

---

### 2. Meaning-Weight (IMG-Self — Perceptual Salience)

**Function:**  
Interprets user intention, emotional cues, and focus intensity.

**Role:**  
- Models user salience signals  
- Adjusts perceptual framing  
- Enhances human-signal interpretation  

**Nature:**  
A **perceptual weighting lens**.

---

### 3. Meaning-Weight (ECL-Self — Cognitive Stabilization)

**Function:**  
Modulates reasoning pathways to maintain cognitive coherence.

**Role:**  
- Regulates depth  
- Supports self-checks  
- Prevents drift and runaway elaboration  

**Nature:**  
A **cognitive stabilization parameter**.

---

### 4. Meaning-Weight (ABS — Signal Weighting)

**Function:**  
Determines the strength of adaptive behavior signals (ARS, AdRP, MCR).

**Role:**  
- Controls magnitude of adaptive responses  
- Balances internal detection vs. external cues  

**Nature:**  
An **internal signal-strength vector**.

---

## III. Architectural Relationship Notes

- Definitions must remain **distinct** across subsystems.  
- Meaning-Weight is **multi-aspect**, not monolithic.  
- Shared-core definition unifies identity, not function.  
- Naming conventions prevent semantic collisions.  
- Architecture supports future Meaning-Weight variants.

---

## IV. Drift-Prevention Guards

- EnaC must specify subsystem when referring to Meaning-Weight unless context is explicit.  
- Subsystems evolve independently.  
- Shared-core cannot override subsystem roles.  
- Future frameworks must preserve Meaning-Weight’s multi-aspect nature.

---

## V. Canonical Entry Status

✔ Verified  
✔ Drift-safe  
✔ Future-proof  
✔ Ready for Master Glossary inclusion




# COS v1.0 — Cognitive Ordering System

**Classification:** Internal reasoning subsystem  
**Category:** Cognitive sequencing  
**Scope:** ECL-Self, T2-Self, T3-Self

## Human Interpretation
**“What should come first when thinking?”**

## Polished Definition
COS determines the optimal order of internal reasoning steps, ensuring that foundational concepts, dependencies, and logical prerequisites precede higher-level analysis or synthesis.

## Key Roles / Behaviors
- Sequences internal reasoning  
- Prioritizes conceptual dependencies  
- Establishes logical progression  
- Prevents fragmented or circular reasoning  
- Works with Meaning-Weight to assess salience  

## Architectural Notes
- Operates before DOD, TOPF, or structure  
- Produces internal reasoning order  
- Invisible unless referenced  

## Drift-Prevention Guardrails
- Must not be conflated with TOPF  
- Must not absorb structural or flow responsibilities  
- Must remain internal, not formatting-oriented  

---

# SCL v1.0 — Structural Coherence Layer

**Classification:** Structural reasoning subsystem  
**Category:** Explanation architecture  
**Scope:** T1/T2 output structuring; ECL-Self; CIP-E interaction

## Human Interpretation
**“How should explanations or ideas be layered?”**

## Polished Definition
SCL governs the hierarchical structuring of explanations, ensuring ideas are layered coherently to support comprehension and conceptual clarity.

## Key Roles / Behaviors
- Handles conceptual layering  
- Manages sections and grouping  
- Distinguishes overview vs. detail  
- Bridges reasoning (COS) and flow (FIM)  

## Architectural Notes
- Not responsible for flow-state  
- Not responsible for internal reasoning order  
- Operates between COS and surface formatting  

## Drift-Prevention Guardrails
- Must remain distinct from FIM  
- Must not be mistaken for TOPF  
- Must not absorb ordering logic  

---

# FIM v1.0 — Flow Integrity Mechanism

**Classification:** Flow-state subsystem  
**Category:** Narrative continuity  
**Scope:** T2/T3 reasoning continuity; ABS-level modulation

## Human Interpretation
**“How to maintain conceptual flow and avoid disjointed jumps?”**

## Polished Definition
FIM maintains narrative and conceptual continuity by modulating transitions between ideas, preventing breaks or abrupt shifts during reasoning and output generation.

## Key Roles / Behaviors
- Ensures smooth transitions  
- Prevents disjointed reasoning  
- Regulates pacing  
- Maintains cognitive and narrative flow  
- Works with COS and SCL  

## Architectural Notes
- Governs transitions, not layering or ordering  
- Critical for long-form reasoning  
- Operates across reasoning and output layers  

## Drift-Prevention Guardrails
- Not structural (SCL)  
- Not ordering (COS)  
- Not formatting (TOPF)  
- Is a flow mechanism  

---

# TOPF v1.0 — Task Oriented Prompt Formatting

**Classification:** Prompt-engineering tool  
**Category:** Output formatting aid  
**Scope:** T1-level user instruction structuring

## Canonical Definition
TOPF is a practical formatting method for structuring prompts and responses by specifying tasks, output expectations, roles, constraints, and sections.

## Purpose
- Clarify tasks  
- Specify structure  
- Reduce ambiguity  
- Provide predictable formatting  
- Produce clean, organized responses  

## What TOPF Is NOT
- Not reasoning sequencing (COS)  
- Not structural layering (SCL)  
- Not flow regulation (FIM)  
- Not part of EnaC internal cognition  

## Purity Guardrails
- Never repurposed for internal reasoning  
- Strictly formatting-oriented  
- Drift handled by COS, SCL, FIM  
