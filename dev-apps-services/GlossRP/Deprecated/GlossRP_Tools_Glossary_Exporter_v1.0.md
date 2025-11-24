# GlossRP Tools — Glossary Exporter  
## Version 1.0 — Companion Utility Specification

---

## 0. Purpose & Relationship to GlossRP

**Glossary Exporter** is a **companion tool** to the GlossRP v2.1 microservice.

- It is **not** part of the GlossRP core service.  
- It **does not** access the database directly.  
- It operates **only** by calling GlossRP’s public APIs (REST or gRPC), and then:
  - rendering structured JSON responses into:
    - Markdown (`.md`) for human use and printing,
    - optionally cached JSON files for AI/context loading.

This keeps a **clean separation** between:

- **GlossRP:** semantic storage and retrieval (ECL-BASE), vs.  
- **Glossary Exporter:** presentation and artifact generation.

---

## 1. High-Level Goals

1. Provide a **rapid way** to generate human-readable glossaries of all active/current terms without manual copy/paste.  
2. Provide **print-friendly** formats (via `.md` → PDF or paper).  
3. Provide a **compact AI-facing semantic map** that can be loaded into an LLM to reduce “vacuum-awareness” drift.  
4. Be simple enough that it can be implemented as:
   - a small CLI tool, or  
   - a PW-integrated feature calling the same APIs.

---

## 2. Operating Assumptions

- GlossRP v2.1 is running and reachable (typically on `localhost` for local dev).
- GlossRP exposes:
  - `GET /api/v1/glossrp/glossary/human`
  - `GET /api/v1/glossrp/glossary/human/by-category`
  - `GET /api/v1/glossrp/glossary/ai`
- Responses are JSON and follow the structures defined by the **RetrievalEngine**.

The Exporter:

- Does not need DB credentials.  
- Only needs:
  - the GlossRP base URL,  
  - optional output paths / filenames.

---

## 3. Primary Commands & Outputs

### 3.1 `glossrp-export human`

**Purpose:** Generate a **flat, alphabetical human-readable glossary**.

**Process:**

1. Call:
   - `GET /api/v1/glossrp/glossary/human`
2. Receive JSON, e.g.:
   ```json
   [
     {
       "term_id": "glossrp",
       "name": "GlossRP",
       "acronym": null,
       "domain": "UCS-Core",
       "summary_human": "..."
     },
     ...
   ]
   ```
3. Render to Markdown file, default:
   - `Glossary_Human_Flat.md`

**Suggested Markdown Layout:**

```md
# Glossary — Human (Flat)

## Glossary Overview

This glossary lists active/current terms in alphabetical order with brief, human-readable explanations.

---

## Glossary Entries

### GlossRP
- **Domain:** UCS-Core  
- **Acronym:** *(none)*  
- **Description:** ...  

### LTF
- **Domain:** UCS-Core  
- **Acronym:** LTF  
- **Description:** ...  

...
```

The tool should:

- Sort by `name` case-insensitively.  
- Use simple, readable headings and bullet formatting.  
- Avoid any rephrasing; use `summary_human` exactly as returned.

---

### 3.2 `glossrp-export human-by-category`

**Purpose:** Generate a **category-grouped human-readable glossary**.

**Process:**

1. Call:
   - `GET /api/v1/glossrp/glossary/human/by-category`
2. Receive JSON, e.g.:
   ```json
   [
     {
       "category": "Framework",
       "terms": [
         { "term_id": "mxva", "name": "MxVA", "acronym": null, "summary_human": "..." },
         ...
       ]
     },
     {
       "category": "Concept",
       "terms": [
         ...
       ]
     }
   ]
   ```
3. Render to Markdown file, default:
   - `Glossary_Human_ByCategory.md`

**Suggested Markdown Layout:**

```md
# Glossary — Human (By Category)

## Overview

This glossary groups active/current terms by category (e.g., Concept, Framework, Tool) using their brief, human-readable descriptions.

---

## Category: Framework

### MxVA
- **Description:** ...

### ECL
- **Description:** ...

---

## Category: Concept

### Semantic Drift
- **Description:** ...

...
```

---

### 3.3 `glossrp-export ai-map`

**Purpose:** Generate an **AI-facing semantic map** artifact for LLM context-loading.

**Process:**

1. Call:
   - `GET /api/v1/glossrp/glossary/ai`
