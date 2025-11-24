# GlossRP Implementation Milestones  
## Version 2.2 — Updated for Hybrid Category Model & Tools Suite Integration

---

## 0. Purpose & Usage

This version updates the milestone plan to align with:

- GlossRP Logical Data Model v2.2  
- Hybrid Category Model (raw + canonical)  
- External Tools Suite (Glossary Exporter + Category Curation Tool)  
- Updated Architecture & Internal Modules v2.2  

All category‑centric responsibilities have been moved from core GlossRP to the **Category Curation Tool**, and ingestion now preserves **raw_categories**.

---

## 1. Milestone Overview

| ID  | Milestone                                      | Objective                                                      | Depends On      |
|-----|-----------------------------------------------|----------------------------------------------------------------|-----------------|
| M1  | Project Bootstrap & Tech Stack                | Create base project structure and choose implementation stack  | —               |
| M2  | Logical Data Model & DB Schema                | Implement DB schema + migrations for v2.2                     | M1              |
| M3  | StorageAdapter Implementation                 | Persistence layer w/ raw categories + pgvector                | M2              |
| M4  | IngestionService Core                         | Ingest TermSpecs incl. raw_categories                         | M3              |
| M5  | RetrievalEngine — Canonical + Raw Modes       | Retrieval via canonical categories + raw category awareness   | M3              |
| M6  | RetrievalEngine — Vector Bundle Mode          | Vector search and similarity retrieval                        | M3              |
| M7  | ApiGateway — REST (v2.2)                      | Core + new curation endpoints (pass-through only)             | M4, M5, M6      |
| M8  | ApiGateway — gRPC (v2.2)                      | Retrieval & ingestion via gRPC                                | M5, M6          |
| M9  | ConfigAndMonitoring                           | Config updates incl. raw category flags                       | M1, M3–M8       |
| M10 | Testing & Quality Gate                        | Unit + integration tests                                       | M3–M8           |
| M11 | GlossRP Tools Suite — Glossary Exporter       | Human/AI glossary outputs                                      | M7              |
| M12 | GlossRP Tools Suite — Category Curation Tool  | Emerging category detection & canonicalization                | M7              |
| M13 | Packaging & Local Deployment                  | Docker / run scripts / quick start                            | M3–M12          |
| M14 | Final Verification & Documentation            | Validate architecture, invariants, and produce final docs     | All above       |

### Current Status (latest session)

| ID  | Status    | Notes                                                                 |
|-----|-----------|-----------------------------------------------------------------------|
| M1  | Complete  | Project scaffold, toolchain, and base documentation live in repo.     |
| M2  | Complete  | Logical data model coded via SQLAlchemy models and Alembic migration. |
| M3  | Complete  | StorageAdapter now handles raw categories + helper ops for tools.     |
| M4  | Complete  | TermSpec parser, ingestion service, and watcher fulfill raw capture.  |
| M5  | Complete  | Retrieval engine ships canonical + raw modes w/ unit tests (`tests/unit/test_retrieval_engine.py`). |

---

## 2. Detailed Milestones & Task Lists

### M2 — Logical Data Model & DB Schema (Updated for v2.2)

**Tasks:**

- [x] Add `raw_categories` (JSONB or text[]) to `TermVersion`
- [x] Ensure no FK from raw_categories to TermCategory
- [x] Add `status` enum to TermCategory (`active`, `pending`, `deprecated`)
- [x] Implement TermCategoryAssignment unchanged (canonical only)
- [x] Add new indexes for raw category lookup
- [x] Confirm pgvector installed and embedding column created

**Human Checkpoints:**

- [x] Confirm schema aligns with Logical Data Model v2.2

---

### M3 — StorageAdapter (Updated for hybrid model)

**Tasks:**

- [x] Implement storage for raw categories on TermVersion
- [x] Ensure canonical category operations are available **but unused** by core ingestion
- [x] Add helper methods required by external tools:
  - [x] `get_raw_category_occurrences`
  - [x] `get_terms_with_raw_category`
  - [x] `assign_category`
  - [x] `create_category (status=pending)`
- [x] Vector storage unchanged

---

### M4 — IngestionService Core (Updated)

