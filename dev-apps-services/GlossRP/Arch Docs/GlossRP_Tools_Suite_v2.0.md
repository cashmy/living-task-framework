
# GlossRP Tools Suite v2.0  
## Unified Toolkit: Glossary Exporter + Category Curation Tool  
### Version 2.0.0  
---

## 0. Purpose  
The **GlossRP Tools Suite** consolidates two essential auxiliary modules that operate *outside* the core GlossRP subsystem while leveraging its schema and retrieval APIs:

1. **Glossary Exporter** — human-readable glossary generation  
2. **Category Curation Tool** — management of raw/emergent categories and canonicalization workflow  

This unified design improves developer ergonomics, PW integration, consistency of naming, and evolution readiness.

---

# Module 1 — Glossary Exporter  
*(Source: GlossRP_Tools_Glossary_Exporter_v1.0.md)*

## 1.1 Purpose  
Extract curated, structured glossary outputs for human or AI consumption from GlossRP’s canonical database.

## 1.2 Outputs  
- **Human Glossary (Simple)**  
- **Human Glossary (Grouped by Category)**  
- **AI Glossary (Structured)**  
- **JSON/JSONL export for downstream tools**  

## 1.3 Key Functions  
### `generate_simple_glossary()`
Returns a linear list of terms sorted alphabetically.

### `generate_categorized_glossary()`
Groups terms by canonical category using TermCategoryAssignment.

### `generate_ai_glossary()`
Outputs minimal but structured definitions optimized for machine consumption.

### `export_json()`
Exports glossary in JSON for external tools (curl/Postman/PW integrations).

---

# Module 2 — Category Curation Tool  
## 2.1 Purpose  
Manages the hybrid taxonomy model where TermSpecs supply **raw categories**, and GlossRP maintains **canonical categories**.

Curation operations include:  
- discovering emerging categories  
- validating semantic groupings  
- promoting raw labels into canonical categories  
- batch-updating existing records  
- assisting human governance of the taxonomy

## 2.2 Core Operations  
### `get_emerging_raw_categories(min_occurrences: int = 2, exclude_canonical: bool = True)`
Returns raw category labels that appear in TermSpecs but have not been validated.

### `get_terms_with_raw_category(raw_label: string, only_unassigned: bool = False)`
Retrieves terms linked to a raw label, optionally filtering to those not yet canonically assigned.

### `promote_raw_category(raw_label: string, canonical_name: string)`
Creates a TermCategory if needed and assigns all relevant TermVersions.

### `batch_assign_category(canonical_name: string)`
Backfills TermCategoryAssignment for all matching terms.

### `merge_categories(raw_labels: list, canonical_name: string)`
Consolidates multiple raw labels under a single canonical category.

---

# 3. GlossRP Integration Points  
## 3.1 Read-only Dependencies  
Both modules depend exclusively on:  
- Term  
- TermVersion  
- TermCategory  
- TermCategoryAssignment  

No write access occurs except through sanctioned curation operations.

## 3.2 SuLA Layer Integration  
The Tools Suite sits at **Layer 6 (Behavior Tools)** in SuLA.

---

# 4. PW Integration  
The PW Orchestrator consumes this suite as a unified module.  
Possible commands:

```
pw glossrp export simple
pw glossrp export categorized
pw glossrp curate show-emerging
pw glossrp curate promote <raw> <canonical>
pw glossrp curate merge <raw1> <raw2> ...
```

This organization enables PW to:  
- visualize emerging categories  
- support human approval flows  
- generate live glossaries  
- enforce taxonomy coherence

---

# 5. Evolution Notes  
- Canonical taxonomy grows only through human approval  
- Tools Suite may later include:  
  - Glossary diffing  
  - Category clustering  
  - AI-assisted classification  
  - PW-integrated review dashboards

---

# 6. Cross References  
- GlossRP Logical Data Model v2.2  
- GlossRP Manifesto  
- Category Taxonomy TermSpec  
- SuLA v1.0  
- PW Manifesto Registry

---

**End of GlossRP Tools Suite v2.0**
