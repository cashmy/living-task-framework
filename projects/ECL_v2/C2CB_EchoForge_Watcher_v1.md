# C2CB Implementation Packet

## EchoForge Watcher v1 --- T1/T2 Ingest + Normalization Service

### Version 1.0

### Target Model: GPT-5.1-Codex (Preview)

------------------------------------------------------------------------

## 1. C2CB_Metadata

``` yaml
C2CB_Metadata:
  subsystem: "EchoForge"
  module_name: "EchoForge Watcher v1"
  version: "1.0.0"
  author: "Cash + EnaC (MxVA-aligned)"
  date: "2025-11-19"
  target_model: "GPT-5.1-Codex (Preview)"
  mode: "Implementation"
```

------------------------------------------------------------------------

## 2. Architectural Context

``` yaml
Context:
  purpose: >
    Monitor one or more input folders for new audio/text/file artifacts,
    ensure files are stable, run source-appropriate normalization
    (including STT for audio), and register/emit canonical Entry records
    for downstream EchoForge processing.
  architectural_role: >
    T1/T2 ingest + normalization service at the BASE layer of ECL,
    feeding standardized Entries into the EchoForge pipeline.
  dependencies:
    - "Filesystem access"
    - "Config file for watched folders and destinations"
    - "STT provider abstraction"
    - "Text extraction utilities for supported file types"
  upstream_systems: []
  downstream_systems:
    - "EchoForge Entry Store (database or file-based index)"
    - "EchoForge-Core normalization pipeline"
    - "Activity/infra logging (optional)"
```

------------------------------------------------------------------------

## 3. Requirements

### 3.1 Functional Requirements

``` yaml
Requirements:
  functional:
    - "Watch configured inbox directory/directories for new files."
    - "Detect when a file is stable (not being written to) before processing."
    - "Identify source type (audio | text | document) based on extension and/or MIME."
    - "Normalize all sources into a canonical verbatim text artifact."
    - "Invoke STT provider for audio files via a simple transcriber interface."
    - "Emit an Entry record with references to source and verbatim artifacts."
    - "Move original files from inbox to a processed/originals location."
    - "Move failed or unprocessable files to a quarantine/error directory."
    - "Provide a CLI or script entrypoint to start the watcher service."
  nonfunctional:
    - "The watcher should be idempotent: re-running should not reprocess the same file twice."
    - "The watcher must handle transient errors gracefully and log failures."
    - "Configuration (paths, file types, polling interval) must be externalized and editable."
    - "Implementation should be simple, testable, and avoid over-architecture."
```

------------------------------------------------------------------------

## 4. Data Structures

### 4.1 Entry (EchoForge-Core view)

``` yaml
DataStructures:
  - name: "Entry"
    description: >
      Canonical record representing a single ingested artifact, pointing to
      original and normalized forms, ready for further EchoForge processing.
    fields:
      - entry_id: "string (UUID)"
      - source_type: "enum('audio', 'text', 'file')"
      - source_path: "string (absolute or repo-relative path to original)"
      - verbatim_path: "string (path to normalized text artifact)"
      - ingest_timestamp: "datetime (ISO 8601)"
      - status: "enum('ingested', 'normalized', 'failed')"
      - error_message: "string | null"
```

### 4.2 STTResult

``` yaml
  - name: "STTResult"
    description: "Result from STT provider abstraction."
    fields:
      - transcript: "string"
      - confidence: "float | null"
      - duration_seconds: "float | null"
```

### 4.3 WatcherConfig

``` yaml
  - name: "WatcherConfig"
    description: "Configuration for watcher behavior."
    fields:
      - inbox_dirs: "list[string]"
      - processed_dir: "string"
      - error_dir: "string"
      - polling_interval_seconds: "int"
      - supported_audio_extensions: "list[string]"
      - supported_text_extensions: "list[string]"
      - supported_doc_extensions: "list[string]"
      - stt_provider: "string (provider id or module path)"
```

------------------------------------------------------------------------

## 5. Interfaces & APIs