**Tasks:**

- [x] Extract raw categories from TermSpec and store in `raw_categories`
- [x] Do **not** create TermCategory or TermCategoryAssignment
- [x] Process Term, TermVersion, embeddings, metadata, SCS blocks
- [x] Add clear logging for raw category captures
- [x] Implement filesystem watcher bound to `TERMSPEC_DIRECTORY`
- [x] Trigger ingestion automatically when new / updated TermSpecs appear
- [x] Provide manual override command to replay a TermSpec through the watcher path

---

### M5 — RetrievalEngine — Canonical + Raw Modes

**Tasks:**

- [x] Maintain canonical retrieval unchanged
- [x] Add ability to retrieve raw categories (read-only)
- [x] Update glossary generation helpers for:
  - [x] Human flat glossary (canonical only)
  - [x] Human grouped glossary (canonical only)
  - [x] AI glossary (may include raw categories)

**Validation:**

- [x] `tests/unit/test_retrieval_engine.py` covers single-term, glossary, and raw-category paths

---

### M6 — RetrievalEngine — Vector Bundle Mode / Vector search and similarity retrieval  

**Objective:** Frame the vector retrieval interfaces without breaking deterministic guarantees.

**Tasks:**

- [ ] Document chosen similarity metric (human note; no code change).  
- [ ] Add `get_vector_bundle` scaffolding:
  - [ ] Accept `query_embedding` requests; raise explicit `NotImplementedError` for `query_text`.  
  - [ ] Depend on a placeholder `StorageAdapter.vector_search` (non-functional stub).  
  - [ ] Serialize responses using existing TermRecord helpers + similarity score field.  
- [ ] Populate `termspec-staging/` with ≥50 live TermSpecs for deterministic validation datasets.
- [ ] Flag StorageAdapter vector search + embedding client implementations as deferred (tracked for future milestone).

**LLM Notes:**

- Stubbed portions must be clearly annotated so downstream API work can opt in later.  
- Real data ingestion (termspec-staging) is the authoritative test dataset; unit tests should rely on serializer behavior only.


---

### M7 — ApiGateway — REST (Updated for v2.2)

**Tasks:**

- [ ] Add pass-through curation endpoints:
  - [ ] `GET /api/v1/glossrp/raw-categories/emerging`
  - [ ] `GET /api/v1/glossrp/raw-categories/{label}`
  - [ ] `POST /api/v1/glossrp/categories/promote`
  - [ ] `POST /api/v1/glossrp/categories/merge`
- [ ] All category logic delegated to external tools
- [ ] Update OpenAPI spec to distinguish canonical vs raw queries

---

### M11 — GlossRP Tools Suite — Glossary Exporter

*(Unchanged except for LDM v2.2 references)*

---

### M12 — GlossRP Tools Suite — Category Curation Tool

**Tasks:**

- [ ] Implement raw category discovery:
  - [ ] find all raw labels used across TermVersions
  - [ ] group and count occurrences
  - [ ] detect emerging categories
- [ ] Implement canonicalization workflow:
  - [ ] promote raw label → canonical TermCategory
  - [ ] create TermCategoryAssignment in batch
  - [ ] merge multiple raw labels
- [ ] CLI commands:
  ```
  glossrp-tools curate show-emerging
  glossrp-tools curate promote <raw> <canonical>
  glossrp-tools curate merge <raw1> <raw2> ...
  ```
- [ ] Optional AI suggestion modes (human approval required)

---

### M14 — Final Verification & Documentation (Updated)

**Tasks:**

- [ ] Confirm hybrid category pipeline behaves as intended
- [ ] Verify no ingestion can ever fail due to category unknowns
- [ ] Confirm curation tool works on real datasets
- [ ] Update architecture diagrams for v2.2:
  - ingestion path
  - retrieval path
  - curation path
  - tools suite path
- [ ] Publish final docs

---

## 3. Human-in-the-Loop Guidance (Updated)

- Ensure emerging category detection never auto-creates canonical categories
- Canonicalization must always require human approval
- Treat GlossRP as ECL‑BASE stable subsystem after completion of all milestones

---

**End of GlossRP Implementation Milestones v2.2**
