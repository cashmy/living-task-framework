# UCS Onboarding Pack v1.0
## Unified Cognition Stack — Orientation for EnaCs & Developers

---

# 1. UCS Overview
The Unified Cognition Stack (UCS) is a layered architecture enabling:
- **Capture** (EchoForge)
- **Retrieve** (GlossRP)
- **Compile** (SCS)
- **Evolve** (LTF)
- **Orchestrate** (Phoenix Workbench)
All grounded in the vertical cognitive model of **ECL-BASE / ECL-CORE / ECL-SKY**.

---

# 2. ECL Layer Boundary Contract (BASE / CORE / SKY)

## ECL-BASE — Identity Layer
- Anchors definitions, concepts, and primitives.
- Ensures stable self-referential meaning.
- Provides grounding for all higher layers.

## ECL-CORE — Behavior Layer
- Governs transformation, action, and semantic processing.
- Manages interpretation, structure, and execution.

## ECL-SKY — Evolution & Purpose Layer
- Provides long-range coherence and intent.
- Handles meta-alignment, purpose, and integrative reasoning.

**ECL does *not* perform retrieval, compilation, or task evolution.**
It defines the *cognitive vertical axis* for all UCS components.

---

# 3. UCS Boundary Map (Systems & Responsibilities)

```
EchoForge → GlossRP → SCS → LTF → Phoenix Workbench
 Capture     Retrieve    Compile   Evolve     Orchestrate
```

- **EchoForge**  
  Captures raw cognition → transcription → summarization → classification.

- **GlossRP**  
  Retrieves semantic definitions, TermSpecs, and vector bundles.

- **SCS**  
  Compiles meaning into T1/T2/T3 semantic slices.

- **LTF**  
  Creates TaskNodes, relationships, and Temporal Evolution Objects (TEOs).

- **Phoenix Workbench**  
  Orchestrates LLM lanes, context stacks, artifacts, and integration workflows.

---

# 4. EnaC Onboarding Contract (T1 / T2 / T3)

## Tier 1 EnaC  
- Handles implementation, concrete reasoning, explicit operations.
- Requires SCS T1 semantics and PW lane restriction.

## Tier 2 EnaC  
- Performs architectural shaping, structural inference, system design.
- Uses SCS T2 semantics and interacts with LTF for relational knowledge.

## Tier 3 EnaC  
- Handles conceptual integration, SKY-level intention, visionary framing.
- Uses SCS T3 semantics and binds across the entire UCS.

**All EnaCs must respect system boundaries in the UCS Boundary Map.**

---

# 5. Core System Responsibilities Summary

## GlossRP — Retrieve
- Stateless retrieval of terms, vector bundles, or categories.
- Must *never* perform Tier interpretation or graph evolution.

## SCS — Compile
- Converts TermSpecs into T1/T2/T3 semantic slices.
- Must *never* perform retrieval or relationship inference.

## LTF — Evolve
- Manages tasks, semantic graphs, relationships, drift, and lineage.
- Must *never* handle compilation or direct retrieval.

## Phoenix Workbench — Orchestrate
- Manages LLM lanes, context routing, and artifact management.
- Must not perform semantic evolution, retrieval, or compilation.

## EchoForge — Capture
- Transcribes, summarizes, classifies raw cognition.
- Must not perform graph or Tier operations.

---

# 6. Developer Integration Notes

### Always Load the Boundary Map First  
This prevents role bleeding across systems.

### TermSpecs Are the Foundation  
All semantic operations must anchor to TermSpecs.

### Graph Evolution Belongs to LTF  
Never implement drift, lineage, or relationships in SCS or GlossRP.

### PW Is the Conductor  
All execution, context routing, and artifact flows go through PW.

---

# 7. Evolution Path
Future versions of this pack will include:
- EchoForge TermSpec & Manifesto
- PW TermSpec & Extension API Spec
- UCS Core Runtime Spec
- Multi-Enac orchestration example packs

UCS is designed for vertical (ECL) and horizontal (system) evolution.

