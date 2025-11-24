# GlossRP Logical Data Model  
## Version 2.1 — Engine-Agnostic Schema for ECL-BASE Semantics

---

## 0. Purpose & Scope

This document defines the **logical data model** for GlossRP v2.1, independent of any specific physical database engine. It is intended to:

- Provide a **clear schema contract** for implementing GlossRP’s storage layer.  
- Guide the mapping to PostgreSQL + `pgvector` (reference implementation).  
- Support deterministic, stateless retrieval via **SingleTerm**, **VectorBundle**, and **CategoryLookup** modes.  
- Preserve the **GlossRP v2.1 Invariants** and architectural boundaries.

This model **does not** introduce ECL-CORE behaviors (no relationship graphs, no Tier logic, no evolution semantics). It strictly describes **how TermSpecs are represented and retrieved** at ECL-BASE.

---

## 1. Conceptual Overview

### 1.1 Core Concepts

GlossRP’s logical model is built around the following conceptual objects:

- **Term** — a stable conceptual identity (e.g., “GlossRP”, “LTF”, “MxVA”).  
- **TermVersion** — a specific version of that concept (e.g., `GlossRP v2.0`, `GlossRP v2.1`).  
- **TermEmbedding** — one or more vector representations of a specific TermVersion.  
- **TermCategory** — a conceptual grouping label (e.g., `UCS-Core`, `ECL`, `Framework`).  
- **TermCategoryAssignment** — links TermVersions to one or more TermCategories.  
- **TermMetadata** — a flexible key/value metadata bag for additional attributes.  
- **SCSBlocks** — Tier-specific semantic compiler slices extracted from the TermSpec (T1/T2/T3).

### 1.2 Design Principles

1. **Separation of Identity & Version**  
   - `Term` represents stable identity.  
   - `TermVersion` captures versioned content.

2. **Vector Representations per Version**  
   - Vector embeddings are attached to `TermVersion`, not `Term`.  
   - Multiple embeddings per version are allowed for different purposes or models.

3. **Category-Based Grouping**  
   - Terms are grouped via `TermCategory` and `TermCategoryAssignment`.  
   - Category lookup must be efficient and fully supported by the schema.

4. **Flexible Metadata**  
   - `TermMetadata` stores structured or semi-structured attributes without schema explosion.  
   - Supports incremental evolution of the TermSpec template.

5. **SCS Block Isolation**  
   - SCS compiler blocks are stored separately in `SCSBlocks`.  
   - GlossRP stores them; **SCS consumes them**.

---

## 2. Entity Definitions

> Note: Types are logical, not tied to a specific DB. Suggested Postgres types are provided in parentheses.

---

### 2.1 Term

Represents a **stable conceptual identity** independent of version.

**Attributes:**

- `term_id`  
  - Type: `string` (e.g., `varchar(128)`)  
  - Semantics: globally unique, stable identifier (e.g., `glossrp`, `ltf`, `mxva`).  
  - Constraints:  
    - Primary Key (PK)  
    - Unique

- `primary_name`  
  - Type: `string` (e.g., `varchar(256)`)  
  - Semantics: human-readable primary name.  

- `acronym`  
  - Type: `string | null` (e.g., `varchar(64)`)  
  - Semantics: short form (e.g., `LTF`, `PW`).  

- `domain`  
  - Type: `string` (e.g., `varchar(128)`)  
  - Examples: `UCS-Core`, `ECL`, `MxVA`, `Tool`, `Framework`.  

- `status`  
  - Type: enum (`active`, `deprecated`, `experimental`)  
  - Semantics: lifecycle state of the term.

- `created_at`  
  - Type: `timestamp`  

- `updated_at`  
  - Type: `timestamp`  

**Keys & Constraints:**

- PK: `(term_id)`  
- Unique: `(primary_name, domain)` may be enforced if desired to avoid duplicate identities.  

---

