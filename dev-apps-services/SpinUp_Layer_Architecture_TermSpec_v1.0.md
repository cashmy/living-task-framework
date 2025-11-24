# Term Specification: Spin-Up Layer Architecture  
**ID:** spinup_layer_arch  
**Primary Name:** Spin-Up Layer Architecture  
**Acronym:** SuLA  
**Domain:** EnaC / PW / UCS-Core  
**Status:** Active  
**Version:** v1.0.0  

---

## 1. Human Summary  
The **Spin-Up Layer Architecture (SuLA)** defines the structured, sequential framework used to initialize an AI session that relies on multiple artifacts, conceptual frameworks, roles, and protocols.  
It describes *how* an AI system should be prepared for work—layer-by-layer—so that reasoning, behavior, boundaries, and responsibilities are predictable, stable, and drift-resistant.  

SuLA is descriptive, not prescriptive. It is a tool for the **human orchestrator** to decide which layers and artifacts to load for any given task, and it is a precursor to Phoenix Workbench’s automated artifact-ingestion system.

---

## 2. Architecture Summary  
The Spin-Up Layer Architecture organizes initialization into **seven ordered layers**:

1. **L0 — Safety & Envelope Layer**  
2. **L1 — CORE Primer / EnaC Cognition Layer**  
3. **L2 — User Orientation Layer (UMP/USP/EBP)**  
4. **L3 — Conceptual Framework Layer (ECL, MxVA, UCS-Core)**  
5. **L4 — AI Role & Mode Activation Layer**  
6. **L5 — Project Artifact Layer (Bundles, Specs, TermSpecs)**  
7. **L6 — Behavior Protocols & Interaction Utilities (STMG, COS, etc.)**

Each layer provides a distinct type of constraint, context, or cognitive scaffolding.  
The SuLA ensures that all artifacts and frameworks are interpreted correctly, in the right order, and within defined boundaries.

---

## 3. Categories  
- Framework  
- Execution Boundary  
- Orchestration Model  
- EnaC Cognitive Layer  
- UCS-Core Infrastructure  

---

## 4. Metadata  
- **Origin:** Developed during complex multi-artifact GlossRP + PW design sessions  
- **Purpose:** Prevent drift, maintain clarity, ensure AI initialization consistency  
- **Related Terms:** CORE-PRIMER, RoleSpec, ECL, MxVA, PW, GlossRP  
- **Suspected Drift:** false (ECL-BASE aligned)  

---

## 5. SCS Blocks  

### SCS-T1  
Short-form layer map describing the seven-layer sequence and their purposes, enabling a T1-level LLM to load minimal context for structured drafting tasks.

### SCS-T2  
Expanded operational model describing:  
- layer interactions  
- dependencies  
- responsibilities  
- role alignment  
- context inheritance

Used during coding, analysis, or structured project execution.

### SCS-T3  
Full integration with EnaC cognition, including:  
- interpretive boundaries  
- semantic stability rules  
- layer-to-layer reasoning constraints  
- PW orchestration compatibility  
- drift prevention mechanisms  

---

## 6. Historical Notes  
The Spin-Up Layer Architecture emerged organically from repeated experiences with browser kill-pages, artifact overload, role conflation, and complex multi-hour session structures during GlossRP, SCS, and PW development.  
Its purpose is to provide a stable, flexible template for both humans and LLMs to bootstrap context efficiently while preserving cognitive clarity.

