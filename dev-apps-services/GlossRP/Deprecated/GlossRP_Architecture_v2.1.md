# GlossRP Architecture Specification  
## Version 2.1 — ECL‑BASE Semantic Retrieval Microservice

---

## 0. Metadata

- **Name:** GlossRP (Glossary Retrieval Protocol / Service)
- **Version:** v2.1
- **Layer:** ECL‑BASE
- **Role:** Canonical semantic retrieval microservice for UCS
- **Primary Responsibilities:**  
  - TermSpec ingestion (from Markdown into DB)  
  - Canonical storage of terms, versions, embeddings, and categories  
  - Deterministic retrieval via REST + gRPC APIs  
- **Primary Consumers:** EchoForge, SCS, LTF, Phoenix Workbench, EnaC agents
- **Primary Storage Target:** PostgreSQL with `pgvector` extension
- **Deployment Target:** Hybrid — local‑first (desktop / dev) and server‑deployable

---

## 1. Identity & Purpose

### 1.1 Identity

GlossRP is the **canonical semantic retrieval service** for the Unified Cognition Stack (UCS). It is responsible for:

- owning the **TermSpec universe**,  
- storing all term definitions and embeddings, and  
- providing **deterministic, stateless, non‑interpretive** retrieval to all higher‑level systems.

GlossRP operates **entirely at ECL‑BASE**: it provides semantic matter but no semantic structure, interpretation, or evolution.

### 1.2 Purpose

GlossRP exists to:

1. **Centralize and normalize semantic terms** (TermSpecs) into a single source of truth.
2. **Expose fast, deterministic retrieval** for terms and their neighborhoods via:
   - Single‑term lookup,
   - Vector bundle retrieval,
   - Category‑based retrieval.
3. **Isolate storage and engine concerns** so higher‑level systems (SCS, LTF, PW, EchoForge) never touch the database directly.
4. **Act as an executable substrate** that coding‑LLMs can implement as a microservice with minimal ambiguity.

---

## 2. Architectural Invariants (Summary)

GlossRP v2.1 inherits the following non‑negotiable invariants:

1. **Canonical Source of Terms**  
   All term meanings, versions, embeddings, and category labels originate from GlossRP.

2. **ECL‑BASE Only**  
   No evolution, no Tier logic, no interpretation, no relationship graphs.

3. **Deterministic & Stateless Retrieval**  
   Identical inputs and DB state always yield identical outputs.

4. **No Relationship Creation or Expansion**  
   GlossRP stores what TermSpecs declare; it does not infer or expand relationships.

5. **Owns TermSpec Ingestion Pipeline**  
   Markdown TermSpecs are parsed and stored into the DB via GlossRP’s ingestion subsystem.

6. **Single Microservice Boundary**  
   Ingestion + storage + retrieval are internal modules; externally, GlossRP appears as one service.

7. **Exclusive DB Access**  
   No subsystem (LTF, SCS, PW, EchoForge) touches the DB directly; all go through GlossRP.

8. **Explicit Versioning**  
   All term versions are stored explicitly; GlossRP does not decide which version “should” be used.

9. **Non‑Interpretive Behavior**  
   GlossRP never adjusts meaning, computes drift, applies Tier logic, or synthesizes new semantics.

10. **Implementation‑Agnostic Interface**  
    External API is independent of DB engine; PostgreSQL + pgvector is the reference implementation.

11. **DRY and Thin**  
    Minimal logic; minimal branching; single, well‑scoped responsibility.

12. **No ECL‑CORE Behavior**  
    No transformations, contextualization, or evolution; those belong to SCS and LTF.

---

## 3. Position in UCS & ECL

### 3.1 UCS Data Flow Context

GlossRP participates in the canonical UCS flow:

- **EchoForge (T1 / Capture)**  
  → uses GlossRP to anchor captured ideas to existing concepts via vector bundle retrieval.

- **SCS (Semantic Compiler System)**  
  → uses GlossRP to fetch TermSpecs and SCS compiler blocks for Tier‑specific compilation.

- **LTF (Living Task Framework)**  
  → uses GlossRP to bind TaskNodes to canonical term identities and neighborhoods.

- **Phoenix Workbench (PW)**  
  → uses GlossRP to drive glossary panels, concept explorers, and semantic context helpers.

### 3.2 ECL & Tier Alignment

- **ECL‑BASE:**  
  GlossRP is entirely a BASE‑layer subsystem: it defines and delivers semantic matter.

- **ECL‑CORE:**  
  SCS and LTF operate here, consuming GlossRP outputs. GlossRP does not cross this boundary.

- **ECL‑SKY:**  
  PW and MxVA‑aligned orchestration use GlossRP indirectly via SCS/LTF and direct REST calls.