### 2.2 TermVersion

Represents a **specific version** of a Term.

**Attributes:**

- `term_version_id`  
  - Type: `UUID`  
  - PK, unique.

- `term_id`  
  - Type: `string`  
  - FK → `Term(term_id)`

- `version`  
  - Type: `string` (e.g., `varchar(32)`; examples: `v1.0`, `v2.1.3`)  
  - Semantics: human-readable version descriptor.

- `summary_human`  
  - Type: `text`  
  - Semantics: accessible human-facing definition.

- `summary_architecture`  
  - Type: `text`  
  - Semantics: architecture/system-level definition.

- `status`  
  - Type: enum (`current`, `superseded`, `archived`)  
  - Semantics: version lifecycle state.

- `source_file_path`  
  - Type: `string` (e.g., `varchar(512)`)  
  - Semantics: path or identifier of the TermSpec `.md` source file.

- `raw_markdown`  
  - Type: `text | null`  
  - Semantics: optional cached copy of the TermSpec content.

- `created_at`  
  - Type: `timestamp`

- `updated_at`  
  - Type: `timestamp`

**Keys & Constraints:**

- PK: `(term_version_id)`  
- Unique: `(term_id, version)`  
- FK: `term_id` → `Term(term_id)`

This ensures:

- A Term can have many TermVersions.  
- Each version is uniquely identifiable.

---

### 2.3 TermEmbedding

Represents **vector embeddings** associated with a TermVersion.

**Attributes:**

- `embedding_id`  
  - Type: `UUID`  
  - PK, unique.

- `term_version_id`  
  - Type: `UUID`  
  - FK → `TermVersion(term_version_id)`

- `embedding`  
  - Type: `vector` (pgvector in Postgres; logically: array of `float`)  

- `model_name`  
  - Type: `string` (e.g., `varchar(128)`)  
  - Example: `text-embedding-3-large`.

- `purpose`  
  - Type: enum (`general`, `retrieval`, `definition`, `relationship-hint`, etc.)  
  - Semantics: how this embedding is intended to be used.

- `created_at`  
  - Type: `timestamp`

**Keys & Constraints:**

- PK: `(embedding_id)`  
- FK: `term_version_id` → `TermVersion(term_version_id)`  
- Recommended index:  
  - `vector index` on `embedding` for similarity search (physical-level detail).

Multiple embeddings per TermVersion are allowed (e.g., different models or purposes).

---

### 2.4 TermCategory

Represents **semantic groupings** for TermVersions.

**Attributes:**

- `category_id`  
  - Type: `UUID`  
  - PK, unique.

- `name`  
  - Type: `string` (e.g., `varchar(128)`)  
  - Example: `ECL`, `UCS-Core`, `MxVA`, `Tool`, `Framework`.

- `description`  
  - Type: `text | null`

**Keys & Constraints:**

- PK: `(category_id)`  
- Unique: `(name)`

---

### 2.5 TermCategoryAssignment

Associates TermVersions with TermCategories (**many-to-many**).

**Attributes:**

- `term_version_id`  
  - Type: `UUID`  
  - FK → `TermVersion(term_version_id)`

- `category_id`  
  - Type: `UUID`  
  - FK → `TermCategory(category_id)`

**Keys & Constraints:**

- PK: `(term_version_id, category_id)`  
- FKs as above.

This structure supports:

- Category-based retrieval (`get_terms_by_category`).  
- Efficient filtering for semantic neighborhoods.

---

### 2.6 TermMetadata

Flexible **key/value metadata** attached to TermVersions.

**Attributes:**

- `term_version_id`  
  - Type: `UUID`  
  - FK → `TermVersion(term_version_id)`

- `key`  
  - Type: `string` (e.g., `varchar(128)`)  
  - Examples: `related_terms`, `visibility`, `priority`, `origin`, `aliases`.

- `value`  
  - Type: `JSON` or `JSONB`  
  - Semantics: arbitrary structured content.