2. Receive JSON, e.g.:

   ```json
   [
     {
       "term_id": "glossrp",
       "name": "GlossRP",
       "acronym": null,
       "domain": "UCS-Core",
       "categories": ["UCS-Core", "Tool"],
       "summary_human": "...",
       "summary_architecture": "...",
       "metadata": {
         "origin": "GlossRP_Manifesto_v2.0",
         "related_terms": ["ltf", "scs"],
         "suspected_drift": false
       },
       "status": "current",
       "version": "v2.1"
     },
     ...
   ]
   ```

3. Save as:
   - `Glossary_AI_Semantic_Map.json` (default)

**Optional:** Provide a `--md` flag to render a **compact, AI-oriented markdown** variant:

```md
# GlossRP AI Semantic Map (Compact View)

- **Term:** GlossRP
  - **ID:** glossrp
  - **Domain:** UCS-Core
  - **Categories:** UCS-Core, Tool
  - **Status / Version:** current / v2.1
  - **Human Summary:** ...
  - **Architecture Summary:** ...
  - **Metadata Origin:** GlossRP_Manifesto_v2.0
  - **Related Terms:** ltf, scs
  - **Suspected Drift:** false

...
```

This markdown is still just a **projection**; no new meaning is added or inferred.

---

## 4. CLI Interface Specification

The Exporter is intended as a simple CLI, for example:

```bash
glossrp-export human   --host http://localhost:8080   --out ./docs/Glossary_Human_Flat.md

glossrp-export human-by-category   --host http://localhost:8080   --out ./docs/Glossary_Human_ByCategory.md

glossrp-export ai-map   --host http://localhost:8080   --out ./docs/Glossary_AI_Semantic_Map.json
```

### 4.1 Global Flags

- `--host` (string, required if not default)  
  - Default: `http://localhost:8080`

- `--out` (string, optional)  
  - Output file path. If omitted, use sensible defaults in current directory:
    - `Glossary_Human_Flat.md`
    - `Glossary_Human_ByCategory.md`
    - `Glossary_AI_Semantic_Map.json`

- `--format` (string, optional)  
  - For AI map, possible values:
    - `json` (default)
    - `md`

- `--quiet` (bool)  
  - Suppress non-error console output.

### 4.2 Exit Codes

- `0` — success  
- `1` — network/API error  
- `2` — invalid arguments  
- `3` — failed to write output file

---

## 5. Implementation Notes

### 5.1 Language & Dependencies

This tool can be implemented in any scripting language (Python, Node.js, Go, etc.) with:

- HTTP client capability,  
- basic file I/O,  
- minimal templating for markdown.

Suggested minimal stack:

- **Python:**
  - `requests` (or `httpx`) for HTTP,
  - standard library for CLI (`argparse`) and file writing.

or

- **Node.js:**
  - `node-fetch` / `axios` for HTTP,
  - `commander` for CLI parsing.

### 5.2 Behavior Constraints

To preserve ECL-BASE semantics:

- Do **not** rewrite or summarize content:
  - Use `summary_human` and `summary_architecture` as-is.  
- Do **not** infer new relationships:
  - If `metadata.related_terms` exists, list it as provided, do not expand.  
- Do **not** embed AI calls:
  - The Exporter is a projection-only utility, not a semantic engine.

All “intelligence” in formatting is limited to:

- sorting,
- grouping,
- heading levels,
- consistent markdown styling.

---

## 6. Future Extensions (Optional)

The following ideas are explicitly **optional** and must not change core semantics:

1. **PDF Generation Hook**
   - After writing `.md`, optionally run:
     - `pandoc` or similar to generate `.pdf` for printing.

2. **Filtered Glossaries**
   - Add flags such as:
     - `--category Framework`
     - `--domain UCS-Core`
   - These should be implemented by passing query parameters to GlossRP’s API, not by post-filtering in the Exporter where possible.

3. **Drift-Awareness View (Read-Only)**
   - If `metadata.suspected_drift == true`, mark entries visually:
     - e.g., “(⚠ suspected drift)” in the markdown.
   - This is a projection of stored metadata, not new detection.

4. **Integration with PW**
   - PW could embed the Exporter logic (or reimplement it) to provide “Export Glossary” buttons that call the same endpoints and formatting routines.

---

## 7. Non-Responsibilities

The Glossary Exporter:

- Does **not** manage TermSpecs or ingestion.  
- Does **not** modify any data in GlossRP.  
- Does **not** call embedding models.  
- Does **not** implement Tier logic, LTF behaviors, or SCS behaviors.  
- Does **not** act as a general document generator for other systems.

Its sole role is:

> **To project the glossary-related JSON views from GlossRP into human- and AI-friendly files for reference, printing, and context-loading.**

---

**End of GlossRP Tools — Glossary Exporter v1.0 Specification**  
