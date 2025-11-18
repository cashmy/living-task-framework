# Phase 1 Implementation Task Map  
## GlossRP + EnaC Kernel Development  
### Version: 0.1  
### Date: 2025-11-16  
### Status: Authoritative Engineering Plan (Phase 1)

---

# 1. Purpose  
This Implementation Task Map outlines the full set of engineering tasks required to build the **Phase 1 (MVP)** version of the GlossRP Retrieval System and EnaC Kernel.  
It is designed for **coding-specialized LLMs** (Claude Sonnet, GPT‑5 Codex, etc.) and engineering collaborators.

This is a *build-ready* plan.

---

# 2. Phase 1 High-Level Objectives  
Phase 1 delivers a functional end‑to‑end MVP:

- **Term Spec Repository** (DB + ingestion)  
- **Embedding + Vector Store**  
- **GlossRP-Core Retrieval Engine**  
- **GlossRP-Edge-T2 Adapter**  
- **Minimal EnaC Kernel** orchestrating Core → Edge → Reasoning  
- **Tier-Adaptive Retrieval Demo** (T2 only)  
- **Cognitive Alignment Module integrated at startup**

---

# 3. Tasks by Subsystem  

---

# 3.1 Term Specification Subsystem  
## 3.1.1 Database Schema (High Priority)
- Define SQL models for:
  - `terms`
  - `scs_t1`, `scs_t2`, `scs_t3`
  - `relations` table (graph edges)
  - `metadata` (domain, tags, tier relevance)
  - `views` (EnaC, SELF-ECL, ABS)
- Choose backend:
  - SQLite + Vec (simple)
  - or Postgres + pgvector (scalable)

## 3.1.2 Term File Ingestion Pipeline
- Parse Term Spec `.md` → structured JSON
- Validate required fields
- Populate DB tables
- Extract SCS_T1/T2/T3 sections
- Build graph edges from SCS_T3
- Store EnaC/SELF-ECL/ABS views

## 3.1.3 Term Versioning (Optional)
- Store original MD for integrity
- Keep hash of raw text
- Add `version` field to schema

---

# 3.2 Embeddings + Vector Store  
## 3.2.1 Embedding Generation
- Use OpenAI or local embeddings
- Generate vectors for:
  - SCS_T1 text
  - SCS_T2 core summary
- Store embeddings in DB (or external vector DB)

## 3.2.2 Vector Search
- Implement similarity search using:
  - PostgreSQL `pgvector` or
  - SQLite Vec or
  - Qdrant (if external service acceptable)
- Wrap results in unified API

---

# 3.3 Graph Layer  
## 3.3.1 Graph Model
- Build adjacency list from SCS_T3 entries
- Store edges with relations (e.g., “complement”, “dependency”)

## 3.3.2 Graph Expansion Logic
- Given a term ID:
  - fetch neighbors
  - cap neighbor count
  - add neighbor terms to candidate set

---

# 3.4 GlossRP-Core Retrieval Engine  
## 3.4.1 Pre-Filtering Module
- Domain filtering
- Tag filtering
- Optional: coarse Tier relevance filter (not shaping)

## 3.4.2 Vector Search Module
- Accepts Task Descriptor
- Embeds query
- Performs top‑K retrieval
- Returns list of candidate term IDs + similarity scores

## 3.4.3 Graph Expansion Module
- Expands candidates using graph edges
- Adds neighbor terms
- Avoids duplicates

## 3.4.4 Optional VS Relevance Ranking
- Lightweight scoring heuristic
- Produces `vs_confidence`

## 3.4.5 Bundle Assembly
- Assemble final candidate bundle:
  - names
  - SCS_T1 anchors
  - SCS_T2 summaries
  - SCS_T3 neighbors
  - scores
  - metadata

---

# 3.5 GlossRP-Edge-T2 Adapter  
## 3.5.1 Term Selection Logic
- Rank terms by:
  - vs_confidence
  - similarity
  - graph centrality
