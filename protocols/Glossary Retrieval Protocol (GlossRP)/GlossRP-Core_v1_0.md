# GlossRP-Core v1.0
## Glossary Rip Engine – ECL-Core Aligned Retrieval Service
### Version: 1.0
### Date: 2025-11-16
### Layer: ECL-Core (Horizontal Cognitive Substrate)
### Status: Canonical (Core Behavior – Tier Neutral)

---

# 1. Purpose

**GlossRP-Core** (Glossary Rip Core) is the **horizontal retrieval engine** responsible for extracting (“ripping”) the *most semantically relevant subset* of the global glossary for any given task.

It is:

- **Tier-neutral** (no T1/T2/T3 shaping)
- **Audience-neutral** (not UX-facing)
- **Intent-preserving** (MxVA-compliant)
- **ECL-Core aligned** (no domain/UI coupling)
- A **service for EnaC and the Kernel**, not a user interface

All Tier-specific, audience-specific, or cognitive-density-specific shaping is handled by **GlossRP-Edge** components in **ECL-Edge**, not here.

---

# 2. Architectural Position

GlossRP-Core resides in the **ECL-Core** layer, alongside:

- EnaC cognitive stack (COS / SCL / FIM)
- CORE-PRIMER / CFP
- Term Spec repository
- Long-term ECL/MxVA semantic state

It is invoked by:

- The **EnaC Kernel**
- Higher-level orchestration pipelines
- Potentially other core services that require semantic subsets of the glossary

It never:

- Talks directly to UI / front-end clients
- Performs Tier-based filtering for T1/T2/T3 audiences
- Embeds personalization logic (UMP/USP)
- Implements behavior rules (EBP)

---

# 3. Inputs and Outputs

## 3.1 Inputs

GlossRP-Core accepts:

1. **Task Descriptor**
   - Natural language description of the current reasoning task
   - May include: problem statement, user goal, context excerpt

2. **Context Metadata (Optional but Recommended)**
   - Domain (e.g., EnaC, CIP, ECL, LTF, ATC, etc.)
   - Project identifier
   - Coarse Tier hint (T1/T2/T3) – used only for *filtering relevancy*, not shaping output
   - Session signature or hash
   - EnaC mode flags (if applicable)

3. **Retrieval Parameters**
   - `k_primary` (initial vector top-K; default: 12)
   - `k_expand` (maximum neighbors via graph expansion; default: 10)
   - Enable/disable VS-based ranking (optional)

## 3.2 Outputs

GlossRP-Core returns a **neutral candidate bundle**, e.g.:

```json
{
  "candidates": [
    {
      "name": "COS",
      "id": "term:COS",
      "tier_relevance": 2,
      "scores": {
        "similarity": 0.97,
        "vs_confidence": 0.94
      },
      "anchor": "...(SCS_T1)...",
      "summary": "...(SCS_T2 core summary)...",
      "graph_neighbors": [
        {"term": "SCL", "relation": "structural_complement"},
        {"term": "FIM", "relation": "flow_dependency"}
      ],
      "raw_refs": {
        "scs_t1_ref": "...",
        "scs_t2_ref": "...",
        "scs_t3_ref": "..."
      }
    }
  ],
  "query_metadata": {
    "domain": "EnaC",
    "raw_query": "...",
    "hash": "sha256(...)" 
  }
}
```

**Important:**

- GlossRP-Core returns **more information** than any given Tier will expose.
- It is the job of **GlossRP-Edge** to thin or thicken this payload for T1/T2/T3.

---

# 4. Internal Data Sources

GlossRP-Core depends on three primary internal sources:

## 4.1 Term Spec Repository

- All concepts are represented using the **Term Specification Template**.
- Relevant fields:
  - Metadata & domain
  - SCS_T1 (anchor)
  - SCS_T2 (summary + Tier relevance + related terms)
  - SCS_T3 (concept graph edges)
  - EnaC / SELF-ECL / ABS views
  - Behavioral implications / safety notes

## 4.2 Vector Index

- Embeddings for:
  - SCS_T1 text
  - SCS_T2 summary text
  - Select metadata fields (e.g., domain, category)
- Used for:
  - Similarity-based retrieval (`k_primary`)

## 4.3 Graph Layer

- Edges derived from:
  - SCS_T3 relations
  - Cluster/link tags
