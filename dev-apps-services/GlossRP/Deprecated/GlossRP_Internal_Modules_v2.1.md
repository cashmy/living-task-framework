# GlossRP Internal Modules  
## Version 2.1 — Service Decomposition & Responsibilities

---

## 0. Purpose & Scope

This document defines the **internal module structure** of the GlossRP v2.1 microservice.

It is intended to:

- Clarify how GlossRP is decomposed into internal modules.  
- Define **responsibilities** and **non-responsibilities** for each module.  
- Anchor how external APIs (REST + gRPC) connect to internal logic.  
- Provide a clean foundation for implementation by humans and coding-LLMs.  

This specification assumes and respects:

- **GlossRP v2.1 Invariants**  
- **GlossRP Architecture Specification v2.1**  
- **GlossRP Logical Data Model v2.1**

---

## 1. High-Level Module Map

GlossRP is internally decomposed into the following modules:

1. `IngestionService`  
2. `StorageAdapter`  
3. `RetrievalEngine`  
4. `ApiGateway` (REST + gRPC)  
5. `ConfigAndMonitoring`  

In addition, there is a **companion tool**, not part of the core service:

- `GlossaryExporter` (external utility / script)

The companion tool operates **on top of** GlossRP’s APIs and is explicitly **outside** the ECL-BASE semantic boundary of GlossRP.

---

## 2. IngestionService

### 2.1 Purpose

`IngestionService` is responsible for turning TermSpec Markdown files into canonical DB records.

### 2.2 Responsibilities

- Monitor one or more configured directories for:
  - new TermSpec files,
  - updated TermSpec files.

- Parse TermSpecs according to the TermSpec template:
  - extract:
    - `term_id`,
    - `primary_name`,
    - `acronym`,
    - `domain`,
    - `status`,
    - `version`,
    - summaries (human + architecture),
    - category tags,
    - metadata fields,
    - SCS blocks (`SCS_T1`, `SCS_T2`, `SCS_T3`).

- Validate parsed content:
  - required fields present,
  - version format valid,
  - IDs are unique within project scope.

- Persist data via `StorageAdapter`:
  - upsert `Term` and `TermVersion`,
  - upsert `SCSBlocks`,
  - upsert `TermCategory` and `TermCategoryAssignment`,
  - upsert `TermMetadata`.

- Generate embeddings:
  - build the canonical text to embed (name + summaries, etc.),  
  - call an embedding client (external LLM/embedding API),  
  - store embeddings via `StorageAdapter` as `TermEmbedding`.

- Offer an optional **direct ingestion API**:
  - e.g., `IngestTermSpec` via REST/gRPC, allowing tools to push TermSpecs without file watching.

### 2.3 Non-Responsibilities

- No interpretation or rewriting of content (no summarization, no Tier logic).  
- No computation of drift or relationship graphs.  
- No direct DB access (always through `StorageAdapter`).  
- No UI or document generation.

---

## 3. StorageAdapter

### 3.1 Purpose

`StorageAdapter` isolates all persistence concerns. It is the **only** module that interacts with the physical database (PostgreSQL + pgvector in the reference implementation).

### 3.2 Responsibilities

- Provide a narrow, well-defined persistence API to other modules, including methods such as:

  - Term & TermVersion:
    - `get_term_by_id(term_id)`
    - `get_term_by_name_or_acronym(name, acronym)`
    - `save_term(term_data)`
    - `save_term_version(version_data)`
    - `get_latest_term_version(term_id)`
    - `get_term_versions_by_status(status)`

  - Embeddings:
    - `save_embedding(embedding_data)`
    - `get_embeddings_for_term_version(term_version_id)`
    - `vector_search(query_embedding, filters)`

  - Categories:
    - `get_or_create_category_by_name(name)`
    - `assign_category(term_version_id, category_id)`
    - `get_terms_by_category(category_ids, filters)`

  - Metadata:
    - `save_metadata_entries(term_version_id, metadata_entries)`
    - `get_metadata_for_term_version(term_version_id)`

  - SCS Blocks:
    - `save_scs_blocks(term_version_id, t1, t2, t3)`
    - `get_scs_blocks(term_version_id)`

- Enforce referential integrity according to the Logical Data Model:
  - foreign keys,
  - uniqueness constraints.

- Implement all SQL/DB-specific code, including:
  - pgvector configuration,
  - appropriate indexes,
  - connection pooling and transactions.

### 3.3 Non-Responsibilities

- No business or domain-specific logic beyond enforcing constraints.  
- No Tier logic or semantic interpretation.  
- No file system access.  
- No LTF/SCS interactions directly.

---

## 4. RetrievalEngine

### 4.1 Purpose

`RetrievalEngine` encapsulates all **semantic retrieval behavior** of GlossRP, using only the logical operations provided by `StorageAdapter`.

