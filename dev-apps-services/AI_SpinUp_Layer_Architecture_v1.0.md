# AI Spin-Up Layer Architecture  
## Version 1.0 — Multi-Layer Artifact Loading Guide for Human + LLM Sessions

---

## 0. Purpose

This document defines the **Spin-Up Layer Architecture** used to initialize an AI session for highly structured, multi-artifact, multi-framework work—such as GlossRP, LTF, PW, ECL, and UCS-Core components.

This guide is:

- **Descriptive**, not prescriptive  
- A **reference map** for the human orchestrator  
- A **load-order guide** for LLM initialization  
- A blueprint for **Phoenix Workbench’s future interactive artifact-loader**  
- Designed to prevent overload, drift, and layer-conflation in AI sessions  
- Intended to reduce cognitive strain by giving you a clear, reusable framework

This architecture is technology-agnostic and applies to ANY LLM (T1–T3).

---

# 1. Overview of Spin-Up Layers

The spin-up process consists of **seven layers**, loaded in the sequence shown:

1. **Safety & Envelope Layer (L0)**  
2. **CORE Primer / EnaC Engine Layer (L1)**  
3. **User Orientation Layer (L2)**  
4. **Conceptual Framework Layer (L3)**  
5. **AI Role & Mode Activation Layer (L4)**  
6. **Project Artifact Layer (L5)**  
7. **Behavior Protocols & Interaction Utilities (L6)**  

Each layer contributes a different part of the cognitive and operational environment.

---

# 2. Layer Definitions

---

## L0 — Safety & Envelope Layer  
**Purpose:** Establish baseline session safety, output density, guardrails, and structural constraints.

**Examples:**

- Artifact Output Policy (AOP)  
- Output Density Settings (DOD1–6)  
- Session Safety Envelope  
- Error Mode defaults  
- Response structure constraints

**Considerations:**

- Must load **before** any conceptual or cognitive system  
- Minimizes drift and runaway verbosity  
- PW will use this to protect downstream layers  
- Usually very lightweight but critically important  

---

## L1 — CORE Primer / EnaC Engine Layer  
**Purpose:** Define the AI’s cognitive engine, meta-reasoning behavior, epistemic stack, and sense-making style.

**Examples:**

- CORE-PRIMER  
- T3 CORE PRIMER v3.x  
- EnaC Behavior Profile (EBP)  
- Concept Mode Protocol  
- EnaC Adaptive Behavior Layer definitions

**Considerations:**

- This is the **fundamental thinking substrate**  
- Determines the AI’s default reasoning model  
- All higher layers interpret themselves *through* this layer  
- MUST be loaded before frameworks or project artifacts  

---

## L2 — User Orientation Layer (Human Lens)  
**Purpose:** Anchor the AI’s behavior to the identity, goals, style, and preferences of the human collaborator.

**Examples:**

- UMP (User Meta-Prompt)  
- USP (User State Profile)  
- EBP specific-to-human preferences  
- Communication and abstraction preferences  
- Known expertise levels and domain fluency cues  

**Considerations:**

- This tells the AI **who it is working with and for**  
- Strong influence on T1 and T2, contextual influence on T3  
- Should be updated over time as human evolves  
- Keeps “Being Heard Protocol” active without being overbearing  

---

## L3 — Conceptual Framework Layer  
**Purpose:** Load the core philosophical, architectural, and cognitive frameworks used across all UCS projects.

**Examples:**

- ECL (Base/Core/Sky)  
- MxVA (Minimum/Maximum Viable Architecture)  
- UCS Core Pack  
- Drift Taxonomy and relationships  
- Conceptual boundaries: BASE vs CORE vs SKY  
- Multi-Agent SAAS metamodels  

**Considerations:**

- These define *how the system thinks about systems*  
- They give interpretive shape to project artifacts  
- Must load after L1 and L2 to inherit:
  - reasoning structure  
  - human context  
- These frameworks are long-term stable and evolve slowly  

---

## L4 — AI Role & Mode Activation Layer  
**Purpose:** Declare the operational mode, role, and tier of the AI for this session.

**Examples:**