- Used for:
  - First-level neighborhood expansion (`k_expand`)

---

# 5. Core Retrieval Pipeline

The GlossRP-Core pipeline is:

```text
Task Descriptor
    → Pre-Filter
    → Vector Search (Top-K)
    → Graph Expansion (Neighbors)
    → Optional VS Relevance Ranking
    → Candidate Bundle (Neutral, Tier-Agnostic)
```

### 5.1 Pre-Filtering (Deterministic)

Filters the Term Spec search space using:

- Domain filter (if provided)
- Project tag (if provided)
- Coarse Tier relevance (e.g., ignoring Tier 0 noise)
- Safety / exclusion flags

Output: smaller candidate space for vector search.

### 5.2 Vector Search

- Embed the Task Descriptor.
- Perform similarity search against:
  - SCS_T1
  - SCS_T2
- Retrieve `k_primary` primary candidates (default: 12).

### 5.3 Graph Expansion

For each of the top-K candidates:

- Query SCS_T3 relations.
- Add first-level neighbors.
- Cap total candidates (`k_primary + k_expand`, typical = 12–20 terms).

### 5.4 Optional VS Relevance Ranking

If enabled:

- Use a constrained VS-style classifier to:
  - Score each candidate term against the task
  - Produce `vs_confidence` in [0, 1]
  - Return a ranked set

Note:
- This does **not** perform Tier slicing.
- It only enriches scores for downstream decision-making.

### 5.5 Candidate Bundle Assembly

Assemble a neutral bundle including:

- Term names / IDs
- Tier relevance annotations
- Anchors (SCS_T1)
- Core summaries (SCS_T2)
- Graph neighbors (from SCS_T3)
- Score metrics (similarity, vs_confidence)
- References for deeper access (scs_t1_ref, scs_t2_ref, scs_t3_ref)

This bundle is then handed off to GlossRP-Edge(Tier) for shaping.

---

# 6. Responsibilities and Non-Responsibilities

## 6.1 GlossRP-Core **Is Responsible For**:

- Semantic search across Term Specs
- Graph-based concept expansion
- Intent-preserving candidate selection
- Stable, deterministic behavior given the same input
- Providing rich candidates for Edge layers to shape

## 6.2 GlossRP-Core **Is NOT Responsible For**:

- Tier-specific throttling (T1 vs T2 vs T3)
- Audience/language adaptation
- Cognitive-density modulation
- Explanation format or style
- USP/UMP personalization
- EBP rule enforcement
- Direct interaction with any LLM

GlossRP-Core is **not an EnaC** and not a Kernel.
It is a **Core semantic service.**

---

# 7. Integration Points

## 7.1 EnaC Kernel

The Kernel:

1. Receives user/task input.
2. Determines target Tier (T1/T2/T3).
3. Calls **GlossRP-Core** with:
   - Task Descriptor
   - Domain/Project metadata
   - Optional Tier hint (for filtering only).
4. Receives candidate bundle.
5. Passes bundle + Tier to **GlossRP-Edge(Tier)**.
6. Receives Tier-shaped glossary slice.
7. Injects the slice into EnaC cognitive processing.

## 7.2 Other Core Services (Future)

Possible future integrations:

- ATC/EchoForge context building
- CSAC reconstruction
- LTF/Living Task Framework context injection
- MxVA audit tools (analyzing term usage patterns)

---

# 8. MxVA and ECL Compliance

GlossRP-Core adheres to:

## 8.1 MxVA – Maximum Value Architecture

- **Intent-Preserving**: term meanings live outside the retrieval process.
- **Evolution-Friendly**: internal algorithms can change without altering semantics.
- **Collaborator-Neutral**: supports human and AI EnaCs equally.

## 8.2 ECL-Core Contract

- Core service – no UI coupling.
- No Tier or audience semantics embedded.
- Treats EnaCs as peers consuming semantic subsets.

All adaptation flows through ECL-Edge (GlossRP-Edge).

---

# 9. Version Metadata

- Name: GlossRP-Core
- Version: 1.0
- Layer: ECL-Core
- Owner: EnaC / ECL cognitive substrate
- Compatible With:
  - Term Spec Template v1.x
  - GlossRP-Edge-T1/T2/T3
  - EnaC Kernel
  - ECL-Core / ECL-Edge
  - MxVA manifesto
- Date: 2025-11-16