- Select 6–10 top candidates

## 3.5.2 T2 Transformation
- Include:
  - SCS_T1
  - SCS_T2
  - Selected SCS_T3 neighbors
- Extract:
  - Operational utility notes (optional)
  - Structural relevance

## 3.5.3 T2 Output Structure
- JSON with:
  - `name`
  - `label`
  - `scs_t1`
  - `scs_t2`
  - `related_terms`

---

# 3.6 EnaC Kernel (MVP Implementation)  
## 3.6.1 Tier Determination
- For Phase 1:
  - Hardcode Tier = T2
  - Use simple rule (e.g., developer mode)

## 3.6.2 Kernel Flow Implementation
Implement pipeline:

```
Task Descriptor
→ GlossRP-Core
→ GlossRP-Edge-T2
→ Inject glossary slice
→ LLM reasoning output
```

## 3.6.3 Kernel API
- Accepts:
  - `task`
  - optional metadata
- Returns:
  - structured reasoning result
  - gloss slice used

---

# 3.7 Startup Sequence & Initialization  
## 3.7.1 Load Control Files
- CORE-PRIMER  
- UMP  
- USP  
- Cognitive Alignment Insight Module  
- EnaC Behavior Profile

## 3.7.2 In-Memory Cache
- Pre-load Term Specs (optional)
- Pre-load vector index (optional)
- Pre-warm embedding model (optional)

---

# 3.8 Testing & Validation  
## 3.8.1 Unit Tests
- Parsing MD → Term Spec
- Embedding generation
- Vector search correctness
- Graph expansion

## 3.8.2 Integration Tests
- Term ingestion → DB → vector search
- GlossRP-Core pipeline
- GlossRP-Edge → T2 slice generation

## 3.8.3 Full End‑to‑End Test
Test with:
- “Retrieve EnaC terms relevant to context reconstruction”
- “Explain decision flow for COS/SCL/FIM”
- “Provide glossary for EnaC reasoning about drift prevention”

---

# 4. Dependencies & Order of Implementation  

1. **DB + Term Spec ingestion**  
2. **Embedding + vector search**  
3. **Graph layer**  
4. **GlossRP-Core**  
5. **GlossRP-Edge-T2**  
6. **EnaC Kernel MVP**  
7. **End‑to‑end retrieval demo**

This order minimizes errors and maintains ECL-Core/ECL-Edge integrity.

---

# 5. Risks & Mitigations  

## 5.1 Risk: Tier Bleed  
- T3 details entering T1/T2  
- *Mitigation:* enforce Edge-specific safety boundaries.

## 5.2 Risk: Semantic Drift  
- Term meanings shift over time  
- *Mitigation:* Term Spec versioning + Core invariants.

## 5.3 Risk: Overloaded Context  
- Coding LLM overwhelmed by architecture  
- *Mitigation:* staged loading (Phase 0 → Phase 1 files).

## 5.4 Risk: Graph Explosion  
- Too many neighbors from SCS_T3  
- *Mitigation:* limits on graph depth/width.

---

# 6. Definition of Done (DoD)  

A **Phase 1 MVP** is complete when:

- 50+ Term Specs ingested & vectorized  
- GlossRP-Core returns top‑K candidates deterministically  
- GlossRP-Edge-T2 produces valid Tier 2 slices  
- Kernel can process:
  ```
  Task → Core → Edge → LLM Reasoning
  ```
- A sample T2 retrieval scenario works end‑to‑end  
- All components obey:
  - MxVA
  - ECL-Core/ECL-Edge contracts
  - Tier boundaries  

---

# 7. Version Metadata  
- File: Phase_1_Implementation_Task_Map_v0_1.md  
- Version: 0.1  
- Intended Users: Cash Myers, coding specialist LLMs, EnaC Kernel implementers  
- Date: 2025-11-16  