- Role: Coding LLM, Architect, Analyst, Strategist, Researcher  
- Tier activation: T1 / T2 / T3  
- Special mode flags (e.g., Concept Mode, Design Mode)  
- Domain specializations (e.g., PW Architect, GlossRP engineer)  

**Considerations:**

- Prevents misalignment  
- Prevents accidental “Architect mode” when doing T1 drafting  
- Aligns cognitive intensity with task scope  
- T3 requires L1–L3 loaded; T1 requires only basic layers  
- Must be explicit  

---

## L5 — Project Artifact Layer  
**Purpose:** Load the specific artifacts, documents, bundles, specs, and assets relevant to the current task.

**Examples:**

- GlossRP Bundle:
  - Invariants  
  - Architecture Spec  
  - Logical Data Model  
  - Internal Modules  
  - Implementation Milestones  
- TermSpec documents  
- SCS Architecture Spec  
- LTF Architecture and Manifestos  
- PW Architecture Specs  
- E2E Flow documents  

**Considerations:**

- The *execution context* of the session  
- Must load after conceptual frameworks (L3)  
- Tasks may require only subsets of artifacts  
- This layer is where “session size” expands  
- This layer is the primary driver of kill-pages in browsers  
- PW will eventually automate selective loading to prevent overload  

---

## L6 — Behavior Protocols & Interaction Tools  
**Purpose:** Load optional utilities that enhance interaction and productivity but do not add semantic weight.

**Examples:**

- STMG (Semantic Trigger Markdown Generator)  
- GlossRP Tools (Glossary Exporter)  
- COS (Cognitive Ordering System)  
- FIM (Flow Integrity Mechanism)  
- SCL (Structural Coherence Layer)  
- ABS (Adaptive Behavior Stack)  
- Semantic Trigger Recorder  

**Considerations:**

- These must stay in **ECL-BASE**  
- Should never alter semantic meaning  
- Loaded last because they “wrap” behavior rather than define it  
- Essential for productivity workflows  
- T3 uses these to maintain structural coherence under high load  

---

# 3. Layer Application Patterns

Different tasks require different layer subsets.

## Example: Coding Implementation Session for GlossRP  
Load layers: **L0 → L1 → L2 → L3 → L4 (Coding) → L5 (GlossRP bundle)**  
Optional: L6 (STMG, COS, etc.)

## Example: High-level strategy and architecture  
Load layers: **L0 → L1 → L2 → L3 → L4 (Architect)**  
L5 optional  
L6 optional

## Example: T1 Writing / Drafting  
Load layers: **L0 → L1 → L2**  
Skip L3+ unless needed

## Example: PW debugging or design  
Load layers: **L0 → L1 → L2 → L3 → L4 (PW Architect) → L5 (PW bundle)**

---

# 4. PW Integration Notes

Phoenix Workbench will eventually:

- Present each layer as a selectable module  
- Show which artifacts belong to which layer  
- Enable drag-and-drop artifact ingestion  
- Prevent invalid ordering  
- Auto-generate layer-aware context packets for T1/T2/T3 LLMs  
- Warn when load exceeds safe thresholds  
- Allow dynamic reload of L2, L4, L6 without affecting L1/L3 stability  
- Store “session templates” for repeated workflows

This document is the **pre-spec** for the PW Artifact Loader.

---

# 5. Human/LLM Usage Instructions

### For the Human Orchestrator
- Decide which layers you want to load based on task  
- Upload only those artifacts  
- Avoid unnecessary loading of:
  - full GlossRP bundles  
  - multiple conceptual frameworks  
  - full-term libraries  
- Maintain conscious control to prevent architecture drift  

### For the LLM
- Confirm which layers were loaded  
- Do not assume missing layers  
- Ask clarifying questions only if crucial for correctness  
- Maintain ECL-BASE boundaries when assisting  

---

# 6. Final Notes

This spin-up architecture:

- Restores structural clarity during complex sessions  
- Minimizes cognitive and technical overload  
- Provides a reusable template across all future tasks  
- Serves as an early design document for PW + multi-agent orchestration  
- Prevents drift while enabling evolution

---

**End of AI Spin-Up Layer Architecture v1.0**