**Keys & Constraints:**

- PK: `(term_version_id, key)`  
- FK: `term_version_id` → `TermVersion(term_version_id)`

**Usage Notes:**

- `related_terms` could be stored as a JSON array of `term_id`s.  
- GlossRP **returns** this metadata but does not act on it as a graph.  
- LTF and SCS can interpret it if they choose; GlossRP remains non-interpretive.

---

### 2.7 SCSBlocks

Stores **Tier-specific compiled explanation slices** for use by SCS.

**Attributes:**

- `term_version_id`  
  - Type: `UUID`  
  - PK, FK → `TermVersion(term_version_id)`

- `t1_block`  
  - Type: `text`  
  - Semantics: Tier-1 (T1) explanation.

- `t2_block`  
  - Type: `text`  
  - Semantics: Tier-2 (T2) explanation.

- `t3_block`  
  - Type: `text`  
  - Semantics: Tier-3 (T3) explanation.

**Keys & Constraints:**

- PK: `(term_version_id)`  
- FK: `term_version_id` → `TermVersion(term_version_id)`

GlossRP only **stores** these blocks; it never interprets or renders them.  
SCS consumes them to provide Tier-aligned slices.

---

## 3. Relationships & Cardinalities

### 3.1 Term ↔ TermVersion

- **Term** `1` → `N` **TermVersion**  
- Each Term can have multiple versions; each version belongs to exactly one Term.

### 3.2 TermVersion ↔ TermEmbedding

- **TermVersion** `1` → `N` **TermEmbedding**  
- Each version can have multiple embeddings for different models or purposes.

### 3.3 TermVersion ↔ TermCategory (via TermCategoryAssignment)

- **TermVersion** `N` ↔ `N` **TermCategory**  
- Many-to-many relationship via `TermCategoryAssignment`.

### 3.4 TermVersion ↔ TermMetadata

- **TermVersion** `1` → `N` **TermMetadata** (by key)  
- Each version can have multiple metadata entries.

### 3.5 TermVersion ↔ SCSBlocks

- **TermVersion** `1` → `0 or 1` **SCSBlocks**  
- A TermVersion may or may not have SCS blocks defined.

---

## 4. Logical Indexing Strategy

> This section describes **logical** indexes that are recommended for efficient queries.

### 4.1 Term

- Index on `(primary_name)`  
- Index on `(acronym)`  
- Optional composite index on `(primary_name, domain)`

Used for name/acronym lookup.

### 4.2 TermVersion

- Index on `(term_id, status)`  
- Index on `(term_id, version)`  
- Index on `(status)`

Used for:
- retrieving the **latest current version** for a term,  
- filtering by lifecycle state.

### 4.3 TermEmbedding

- Vector index on `embedding` (engine-specific; e.g., `ivfflat` in pgvector).  
- Index on `(term_version_id)`.

Used for:
- vector similarity search in **VectorBundle** mode.

### 4.4 TermCategoryAssignment

- Index on `(category_id)`  
- Index on `(term_version_id)`

Used for:
- category-based retrieval and filtering.

### 4.5 TermMetadata

- Index on `(term_version_id)`  
- Optional index on `(key)`

Used for:
- keyed metadata lookup (e.g., `related_terms`, `origin`).

---

## 5. Mapping from TermSpec Template to Logical Model

The TermSpec Markdown template is parsed into the logical schema as follows:

### 5.1 Identity Fields

- `Term ID` → `Term.term_id`  
- `Primary Name` → `Term.primary_name`  
- `Acronym` → `Term.acronym`  
- `Domain` → `Term.domain`  
- `Term Status` → `Term.status`

### 5.2 Version & Definitions

- `Version` → `TermVersion.version`  
- `Human Summary` / accessible text → `TermVersion.summary_human`  
- `Architecture Summary` / system-level definition → `TermVersion.summary_architecture`  
- `Source Path` (file path) → `TermVersion.source_file_path`  
- TermSpec raw markdown (optional) → `TermVersion.raw_markdown`