- **Tiers (T1/T2/T3):**  
  GlossRP is Tier‑neutral. It supplies data used by T1/T2/T3 systems but does not implement Tier behavior itself.

---

## 4. High‑Level Architecture Overview

GlossRP is implemented as a **microservice** with four primary internal modules:

1. **TermSpec Ingestion Service**
2. **Storage Adapter Layer**
3. **Retrieval Engine**
4. **Public API Layer (REST + gRPC)**

Conceptual diagram (textual):

- `TermSpec .md` files (in watched folders)  
  → **Ingestion Service**  
  → **Storage Adapter** (Postgres + pgvector)  
  → **Retrieval Engine**  
  → **API Layer** (REST + gRPC)  
  → Consumers: EchoForge, SCS, LTF, PW, EnaCs

### 4.1 Module Boundaries

- **Ingestion Service**
  - Watches directories for new/updated TermSpec `.md` files.
  - Parses the TermSpec template structure.
  - Validates required fields (ID, name, version, core definitions, SCS blocks).
  - Calls the Storage Adapter to persist or update term records and embeddings.

- **Storage Adapter**
  - Implements all DB interactions using PostgreSQL + pgvector.
  - Exposes engine‑agnostic CRUD and query operations to the Retrieval Engine and Ingestion Service.

- **Retrieval Engine**
  - Implements the three canonical retrieval modes:
    - `SingleTerm`,
    - `VectorBundle`,
    - `CategoryLookup`.
  - Applies no Tier logic or interpretation.
  - Delegates all persistence to the Storage Adapter.

- **Public API Layer**
  - Exposes the Retrieval Engine and Ingestion Service via:
    - REST (JSON over HTTP),
    - gRPC (Protobuf over HTTP/2).
  - Does light request validation and response formatting only.

---

## 5. Data Model — Logical Schema

GlossRP’s data model is expressed **logically** so it can be mapped to PostgreSQL, or another engine if needed.

### 5.1 Core Entities

#### 5.1.1 Term

Represents a conceptual identity across versions.

- `term_id` (string; stable identifier, e.g., `glossrp-v2`)
- `primary_name` (string)
- `acronym` (string, nullable)
- `domain` (string; e.g., `UCS Core`, `ECL`, `MxVA`)
- `status` (enum: `active`, `deprecated`, `experimental`)
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### 5.1.2 TermVersion

Represents a specific version of a term.

- `term_version_id` (UUID)
- `term_id` (FK → Term)
- `version` (string; e.g., `v2.0`, `v2.1`)
- `summary_human` (text; human‑facing definition)
- `summary_architecture` (text; architecture‑facing definition)
- `status` (enum: `current`, `superseded`, `archived`)
- `source_file_path` (string; pointer to original `.md` file)
- `raw_markdown` (text; optional cache of original content)
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### 5.1.3 TermEmbedding

Represents one or more vector embeddings for a given TermVersion.

- `embedding_id` (UUID)
- `term_version_id` (FK → TermVersion)
- `embedding` (vector; pgvector column)
- `model_name` (string; e.g., `text-embedding-3-large`)
- `purpose` (enum: `general`, `retrieval`, `definition`, etc.)
- `created_at` (timestamp)

#### 5.1.4 TermCategory

Represents categories used for category‑based retrieval.

- `category_id` (UUID)
- `name` (string; e.g., `ECL`, `MxVA`, `UCS-Core`, `Tool`, `Framework`)
- `description` (text, optional)

#### 5.1.5 TermCategoryAssignment

Many‑to‑many relationship between TermVersion and TermCategory.

- `term_version_id` (FK → TermVersion)
- `category_id` (FK → TermCategory)

#### 5.1.6 TermMetadata

Flexible metadata bag for additional attributes.

- `term_version_id` (FK → TermVersion)
- `key` (string)
- `value` (JSONB)

This can include, for example:

- related term IDs (as declared in the TermSpec),
- domain flags,
- visibility hints.

> **Important:**  
> Even if `related_terms` are stored in metadata, GlossRP only **returns** them; it does not interpret or operate on them as a relationship graph. Interpretation is left to SCS/LTF.

#### 5.1.7 SCSBlocks

Stores SCS compiler blocks extracted from TermSpecs.

- `term_version_id` (FK → TermVersion)
- `t1_block` (text)
- `t2_block` (text)
- `t3_block` (text)

These are consumed directly by SCS, not by GlossRP itself.

---

## 6. TermSpec Ingestion Pipeline

### 6.1 Purpose

The ingestion pipeline turns human‑authored TermSpec `.md` files into canonical DB records.

### 6.2 Flow

1. **File Watcher**
   - Watches a configured directory (e.g., `terms/`).
   - Detects new or updated `.md` files matching the TermSpec template.