It implements the three canonical retrieval modes and the glossary-oriented views.

### 4.2 Responsibilities

#### 4.2.1 Single Term Retrieval

- `get_single_term(query)`  
  - Input fields:
    - `term_id` OR `acronym` OR `name`
    - optional `version`
    - flags: `include_embeddings`, `include_metadata`, `include_scs_blocks`
  - Behavior:
    - Resolve Term via `StorageAdapter`.
    - Retrieve latest/current TermVersion if `version` not provided.
    - Join Term, TermVersion, Embeddings, Categories, Metadata, and SCSBlocks as requested.
    - Return a structured, deterministic representation.

#### 4.2.2 Vector Bundle Retrieval

- `get_vector_bundle(query)`  
  - Input fields:
    - `query_text` or `query_embedding`
    - `top_k`
    - optional filters: `categories`, `status`
  - Behavior:
    - If `query_text` is provided:
      - call embedding client to get `query_embedding`.
    - Call `StorageAdapter.vector_search(query_embedding, filters)`.
    - Resolve TermVersion and Term details for returned embeddings.
    - Return ranked list with similarity scores.

#### 4.2.3 Category-Based Retrieval

- `get_terms_by_category(query)`  
  - Input fields:
    - category names/IDs
    - optional filters: `status`, `domain`
  - Behavior:
    - Resolve categories.
    - Query TermVersions via `StorageAdapter`.
    - Join Term entity data.
    - Return list of matching Terms/TermVersions.

#### 4.2.4 Human Glossary — Flat View

- `get_human_glossary_flat(options)`  
  - Typical behavior:
    - Fetch all `TermVersion` where `status = current` and `Term.status = active`.
    - For each:
      - select: `primary_name`, `acronym`, `summary_human`, (optionally `domain`).
    - Sort by name.
    - Return structured list (for JSON response).

#### 4.2.5 Human Glossary — Grouped by Category

- `get_human_glossary_grouped(options)`  
  - Typical behavior:
    - As above, but:
      - group TermVersions under their categories (Concept, Framework, Tool, etc.).
    - Return structure:
      - `[{ category: "Framework", terms: [...] }, ...]`.

#### 4.2.6 AI-Facing Glossary Listing

- `get_ai_glossary_listing(options)`  
  - Typical behavior:
    - For each active/current TermVersion:
      - include:
        - `primary_name`, `acronym`,
        - `summary_human`,
        - `summary_architecture`,
        - categories,
        - selected metadata (e.g., `origin`, `related_terms`, `suspected_drift` if present),
        - status/version if requested.
    - This is designed as a **compact semantic map** to reduce “vacuum-awareness” drift for LLMs.

### 4.3 Non-Responsibilities

- No modification of stored content (no summarization, rewriting, or expansion).  
- No relationship graph traversal or creation.  
- No Tier logic evaluation.  
- No direct DB access (always via `StorageAdapter`).  
- No formatting into markdown/PDF/HTML — returns only structured data.

---

## 5. ApiGateway

### 5.1 Purpose

`ApiGateway` exposes GlossRP’s capabilities over **REST** and **gRPC**, mapping external requests to internal module calls.

### 5.2 Responsibilities

- Initialize and configure:
  - HTTP server (for REST),
  - gRPC server.

- Map routes/RPCs to internal methods:

  - REST Examples:
    - `GET /api/v1/glossrp/terms/{term_id}` → `RetrievalEngine.get_single_term`
    - `POST /api/v1/glossrp/terms/vector-bundle` → `RetrievalEngine.get_vector_bundle`
    - `POST /api/v1/glossrp/terms/by-category` → `RetrievalEngine.get_terms_by_category`
    - `GET /api/v1/glossrp/glossary/human` → `RetrievalEngine.get_human_glossary_flat`
    - `GET /api/v1/glossrp/glossary/human/by-category` → `RetrievalEngine.get_human_glossary_grouped`
    - `GET /api/v1/glossrp/glossary/ai` → `RetrievalEngine.get_ai_glossary_listing`
    - `POST /api/v1/glossrp/ingest/termspec` → `IngestionService.ingest_raw_markdown`

  - gRPC Examples:
    - `GetTerm` → `RetrievalEngine.get_single_term`
    - `GetVectorBundle` → `RetrievalEngine.get_vector_bundle`
    - `GetTermsByCategory` → `RetrievalEngine.get_terms_by_category`
    - `GetHumanGlossary` → `RetrievalEngine.get_human_glossary_flat`
    - `GetHumanGlossaryGrouped` → `RetrievalEngine.get_human_glossary_grouped`
    - `GetAIGlossaryListing` → `RetrievalEngine.get_ai_glossary_listing`
    - `IngestTermSpec` → `IngestionService.ingest_raw_markdown`

