# LTF — Term Specification v2.0

## 0. Metadata
- **Term ID:** ltf-v2
- **Primary Name:** Living Task Framework
- **Acronym:** LTF
- **Version:** v2.0
- **Status:** Active
- **Domain:** UCS Semantic Core
- **Owner/Steward:** Cash Myers / EnaC

---

## 1. Identity & Purpose

### 1.1 Identity
LTF is the **semantic evolution engine** of the Unified Cognition Stack (UCS).

### 1.2 Concise Purpose
Transform structured meaning (from SCS, EchoForge, GlossRP) into:
- task nodes,
- semantic relationships,
- temporal evolution records (TEOs),
- and navigable semantic graphs

so that ideas gain lineage, structure, and long‑term usability.

---

## 2. Definitions

### 2.1 Architecture-Facing Definition
LTF is a system that:
- creates and manages TaskNodes representing units of work or conceptual focus,
- stores and queries semantic relationships between nodes,
- records Temporal Evolution Objects (TEOs) that capture drift, refinement, and change over time,
- provides classification and grouping services for artifacts and nodes based on semantic structure.

It does not perform raw capture, retrieval, or compilation; it operates on **already-structured** meaning.

### 2.2 Human-Facing Definition
LTF is the part of the system that turns ideas into living projects and maps how they change over time.  
It tracks tasks, how concepts connect, and how your thinking evolves.

---

## 3. Responsibilities

- Create and manage **TaskNodes** for ideas, projects, and work units.
- Maintain a **semantic graph** of concepts, tasks, and their relationships.
- Record **Temporal Evolution Objects (TEOs)** for changes in meaning, scope, or interpretation.
- Track **drift** (good or bad) and lineage across versions and interpretations.
- Group artifacts and nodes by:
  - concept,
  - framework,
  - tool,
  - project,
  - lineage,
  - TEO events.
- Provide APIs for:
  - querying neighborhoods,
  - tracing ancestry/descendants,
  - listing task clusters,
  - exporting views for PW and other tools.

---

## 4. Non-Responsibilities

LTF must **not**:
- capture raw audio/text (EchoForge),
- retrieve TermSpecs (GlossRP),
- compile Tier-specific meaning (SCS),
- manage LLM sessions or UI (PW),
- override ECL semantics defined elsewhere.

LTF works only with **structured inputs** and focuses on **relationships, tasks, and evolution**.

---

## 5. Inputs

Typical LTF inputs include:

- Task creation requests (from EchoForge, PW, or manual entry).
- Semantic bundles containing:
  - Term IDs,
  - SCS-compiled meaning slices,
  - classification tags.
- User-specified relationships (e.g., “this evolves from that”).
- System-detected drift events (e.g., via analysis of TEOs).

---

## 6. Outputs

LTF produces:

- TaskNode objects with links to concepts, artifacts, and projects.
- Relationship structures connecting nodes (depends_on, part_of, evolves_from, etc.).
- TEO records for evolution and drift.
- Grouped views of artifacts and nodes (for PW’s artifact explorer).
- Semantic graphs usable by visualizers or EnaCs.

---

## 7. Relationship to Other Systems

- **EchoForge → LTF**  
  Sends structured, validated summaries and intent as candidate TaskNodes.

- **GlossRP → LTF**  
  Supplies TermSpecs for binding tasks and nodes to concepts.

- **SCS → LTF**  
  Provides Tier-specific, compiled meaning slices for richer relational anchoring.

- **PW ↔ LTF**  
  PW queries LTF for:
  - grouped artifact lists,
  - task graphs,
  - evolution timelines;
  and uses them to drive the IDE experience.

LTF does *not* drive UI or models directly; it is a semantic backplane.

---

## 8. Failure Modes & Risks

- **Untracked drift** if TEOs are not captured consistently.
- **Graph fragmentation** if relationships are not created or maintained.
- **Overfitting semantics** if LTF is overloaded with compiler or retrieval logic.

Mitigations:
- Clear division of responsibility with SCS and GlossRP.
- Standardized schemas for TaskNodes, relationships, and TEOs.
- Health checks and audits on graph integrity and lineage coverage.

---

## 9. Evolution Notes

- LTF v1.x (conceptual) provided the idea of a “living task” system.
- v2.0:
  - formalizes TaskNodes,
  - defines TEOs,
  - clarifies role boundaries,
  - solidifies integration with PW, SCS, GlossRP, and EchoForge.

Future versions may:
- add automated drift detection,
- support richer relationship types,
- integrate analytics for evolution patterns.

---

## 10. SCS Compiler Blocks

```SCS_T1
LTF is the system that turns ideas into living tasks and tracks how they evolve over time.
```

```SCS_T2
The Living Task Framework (LTF) is the UCS subsystem that manages task nodes, semantic relationships, and temporal evolution objects (TEOs), so that concepts and projects gain structure, lineage, and navigable context across time.
```

```SCS_T3
- LTF <- EchoForge [relation: receives structured summaries and intent as TaskNodes]
- LTF <- GlossRP [relation: binds tasks to TermSpecs and concepts]
- LTF <- SCS [relation: uses Tier-specific meaning slices as relational anchors]
- LTF -> PW [relation: supplies task graphs, grouped artifacts, and evolution views]
- LTF !> capture [constraint: no raw audio/text ingestion]
- LTF !> retrieval [constraint: no TermSpec retrieval]
- LTF !> compilation [constraint: no Tier-specific semantic compilation]
```
