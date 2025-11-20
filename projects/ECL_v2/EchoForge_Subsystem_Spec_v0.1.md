# EchoForge Subsystem Specification

## Version 0.1 --- Core + Orchestrator + Interfaces

### Status: Draft (Validated Architecture-Aligned)

------------------------------------------------------------------------

# 1. PURPOSE

EchoForge is the **ingestion and normalization subsystem** for the
cognition-to-architecture pipeline.\
It provides:

-   Raw intake (audio, text, file)\
-   Normalization into canonical verbatim text\
-   Lightweight summarization\
-   Orchestrated semantic handoff into SCS\
-   Routing into LTF, MxVA, and external systems\
-   A unified "entry-first" data model

EchoForge intentionally remains **tier-pure** as a T1/T2 subsystem,
while orchestrating calls to higher-tier EnaC agents when needed.

------------------------------------------------------------------------

# 2. ARCHITECTURAL POSITION (ECL + MxVA Context)

    MxVA (T3/T4 Architecture + Governance)
          ↑
    LTF (T2/T3 Evolution Engine)
          ↑
    SCS (T2 Semantic Structuring Spine)
          ↑
    EchoForge (T1/T2 Capture & Intake)

EchoForge operates at the **BASE layer of ECL**:

-   Entry = BASE\
-   Concept (via SCS) = CORE\
-   Actions (via LTF/MxVA) = SKY

------------------------------------------------------------------------

# 3. SUBSYSTEM COMPONENTS

EchoForge consists of two conceptual layers:

## 3.1 EchoForge-Core

Handles raw ingestion + normalization only.

### Responsibilities

-   Accept entries from multiple sources\
-   Create `Entry` records\
-   Convert raw payload → standard verbatim text\
-   Produce minimal summaries\
-   Maintain ingest status lifecycle

### Out of Scope

-   Deep semantic analysis\
-   Relational mapping\
-   Evolution tracking\
-   Framework-level reasoning

------------------------------------------------------------------------

## 3.2 EchoForge-Orchestrator

Coordinates cross-subsystem actions.

### Responsibilities

-   Trigger SCS for classification\
-   Generate action options\
-   Build prompt bundles for EnaC interactions\
-   Provide routing into LTF or external execution systems\
-   Present options for human decision

### Out of Scope

-   Architecture-level decisions (MxVA domain)\
-   Concept evolution (LTF domain)

------------------------------------------------------------------------

# 4. INGESTION FLOWS

## 4.1 Supported Input Methods

1.  **Audio ingestion**

    -   via watched folder\
    -   via UI upload\
    -   via in-app recording (future)

2.  **Keyboard text entry**

3.  **File upload**

    -   .md\
    -   .pdf (text extract)\
    -   .docx\
    -   .txt\
    -   .rtf (optional)

------------------------------------------------------------------------

# 5. PROCESSING PIPELINE

## Step 1 --- Entry Creation

EchoForge creates an `Entry` with:

-   `entry_id`\
-   `source_type`\
-   `source_path`\
-   timestamps\
-   empty metadata fields\
-   `status = ingested`

------------------------------------------------------------------------

## Step 2 --- Normalization (T1/T2)

### Audio → Verbatim

-   Speech-to-Text\
-   Text cleanup\
-   Store `verbatim_path`

### Document → Verbatim

-   Text extraction\
-   OCR (optional)\
-   Store `verbatim_path`

### Raw text → Verbatim

-   Direct copy

`status = normalized`

------------------------------------------------------------------------

## Step 3 --- First-Pass Summary (T1 EnaC)

Produces:

-   `summary`\
-   `short_description`

Attached to Entry.\
`status = summarized`

------------------------------------------------------------------------

## Step 4 --- Semantic Classification (via SCS, T2/T3)

Triggered by EchoForge-Orchestrator.

Produces:

-   **Topic type**\
-   **Category** (from master classification table)\
-   **Tags / Keywords**\
-   **Icon ID / Image reference**\
-   **Extracted Concept Objects**\
-   **Relationship seeds** (if applicable)

Stored inside a `ConceptMetadata` object linked to the Entry.

`status = classified`

------------------------------------------------------------------------

## Step 5 --- Prompt Bundle Generation

A self-contained package for downstream processing:

-   Summaries\
-   Key excerpts\
-   Classification metadata\
-   Recommended next-step prompts

Used by:

-   Reflective EnaC\
-   Research EnaC\
-   Coding LLM\
-   LTF\
-   MxVA

------------------------------------------------------------------------

## Step 6 --- Action Option Generation (T2/T3)

Structured list of:

-   Feedback\
-   Clarification\
-   Atomic Reframe\
-   Cross-Context Reframe\
-   Research Brief\
-   ToDo (Trello/Notion/GitHub)\
-   LTF registration\
-   MxVA architecture consideration\
-   Coding spike initiation

Each option contains:

-   `action_id`\
-   Pre-built prompt\
-   Intended destination subsystem\
-   Execution metadata

------------------------------------------------------------------------

## Step 7 --- Human Decision + Routing

User selects one or many of:

-   Re-run analysis\
-   Send to LTF\
-   Create tasks\
-   Initiate coding work\
-   Request deeper reframing\
-   Move to MxVA for architectural work

`status = actioned`

------------------------------------------------------------------------

# 6. DATA MODELS (First-Pass Schema)

## 6.1 Entry (EchoForge-Core)

    Entry {
      entry_id: string
      source_type: enum (audio | text | file)
      source_path: string
      verbatim_path: string
      ingest_timestamp: datetime
      status: enum
      summary: string
      short_description: string
    }

------------------------------------------------------------------------

## 6.2 ConceptMetadata (SCS layer)

    ConceptMetadata {
      concept_id: string
      entry_id: string
      topic_type: string
      category: string
      tags: [string]
      keywords: [string]
      icon_id: string
      image_ref: string
      status: enum (seed | active | integrated)
    }

------------------------------------------------------------------------

## 6.3 ActionOption (Orchestrator layer)

    ActionOption {
      action_id: string
      linked_entry: string
      linked_concept: string
      action_type: string
      destination: string
      action_prompt: string
      executed: boolean
      executed_at: datetime
    }

------------------------------------------------------------------------

# 7. STATES & TRANSITIONS

    ingested → normalized → summarized → classified → action_suggested → actioned

Each state corresponds to a stable, reversible operation.

------------------------------------------------------------------------

# 8. EXTERNAL INTERFACES

### Outbound

-   SCS (semantic analysis)\
-   LTF (evolution tracking)\
-   MxVA (framework synthesis)\
-   Research LLMs\
-   Coding LLMs\
-   External tool APIs (Trello, Notion, GitHub)

### Inbound

-   Watcher for audio folder\
-   UI uploads\
-   Text entry

------------------------------------------------------------------------

# 9. NON-GOALS

-   No long-term vector search (LTF domain)\
-   No evolution history maintenance (LTF)\
-   No architecture generation (MxVA)\
-   No SELF-ECL modeling

------------------------------------------------------------------------

# 10. STATUS

EchoForge subsystem design is **complete**, aligned with:

-   ECL\
-   MxVA\
-   EnaC tier boundaries\
-   C2CB expectations

Ready for UI spec development and implementation decomposition.