``` yaml
Interfaces:
  - name: "transcribe_audio"
    type: "Function"
    inputs:
      - name: "audio_path"
        type: "str"
    outputs:
      - name: "result"
        type: "STTResult"
    errors:
      - name: "STTError"
        description: "Raised when transcription fails."

  - name: "normalize_file"
    type: "Function"
    inputs:
      - name: "file_path"
        type: "str"
      - name: "config"
        type: "WatcherConfig"
    outputs:
      - name: "verbatim_path"
        type: "str"
      - name: "source_type"
        type: "str"
    errors:
      - name: "NormalizationError"
        description: "Unsupported file type or conversion failure."

  - name: "create_entry_record"
    type: "Function"
    inputs:
      - name: "source_path"
        type: "str"
      - name: "verbatim_path"
        type: "str"
      - name: "source_type"
        type: "str"
      - name: "status"
        type: "str"
      - name: "error_message"
        type: "Optional[str]"
    outputs:
      - name: "entry"
        type: "Entry"
    errors:
      - name: "EntryStoreError"
        description: "Failure persisting Entry metadata."

  - name: "process_file"
    type: "Function"
    inputs:
      - name: "file_path"
        type: "str"
      - name: "config"
        type: "WatcherConfig"
    outputs:
      - name: "entry"
        type: "Entry"
    errors:
      - name: "ProcessingError"
        description: "Top-level error wrapper; logs and routes file to error_dir."

  - name: "run_watcher_loop"
    type: "Function"
    inputs:
      - name: "config"
        type: "WatcherConfig"
    outputs:
      - name: "None"
        type: "None"
    errors:
      - name: "RuntimeError"
        description: "Only for unrecoverable setup issues."
```

------------------------------------------------------------------------

## 6. Module Specification

``` yaml
ModuleSpec:
  description: >
    A Python-based watcher service that monitors configured inbox directories,
    normalizes discovered files into canonical verbatim text, and emits Entry
    records via a simple EntryStore interface or JSONL file.
  responsibilities:
    - "Continuously scan inbox directories on a polling interval."
    - "Detect stable files before processing."
    - "Dispatch to STT or text extractors based on file type."
    - "Create and persist Entry records."
    - "Move processed files into organized processed/originals directories."
    - "Move failed files into error/quarantine directory with logged error."
  constraints:
    - "Do not perform any semantic analysis or classification."
    - "Do not write MO journals or reflective artifacts."
    - "Do not interact directly with SCS, LTF, or MxVA; only emit Entries."
  interactions:
    - "Uses STT provider abstraction for audio transcription."
    - "Uses a pluggable EntryStore backend (file-based now, DB later)."
```

------------------------------------------------------------------------

## 7. File & Folder Layout

``` yaml
FileStructure:
  root: "./echo_forge/watcher"
  folders:
    - name: "core"
    - name: "providers"
    - name: "config"
    - name: "tests"
  files:
    - "core/watcher_loop.py"
    - "core/file_processor.py"
    - "providers/stt_provider.py"
    - "providers/text_extractors.py"
    - "config/watcher_config.example.yaml"
    - "__init__.py"
```

Notes:

-   Old `watcher_core.py` and `stt_stub.py` may inform design but should
    **not** be copied verbatim.
-   `EntryStore` can initially be implemented as:
    -   JSONL file at `./echo_forge/data/entries.jsonl` or similar.

------------------------------------------------------------------------

## 8. Implementation Directives (Codex-Optimized)

``` yaml
ImplementationDirectives:
  language: "Python 3.11+"
  coding_style: "PEP8, type-annotated"
  include_examples: true
  strict_type_safety: true
  include_unit_tests: true
  avoid:
    - "hard-coding absolute paths"
    - "embedding semantic or journaling logic"
    - "introducing async unless strictly necessary"
  must_follow:
    - "DataStructures definitions"
    - "Interfaces & APIs definitions"
    - "ModuleSpec constraints"
```

Additional notes for GPT-5.1-Codex:

-   Prefer small, cohesive functions over large monoliths.
-   Implement a minimal `EntryStore` class with:
    -   `save_entry(entry: Entry) -> Entry`
    -   Backed by JSONL or a simple SQLite DB.
-   Implement a `WatcherConfig` loader from YAML (pydantic optional but
    not required).

------------------------------------------------------------------------

## 9. Verification

``` yaml
Verification:
  tests_required:
    - "unit_tests for transcribe_audio using a stub/mocked provider"
    - "unit_tests for normalize_file (audio/text/doc paths)"
    - "unit_tests for process_file (success and failure paths)"
    - "unit_tests for idempotent behavior (same file not processed twice)"
  validation_criteria:
    - "Watcher runs without crashing for extended periods on a sample folder."
    - "Entries are created with correct paths and status fields."
    - "Unsupported file types are routed to error_dir with logged errors."
    - "No semantic fields (classification, tags, etc.) are present in Entries."
  human_review_required: true
```

------------------------------------------------------------------------

## 10. Notes to Executor (GPT-5.1-Codex)

-   Treat this packet as **authoritative**; do not invent higher-level
    structures.
-   Keep the watcher focused strictly on ingestion + normalization.
-   All semantic, journaling, or reflective behavior belongs in other
    subsystems and must not appear in this module.
