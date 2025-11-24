# GlossRP — Term Specification v2.0

## 0. Metadata
- **Term ID:** glossrp-v2
- **Primary Name:** GlossRP
- **Expansion:** Glossary Retrieval Platform / Gloss Ripper
- **Version:** v2.0
- **Status:** Active
- **Domain:** UCS Semantic Core
- **Owner/Steward:** Cash Myers / EnaC

---

## 1. Identity & Purpose

### 1.1 Identity
GlossRP is the **Semantic Retrieval System** for the Unified Cognition Stack (UCS).

### 1.2 Concise Purpose
Provide deterministic, Tier-neutral retrieval of:
- TermSpecs,
- semantic neighborhoods (vector bundles),
- category-based term collections,

for use by SCS, LTF, PW, and EnaCs.

---

## 2. Definitions

### 2.1 Architecture-Facing Definition
GlossRP is a stateless retrieval service that indexes TermSpecs and related semantic metadata and exposes them via a small set of query interfaces (by id/acronym/title, vector similarity, and category). It does not perform Tier-specific compilation, relationship creation, or evolution tracking.

### 2.2 Human-Facing Definition
GlossRP is the “library lookup system” for your concepts. It finds the right terms and related concepts and hands them to the rest of the system.

---

## 3. Responsibilities

- Index and store TermSpecs and basic metadata.
- Perform direct lookups by id, acronym, or name.
- Perform vector search for semantic neighbors.
- Retrieve groups of terms by category.
- Return raw `SCS_T3` relationship metadata when requested (for SCS/LTF use).

---

## 4. Non-Responsibilities

GlossRP must **not**:
- generate or evolve relationships,
- apply Tier rules (T1/T2/T3),
- compile or condense meaning,
- manage evolution, TEO, or drift,
- generate human-facing artifacts.

---

## 5. Retrieval Modes

1. **Single Term Mode**
   - Input: id/acronym/title.
   - Output: one TermSpec and its metadata.

2. **Vector Bundle Mode**
   - Input: seed term or semantic query.
   - Output:
     - primary TermSpec,
     - ECL-group neighbors,
     - VS-group neighbors,
     - systems-related neighbors (frameworks/tools/etc.),
     - optional raw relationship metadata.

3. **Category Mode**
   - Input: one or more categories (e.g., `concept`, `framework`, `tool`).
   - Output: all TermSpecs labeled with those categories.

---

## 6. Relationship to Other Systems

- **SCS (Semantic Compiler System)**  
  - GlossRP supplies TermSpecs and raw relationships.  
  - SCS compiles them into Tier-specific, density-modulated outputs.

- **LTF (Living Task Framework)**  
  - GlossRP supplies identity and neighborhood data.  
  - LTF creates, evolves, and stores relationships & evolution events.

- **Phoenix Workbench**  
  - GlossRP supplies term sets (via Category Mode).  
  - PW renders Master Glossary, Human Glossary, and related artifacts.

---

## 7. Failure Modes & Risks

- **Outdated TermSpecs** if the TermSpec store is not kept current.
- **Overloading GlossRP** with non-retrieval logic (B-Drift toward SCS/LTF roles).
- **Inconsistent categories** if TermSpecs are not tagged systematically.

Mitigations:
- Enforce clear boundaries.
- Maintain TermSpec discipline.
- Add health checks and sanity tests for retrieval consistency.

---

## 8. Evolution Notes

- v1.x lineage (GRP, GlossRP-Core) is considered **historical** and superseded.
- v2.0 establishes:
  - pure retrieval identity,
  - explicit non-responsibilities,
  - retrieval modes aligned with UCS needs.

Future versions may:
- add filters and ranking,
- optimize storage,
- extend categories,

but must remain retrieval-only.

---

## 9. SCS Compiler Blocks

```SCS_T1
GlossRP is the UCS system that finds and returns the right terms and semantic neighbors.
```

```SCS_T2
GlossRP is a Tier-neutral semantic retrieval service that returns TermSpecs, semantic neighborhoods, and category-based term groups for use by SCS, LTF, Phoenix Workbench, and EnaCs. It never creates relationships or applies Tier logic; it only retrieves and packages existing semantic data.
```

```SCS_T3
- GlossRP -> SCS [relation: supplies TermSpecs and raw SCS_T3 metadata]
- GlossRP -> LTF [relation: supplies term identities and semantic neighborhoods]
- GlossRP -> PW [relation: supplies category-based term sets]
- GlossRP !> relationships [constraint: does not create or evolve relationships]
- GlossRP !> tiers [constraint: no Tier-specific behavior]
```