### 5.3 Categories

- Category list in TermSpec → for each category:
  - Upsert into `TermCategory` by name,
  - Create `TermCategoryAssignment` for the TermVersion.

### 5.4 Metadata

Template fields that don’t fit the fixed schema or are explicitly marked as metadata are stored in:

- `TermMetadata` (`key`, `value` JSON) per TermVersion.

Example metadata keys:

- `related_terms` → list of `term_id`s  
- `aliases` → list of alternate names  
- `visibility` → e.g., `internal`, `public`  
- `origin` → e.g., `ECL-Manifesto`, `MxVA-Manifesto`

### 5.5 SCS Blocks

SCS sections in the TermSpec:

- `SCS_T1` block → `SCSBlocks.t1_block`  
- `SCS_T2` block → `SCSBlocks.t2_block`  
- `SCS_T3` block → `SCSBlocks.t3_block`

If no SCS section is present, no SCSBlocks row is created.

### 5.6 Embeddings

Embedding generation is not part of the template itself but is performed during ingestion:

- The ingestion service:
  - builds the canonical text to embed (e.g., concatenation of name + summaries),  
  - calls an embedding model,  
  - writes to `TermEmbedding` with `purpose = 'retrieval'` (or similar).

---

## 6. Example Logical Queries

> The following are **logical** query shapes for typical GlossRP operations.

### 6.1 Single-Term Lookup (Latest Version by ID)

1. Find `Term` by `term_id`.  
2. Find `TermVersion` rows with `term_id` and `status = 'current'`.  
3. Join in:
   - `TermEmbedding` (optional),
   - `TermCategoryAssignment` + `TermCategory`,
   - `TermMetadata`,
   - `SCSBlocks` (if requested).

### 6.2 Vector Bundle Retrieval

1. Compute embedding for the query text.  
2. Run vector similarity search against `TermEmbedding.embedding`.  
3. Map back to `TermVersion` and `Term`.  
4. Apply filters based on:
   - TermVersion `status` (e.g., `current`),  
   - TermCategory.

### 6.3 Category-Based Retrieval

1. Resolve `TermCategory` IDs from category names.  
2. Find `TermCategoryAssignment` by `category_id`.  
3. Join to `TermVersion` (optional filter on status).  
4. Join to `Term`.

---

## 7. Non-Goals of the Logical Data Model

The Logical Data Model for GlossRP v2.1 explicitly does **not**:

- Represent relationship graphs or semantic networks (LTF’s domain).  
- Store Temporal Evolution Objects (TEOs) or drift logs.  
- Track user access patterns or usage analytics.  
- Model Tier- or framework-specific structures beyond the SCS blocks.  
- Replace or duplicate LTF’s graph or PW’s artifact indexing.

It is solely responsible for representing:

> **TermSpecs, their versions, embeddings, categories, and related metadata — in a way that supports deterministic retrieval.**

---

## 8. Implementation Guidance

When implementing the physical schema (e.g., in PostgreSQL):

1. Map entities to tables using the attributes and constraints defined here.  
2. Enable `pgvector` and choose appropriate index types for `TermEmbedding.embedding`.  
3. Preserve all FKs and uniqueness constraints; they are part of GlossRP’s correctness guarantees.  
4. Treat `TermMetadata.value` as JSON/JSONB to allow incremental evolution.  
5. Avoid adding fields that encode ECL-CORE behaviors (relationships, evolution, etc.); those belong in LTF.

This Logical Data Model, together with the **GlossRP v2.1 Invariants** and **GlossRP Architecture Specification**, provides a sufficient foundation for implementing the GlossRP storage layer in a clean, DRY, and evolution-safe way.

---

**End of GlossRP Logical Data Model v2.1**  