2. **Parser**
   - Parses Markdown into a structured representation:
     - term ID, primary name, acronym,
     - version,
     - human/architecture definitions,
     - domain, status,
     - categories,
     - SCS blocks (`SCS_T1`, `SCS_T2`, `SCS_T3`),
     - declared related terms.

3. **Validation**
   - Ensures required fields are present.
   - Validates version string format.
   - Checks that IDs are globally unique and stable.

4. **Storage Adapter Calls**
   - Upserts Term, TermVersion records.
   - Writes SCSBlocks and TermMetadata.
   - Generates embeddings for the given TermVersion (using configured embedding model) and stores them in TermEmbedding.
   - Updates TermCategory and TermCategoryAssignment.

5. **Post‑Ingestion Hooks**
   - Optional: emit events for PW/LTF to notify them that new terms are available.
   - No semantic interpretation is performed at this stage.

### 6.3 Error Handling

- Invalid TermSpecs are:
  - Logged,
  - Optionally surfaced via PW,
  - Not written to the DB until fixed.

GlossRP never stores partial or invalid terms.

---

## 7. Retrieval Engine

The Retrieval Engine implements three canonical modes:

### 7.1 Single Term Lookup

**Goal:** Return a canonical representation of a single term.

**Inputs:**

- `term_id` OR
- `acronym` OR
- `primary_name`

**Options:**

- `version` (optional; if omitted, default = latest `current` version)
- `include_embeddings` (bool)
- `include_metadata` (bool)
- `include_scs_blocks` (bool)

**Outputs:**

- consolidated structure containing:
  - Term,
  - TermVersion,
  - TermEmbedding(s) as requested,
  - TermCategoryAssignment,
  - TermMetadata,
  - SCSBlocks (if requested).

### 7.2 Vector Bundle Mode

**Goal:** Return terms semantically similar to a query string or embedding.

**Inputs:**

- `query_text` OR `query_embedding`
- `top_k` (int; default configurable)
- Optional filters:
  - `categories` (list of category names/IDs),
  - `status` (e.g., `active`, `current`).

**Process:**

- Compute embedding from `query_text` if given.
- Execute vector similarity query via pgvector:
  - e.g., cosine distance or inner product.
- Apply filters on TermVersion/TermCategory.

**Outputs:**

- list of:
  - `term_version_id`,
  - similarity score,
  - basic fields (`term_id`, `primary_name`, `version`),
  - optional embedded Term data if requested.

### 7.3 Category Lookup

**Goal:** Retrieve all TermVersions within one or more categories.

**Inputs:**

- `category_ids` or `category_names`
- Optional filters:
  - `status`,
  - `domain`.

**Outputs:**

- list of matching TermVersions and their associated Term/metadata.

### 7.4 Non‑Responsibilities

The Retrieval Engine:

- does not interpret relationships,
- does not create new relationships,
- does not compute Tier behavior,
- does not traverse graphs (that is LTF’s role).

---

## 8. Public API Layer

GlossRP offers both **REST** and **gRPC** interfaces, mapped to the same internal methods.

### 8.1 REST API (JSON over HTTP)

Base URL: `/api/v1/glossrp`

#### 8.1.1 `GET /terms/{term_id}`

- Path:
  - `term_id` (string)
- Query params:
  - `version` (optional)
  - `include_embeddings` (bool)
  - `include_metadata` (bool)
  - `include_scs_blocks` (bool)

#### 8.1.2 `GET /terms`

Lookup by name/acronym:

- Query params:
  - `name` or `acronym`
  - same options as above.

#### 8.1.3 `POST /terms/vector-bundle`

- Body:
  ```json
  {
    "query_text": "string (optional)",
    "query_embedding": [float, ...] (optional),
    "top_k": 10,
    "filters": {
      "categories": ["UCS-Core", "ECL"],
      "status": "active"
    }
  }
  ```

#### 8.1.4 `POST /terms/by-category`

- Body:
  ```json
  {
    "categories": ["ECL", "MxVA"],
    "status": "active"
  }
  ```

#### 8.1.5 `POST /ingest/termspec`

For direct ingestion (alternate to file watcher):

- Body:
  ```json
  {
    "raw_markdown": "TermSpec markdown content",
    "source_path": "optional/path/for/reference"
  }
  ```

---

### 8.2 gRPC API (Protobuf over HTTP/2)

Service definition (conceptual):

```proto
service GlossRPService {
  rpc GetTerm(GetTermRequest) returns (GetTermResponse);
  rpc GetVectorBundle(GetVectorBundleRequest) returns (GetVectorBundleResponse);
  rpc GetTermsByCategory(GetTermsByCategoryRequest) returns (GetTermsByCategoryResponse);
  rpc IngestTermSpec(IngestTermSpecRequest) returns (IngestTermSpecResponse);
}
```