- Validate inputs and map them to internal request structures.
- Serialize outputs into:
  - JSON (REST),
  - Protobuf messages (gRPC).
- Implement basic error handling and clear error responses.

### 5.3 Non-Responsibilities

- No semantic logic (no business rules beyond basic input validation).  
- No DB access.  
- No file watching.  
- No markdown/print export.

---

## 6. ConfigAndMonitoring

### 6.1 Purpose

`ConfigAndMonitoring` provides configuration and observability support across the service.

### 6.2 Responsibilities

- Load configuration from environment variables and/or config files:
  - `TERMSPEC_DIRECTORY`
  - `DATABASE_URL`
  - `EMBEDDING_MODEL`
  - `REST_PORT`
  - `GRPC_PORT`
  - `LOG_LEVEL`
  - other tunables (top_k defaults, etc.)

- Provide logging utilities:
  - ingestion events,
  - retrieval operations,
  - error logs.

- Provide basic metrics hooks:
  - request counts,
  - latency metrics,
  - error counts.

### 6.3 Non-Responsibilities

- No semantic logic.  
- No DB schema ownership.  
- No user-level or role-based access control (that belongs to higher orchestration layers).

---

## 7. Companion Tool — GlossaryExporter

> **Important:** `GlossaryExporter` is **not** part of the core GlossRP microservice.  
> It is a **companion utility** that operates on top of GlossRP’s APIs for presentation/export purposes.

### 7.1 Purpose

`GlossaryExporter` is a lightweight tool (script/CLI) designed to:

- Call GlossRP’s glossary endpoints:
  - `GET /glossary/human`
  - `GET /glossary/human/by-category`
  - `GET /glossary/ai`
- Render the returned JSON into:
  - Markdown (`.md`) files suitable for:
    - local viewing and searching,
    - printing,
    - quick reference.

### 7.2 Typical Outputs

- `Glossary_Human_Flat.md`  
  - Alphabetical list of terms with simple, human-readable summaries.

- `Glossary_Human_ByCategory.md`  
  - Categories (e.g., Concept, Framework, Tool) with terms listed under each.

- `Glossary_AI_Semantic_Map.json` (optional)
  - Serialized AI-facing glossary listing for quick context-loading into LLMs.

### 7.3 Responsibilities

- Provide a one-command experience like:
  - `glossrp-export human`
  - `glossrp-export human-by-category`
  - `glossrp-export ai-map`
- Convert JSON responses into simple, consistent markdown templates.
- Optionally, include hooks for:
  - running pandoc or similar tools to generate PDF for printing.

### 7.4 Non-Responsibilities

- No direct DB access.  
- No TermSpec parsing or ingestion.  
- No semantic interpretation or rewriting of definitions.  
- No Tier logic.  
- No ECL-CORE behaviors.

`GlossaryExporter` is a **presentation utility**, not a semantic component.

---

## 8. Call Graph & Interactions (Conceptual)

Textual view of major interactions:

- **Ingestion Path**
  - File system → `IngestionService` → `StorageAdapter` → DB

- **Retrieval Path (Single Term)**
  - REST/gRPC → `ApiGateway` → `RetrievalEngine` → `StorageAdapter` → DB → response

- **Retrieval Path (Glossary Views)**
  - REST/gRPC → `ApiGateway` → `RetrievalEngine` (glossary methods) → `StorageAdapter` → DB → response

- **Export Path (External)**
  - CLI → `GlossaryExporter` → REST API (`/glossary/...`) → `ApiGateway` → `RetrievalEngine` → `StorageAdapter` → DB  
  - `GlossaryExporter` → writes `.md` (and optionally derived formats)

---

## 9. Implementation Guidance for Coding-LLMs

When implementing from this module spec:

1. **Create modules as separate files/namespaces**:
   - `ingestion_service.*`
   - `storage_adapter.*`
   - `retrieval_engine.*`
   - `api_gateway_rest.*`
   - `api_gateway_grpc.*`
   - `config_and_monitoring.*`
   - optional: `tools/glossary_exporter.*`

2. **Ensure each module stays within its responsibilities**:
   - No DB code outside `StorageAdapter`.
   - No TermSpec parsing outside `IngestionService`.
   - No semantic logic in `ApiGateway`.
   - No markdown export in the core service.

3. **Wire the modules together in a composition root**:
   - Initialize `ConfigAndMonitoring`.
   - Initialize `StorageAdapter` with DB config.
   - Initialize `IngestionService` with `StorageAdapter` + embedding client.
   - Initialize `RetrievalEngine` with `StorageAdapter`.
   - Initialize `ApiGateway` with `RetrievalEngine` + `IngestionService`.

4. **Expose simple entry points**:
   - `start_server()` for GlossRP.
   - `glossrp-export ...` for the GlossaryExporter.

---

**End of GlossRP Internal Modules v2.1**  
