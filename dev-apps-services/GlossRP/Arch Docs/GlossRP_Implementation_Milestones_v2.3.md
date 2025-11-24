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

### M1 — Project Bootstrap & Tech Stack

**Objective:**  
Establish the base project structure and toolchain that will host GlossRP v2.2, including the hybrid category model and tools suite.

**Tasks:**

- [x] Select implementation language & primary framework (e.g., Python + FastAPI/gRPC, Node.js + Express/gRPC, Go, etc.).  
- [x] Initialize repository structure (e.g., `/core`, `/api`, `/ingestion`, `/storage`, `/tools`, `/docs`).  
- [x] Set up dependency management (e.g., `pyproject.toml`, `package.json`, `go.mod`).  
- [x] Configure linting/formatting (e.g., Black/ruff, ESLint, gofmt).  
- [x] Add a README that explicitly references the v2.2 specs:
  - GlossRP Logical Data Model v2.2  
  - Hybrid Category Model (raw + canonical)  
  - Internal Modules v2.2  
  - External Tools Suite (Glossary Exporter, Category Curation Tool)  

**LLM Notes:**

- Prefer clarity and simplicity over clever architectural patterns at this stage.  
- Make the chosen stack and directory layout explicit in the README so later EnaCs and coding LLMs can align without guesswork.

**Human Checkpoints:**

- [x] Approve chosen language/framework.  
- [x] Approve initial repo layout and confirm it aligns with how you want GlossRP + tools to be organized.

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
  
**LLM Notes:**

- Map **exactly** to the v2.2 Logical Data Model; don’t add speculative fields.  
- Keep `raw_categories` structurally simple and decoupled from TermCategory (no implicit semantics beyond “raw labels seen at ingestion”).  
- Comment migrations so future LLMs/humans can see which changes were introduced specifically for the hybrid model.

**Human Checkpoints:**

- [x] Confirm schema aligns with Logical Data Model v2.2
- [ ] Spot-check that `raw_categories` can store multiple freeform labels without DB-level coupling to TermCategory.  
- [ ] Verify pgvector extension and embedding column behavior in at least one test environment.

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

**LLM Notes:**

- Treat StorageAdapter as the **single choke point** for persistence; no other module should touch the DB directly.  
- Keep raw-category helpers read-oriented and conservative—no hidden semantics beyond “this string was seen with these terms.”  
- Do not embed tools-suite or ingestion logic here; StorageAdapter should remain neutral and reusable.

**Human Checkpoints:**

- [ ] Review StorageAdapter interface and confirm it exposes everything the tools suite and retrieval layers will need.  
- [ ] Confirm that canonical category operations remain intact and are clearly documented as “available but not used by core ingestion.”


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

**LLM Notes:**

- Parse TermSpecs strictly according to the current template; do not infer missing structure.  
- Treat raw categories as “observations,” not semantic truth—no promotion, no merging here.  
- Keep ingestion idempotent where practical (re-ingestion of the same TermSpec should be predictable and safe).

**Human Checkpoints:**

- [ ] Validate that a few TermSpecs are ingested with correct Terms, TermVersions, embeddings, metadata, SCS blocks, and `raw_categories`.  
- [ ] Confirm ingestion logs make it easy to see which raw labels have appeared and from which files.

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

**LLM Notes:**

- Keep a very clear separation between:
  - Canonical category views (for humans & systems that need stable semantics), and  
  - Raw category views (for tools, exploratory AIs, and curation workflows).  
- Avoid adding any implicit semantics to raw labels (no auto-merging or fuzzy clustering here).

**Human Checkpoints:**

- [ ] Spot-check single-term retrieval for a few known terms (canonical path).  
- [ ] Verify that raw category–aware calls expose raw labels without conflating them with canonical categories.  
- [ ] Confirm glossary outputs look usable for humans (flat + grouped) and consistent for AI consumers.

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

**LLM Notes:**

- Keep the REST layer thin—no business rules in the controller layer beyond validation and routing.  
- Use clear OpenAPI descriptions to mark endpoints as:
  - “canonical result” vs
  - “raw label–aware” vs
  - “tools/curation integration.”

**Human Checkpoints:**

- [ ] Review OpenAPI spec and confirm the canonical/raw distinction is obvious.  
- [ ] Manually hit a few endpoints (curl or client) to confirm behavior matches expectations for both canonical and raw category flows.
---

### M8 — ApiGateway — gRPC (v2.2)

**Objective:**  
Expose core retrieval operations via gRPC, including raw category–aware views suitable for tools and AI clients.

**Tasks:**

- [ ] Define `.proto` file covering:
  - [ ] `GetTerm`
  - [ ] `GetVectorBundle` (if/when wired)
  - [ ] `GetTermsByCanonicalCategory`
  - [ ] `GetTermsByRawCategory`
  - [ ] `GetHumanGlossary`
  - [ ] `GetHumanGlossaryGrouped`
  - [ ] `GetAIGlossaryListing`
- [ ] Generate server stubs and connect to RetrievalEngine.  
- [ ] Ensure canonical vs raw category behavior is clearly separated in RPC definitions.  
- [ ] Add basic gRPC integration tests (in-process client is fine).