`GetTermRequest` includes:

- `term_id` | `acronym` | `name`
- `version`
- flags for including embeddings, metadata, SCS blocks.

`GetVectorBundleRequest` includes:

- `query_text` or `query_embedding`
- `top_k`
- category/status filters.

`GetTermsByCategoryRequest` includes:

- category list
- filters.

`IngestTermSpecRequest` includes:

- raw markdown,
- source path,
- optional flags for validation strictness.

---

## 9. Deployment Model

### 9.1 Local‑First (Desktop / Dev)

- GlossRP runs as a local microservice:
  - e.g., background process started by Phoenix Workbench or a CLI.
- PostgreSQL (with pgvector) runs locally:
  - via Docker,
  - or embedded local instance.
- TermSpec directory is bound to a local project folder.

Typical workflow:

- User edits/creates TermSpec `.md` files.
- Watcher ingests them into local Postgres.
- PW, EchoForge, SCS, LTF all talk to `localhost` GlossRP API.

### 9.2 Server‑Deployable

- The same Docker image (or equivalent) can be deployed:
  - on a server,
  - in a container orchestrator (e.g., Kubernetes),
  - with managed Postgres.
- Multi‑user tools (team PW, shared LTF) use the server instance.

### 9.3 Configuration

Key configuration options:

- `TERMSPEC_DIRECTORY` (for watcher)
- `DATABASE_URL` (Postgres)
- `EMBEDDING_MODEL` (for TermEmbedding generation)
- `REST_PORT`
- `GRPC_PORT`
- `LOG_LEVEL`
- `MAX_TOP_K` for vector queries

---

## 10. Security & Access Control (Outline)

For v2.1, security is scoped as follows:

- Local‑first deployments may run without strict auth (single‑user).
- Server deployments should integrate:
  - API keys and/or OAuth for REST,
  - mTLS or token‑based auth for gRPC.
- GlossRP **does not** implement user roles or complex authorization.
  - That belongs to the orchestration layer (e.g., PW / gateway).

---

## 11. Non‑Responsibilities & Guardrails

GlossRP explicitly does **not**:

- execute Tier logic (T1/T2/T3),
- create or manage relationships between terms,
- compute or store Temporal Evolution Objects (TEOs),
- track drift or lineage (LTF’s job),
- generate artifacts (PW’s job),
- interpret or rephrase term definitions (SCS’s job),
- manage UI or user interactions.

GlossRP **only**:

- ingests TermSpecs,
- stores them canonically,
- serves deterministic retrieval.

---

## 12. Evolution Path

GlossRP v2.1 is intended to be **structurally stable**:

- Future changes should be **evolutionary**, not corrective.
- New fields can be added to TermMetadata or TermVersion as needed.
- Additional retrieval filters may be added (e.g., by domain), but:
  - no ECL‑CORE behaviors may be moved into GlossRP.
- Performance enhancements (indexes, caching) should remain **transparent** to the public API.

Any expansions beyond Single/Vector/Category retrieval must be carefully reviewed against ECL and role‑boundary constraints to avoid drift.

---

## 13. Implementation Notes for Coding‑LLMs

When implementing GlossRP from this spec:

1. **Start with the Data Model**
   - Define Term, TermVersion, TermEmbedding, TermCategory, TermCategoryAssignment, TermMetadata, SCSBlocks tables in PostgreSQL.
   - Enable `pgvector` and configure the embedding column.

2. **Implement the Storage Adapter**
   - Provide a narrow set of methods used by Ingestion and Retrieval Engine.
   - Keep SQL isolated here.

3. **Implement the Ingestion Service**
   - Implement a TermSpec parser for the known template.
   - Write a CLI or daemon to ingest files and/or accept REST/gRPC ingestion calls.

4. **Implement the Retrieval Engine**
   - Implement SingleTerm, VectorBundle, and CategoryLookup as pure functions over the Storage Adapter.

5. **Implement REST and gRPC Adapters**
   - Map HTTP routes and gRPC RPCs to Retrieval Engine and Ingestion Service methods.
   - Validate inputs and serialize outputs.

6. **Write Tests**
   - Unit tests for:
     - TermSpec parsing,
     - Storage adapter queries,
     - retrieval behaviors.
   - Integration tests for REST/gRPC endpoints.

7. **Document the API**
   - Generate OpenAPI for REST.
   - Provide `.proto` definitions for gRPC.

This spec, combined with the GlossRP Invariants document and TermSpec template, should be sufficient for a competent coding‑LLM (under MxVA governance) to produce a working, testable GlossRP microservice within hours.

---

**End of GlossRP Architecture Specification v2.1**  
