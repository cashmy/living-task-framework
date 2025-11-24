# GlossRP Internal Modules  
## Version 2.2 — Updated for Hybrid Category Model & Tools Suite Integration  
---

## 0. Purpose & Scope

This version updates the internal module map to reflect the **Hybrid Category Model**, the addition of **raw_categories**, and alignment with the new **GlossRP Tools Suite v2.0**.  
It supersedes v2.1 and integrates the following changes:

- Updated responsibilities for StorageAdapter and IngestionService to handle `raw_categories`
- Removal of category creation from ingestion (moved to Curation Tool)
- Recognition of two external tools:
  - Glossary Exporter
  - Category Curation Tool
- Clarified ECL-BASE boundaries according to Logical Data Model v2.2

---

# 1. High-Level Module Map

GlossRP consists of the following internal modules:

1. `IngestionService`  
2. `StorageAdapter`  
3. `RetrievalEngine`  
4. `ApiGateway` (REST + gRPC)  
5. `ConfigAndMonitoring`  

**External (not part of core GlossRP):**

- `GlossaryExporter`  
- `CategoryCurationTool`  

Both external tools operate strictly via GlossRP APIs.

---

# 2. IngestionService (Updated)

## 2.1 Purpose
Convert TermSpec files into canonical DB records.

## 2.2 Updated Responsibilities

- Parse TermSpecs, extracting:
  - `term_id`, `primary_name`, `acronym`, `version`, `summaries`,
  - **raw categories** (stored exactly as given),
  - SCS Blocks,
  - Metadata.

- Persist via StorageAdapter:
  - Create/update Term + TermVersion
  - Store `raw_categories` on TermVersion
  - Store metadata and SCS blocks
  - **Do NOT create canonical categories**  
    (category creation is now handled only by the Category Curation Tool)

- Generate embeddings and store them using StorageAdapter.

## 2.3 Non-Responsibilities (Updated)

- No creation or modification of canonical TermCategory.  
- No TermCategoryAssignment creation.  
- No category clustering or category inference.

---

# 3. StorageAdapter (Updated)

## 3.1 Purpose
Owns all persistence operations, including pgvector.

## 3.2 Updated Responsibilities

- Handle raw category storage via `TermVersion.raw_categories`
- CRUD operations for:
  - Term / TermVersion
  - Metadata
  - SCS Blocks
  - Embeddings

- Category operations (curatorial only):
  - `get_or_create_category_by_name(name)` — only called by Category Curation Tool
  - `assign_category(term_version_id, category_id)`

## 3.3 Non-Responsibilities

- No decision-making on semantic meaning of categories.

---

# 4. RetrievalEngine (Updated)

Now supports retrieval that can distinguish:

- canonical categories (via TermCategoryAssignment)
- raw categories (via TermVersion.raw_categories)

### 4.2.4 Updated: Human Glossary Grouped
- Groups only by canonical categories.
- Raw categories never appear in exported human glossaries.

### 4.2.6 Updated: AI-Facing Glossary Listing
- May optionally include raw categories for semantic scaffolding.

---

# 5. ApiGateway (Updated)

Adds the following category-relevant endpoints:

- `GET /api/v1/glossrp/raw-categories/emerging`
- `GET /api/v1/glossrp/raw-categories/{label}`
- `POST /api/v1/glossrp/categories/promote`
- `POST /api/v1/glossrp/categories/merge`

These endpoints are thin wrappers that call the external Category Curation Tool (not internal GlossRP code).

---

# 6. ConfigAndMonitoring  
(Unchanged except for two new config flags)

### New config flags:
- `ENABLE_CATEGORY_CURATION_ENDPOINTS=true`
- `ALLOW_RAW_CATEGORY_INSPECTION=true`

---

# 7. External Tools (Updated Overview)

## 7.1 GlossaryExporter
- Calls glossary APIs
- Produces markdown/JSON
- No category manipulation

## 7.2 CategoryCurationTool
- The **only** entity that:
  - creates canonical TermCategories
  - performs TermCategoryAssignment backfilling
  - merges raw labels
  - detects “emerging categories”

GlossRP core never performs these tasks.

---

# 8. Updated Call Graph

### Ingestion Path
File → IngestionService → StorageAdapter → DB

### Retrieval Path
API → ApiGateway → RetrievalEngine → StorageAdapter → DB

### Curation Path (New)
CategoryCurationTool → ApiGateway → StorageAdapter → DB

### Export Path
GlossaryExporter → ApiGateway → RetrievalEngine → StorageAdapter → DB

---

# 9. Implementation Guidance

- IngestionService should directly populate `raw_categories`
- TermCategory manipulation **must** be done exclusively by the Category Curation Tool
- RetrievalEngine must distinguish between raw vs canonical categories
- ApiGateway must expose new curation endpoints without embedding semantic logic
- PW will orchestrate sequences involving both internal modules and external tools

---

**End of GlossRP Internal Modules v2.2**