**LLM Notes:**

- Design the `.proto` messages so they map cleanly to existing RetrievalEngine structures.  
- Name fields and services in a way that will make sense to future tools and AI clients (no overloading one RPC for multiple behaviors).  

**Human Checkpoints:**

- [ ] Review `.proto` file for clarity, naming, and canonical/raw separation.  
- [ ] Manually exercise a few gRPC calls with a simple CLI or test client.

---

### M9 — ConfigAndMonitoring

**Objective:**  
Add configuration and observability for the v2.2 system, including flags/metrics specific to raw categories and tools integration.

**Tasks:**

- [ ] Implement configuration loading (env vars / config files).  
- [ ] Wire config into:
  - [ ] DB connection
  - [ ] embedding client
  - [ ] TermSpec watcher directories
  - [ ] ports / hostnames
  - [ ] logging levels
  - [ ] feature flags for raw category–related behavior
- [ ] Implement logging hooks for:
  - [ ] ingestion events (success/failure, raw label counts)
  - [ ] retrieval events (canonical vs raw)
  - [ ] tools-related calls (e.g., curation endpoints)
- [ ] Add minimal metrics:
  - [ ] request counts and latency
  - [ ] error rates
  - [ ] rough counts of unique raw labels over time (if needed for ops)

**LLM Notes:**

- Avoid over-engineering; start with clear logs + a small set of metrics that actually help you “see” the hybrid model in action.  
- Keep configuration simple and documented so future environments can be reproduced.

**Human Checkpoints:**

- [ ] Confirm configuration keys and env vars match your deployment practices.  
- [ ] Verify that logs show enough detail to understand ingestion/retrieval + raw category usage.  
- [ ] Check that any metrics (if wired) align with what you actually care about tracking.
  
---

### M10 — Testing & Quality Gate

**Objective:**  
Ensure minimum quality and prevent regressions across the v2.2 hybrid model, including raw category flows and tools integration.

**Tasks:**

- [ ] Unit tests for:
  - [ ] StorageAdapter methods (canonical + raw helpers)
  - [ ] IngestionService parsing and `raw_categories` behavior
  - [ ] RetrievalEngine canonical + raw modes
- [ ] Integration tests for:
  - [ ] REST endpoints (canonical + raw + tools passthrough)
  - [ ] gRPC services (core retrieval + any raw-aware calls)
- [ ] A single “test runner” command (e.g., `make test`).  
- [ ] Document any known limitations or deferred pieces (e.g., vector search stubs).

**LLM Notes:**

- Focus tests on **behavior defined in the specs** (LDM v2.2, hybrid model, interface contracts), not internal implementation details.  
- Make a few tests explicitly cover canonical vs raw paths so future changes can’t silently blur the distinction.

**Human Checkpoints:**

- [ ] Review test coverage and confirm key behaviors are covered (including raw categories + tools endpoints).  
- [ ] Run the full test suite locally and confirm everything is green before promoting changes.

---

### M11 — GlossRP Tools Suite — Glossary Exporter

**Objective:**  
Provide a utility to generate `.md` and JSON glossary artifacts (human and AI-facing), aligned with the v2.2 Logical Data Model and hybrid category model.

**Tasks:**

- [ ] Implement CLI commands:
  - [ ] `glossrp-export human`
  - [ ] `glossrp-export human-by-category`
  - [ ] `glossrp-export ai-map`
- [ ] Use GlossRP REST/gRPC endpoints (not direct DB access) for all glossary data.  
- [ ] Render markdown for human glossaries:
  - [ ] `Glossary_Human_Flat.md` (canonical only)
  - [ ] `Glossary_Human_ByCategory.md` (canonical only)
- [ ] Save AI map as:
  - [ ] `Glossary_AI_Semantic_Map.json` (optionally `.md` if desired), including raw-category-aware views if appropriate.

**LLM Notes:**

- Keep the tool simple: HTTP client + minimal I/O + markdown/JSON formatting.  
- Assume humans and AI will both read these outputs—favor clarity and stable structure over clever formatting.

**Human Checkpoints:**

- [ ] Run exporter commands and inspect output `.md` and `.json`.  
- [ ] Print or view a sample glossary to confirm it’s actually usable in your workflows (and that canonical vs raw semantics are respected).


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

### M1 — Packaging & Local Deployment

**Objective:** Make GlossRP easy to run locally and in a container.

**Tasks:**

- [ ] Add Dockerfile (for app) and optional docker-compose (app + Postgres).  
- [ ] Document environment variables and sample `.env`.  
- [ ] Provide a “quick start” section in README:
  - [ ] “Run DB”  
  - [ ] “Run migrations”  
  - [ ] “Start GlossRP”  
  - [ ] “Ingest sample terms”  
  - [ ] “Call sample APIs”
- [ ] Ensure logs and errors are visible in local dev.

**LLM Notes:**

- Aim for a frictionless “clone → run” developer experience.

**Human Checkpoints:**

- [ ] Walk through the quick-start yourself.  
- [ ] Note any friction points.

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
