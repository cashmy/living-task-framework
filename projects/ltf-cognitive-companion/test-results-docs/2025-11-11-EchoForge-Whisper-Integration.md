# EchoForge ↔ Whisper Watcher Integration Specification
**Date:** 2025-11-11  
**Captured via:** CFP Capture Protocol (Flow State: Consolidation Phase)  
**Purpose:** Define minimal-collision architecture and integration plan between the existing Whisper STT watcher and the EchoForge AI Thought Capture (ATC) system.

---

## 🧭 Overview
This document details how to unify the Whisper-based audio watcher pipeline with the EchoForge AI Thought Capture framework while preserving modularity and avoiding architecture collisions.  
The watcher handles audio ingestion and transcription, while EchoForge extends this by adding semantic processing, classification, and export.

---

## ⚙️ Roles and Responsibilities

| Component | Role | Responsibility |
|------------|------|----------------|
| **Watcher (Existing)** | Input Source Adapter | Detects new audio files, optionally performs Whisper STT, and emits ingest events. |
| **EchoForge (ATC Service)** | Cognitive Processing System | Receives ingestion events, processes transcripts, and generates structured artifacts with summaries, tags, and metadata. |

---

## 🧩 Event Flow Summary

1. **Watcher detects** new audio file in `/watcher/inbox/`  
2. **Optional STT transcription** via Whisper; output stored as `.txt` or `.json`  
3. **Watcher posts** event payload to EchoForge `/v1/ingest` endpoint  
4. **EchoForge receives**, processes, and optionally calls Whisper internally if no transcript present  
5. **EchoForge runs** summarizer, classifier, and tagger  
6. **Artifacts generated** in Markdown or other specified formats and exported to destination

---

## 🧱 Event Contract (JSON Schema)

```json
{
  "session_id": "sess-2025-11-11-A",
  "project": "EchoForge",
  "channel": "voice",
  "payload": "file:///watcher/inbox/audio_2025-11-11_1501.wav",
  "options": {
    "stt": "whisper",
    "language": "en",
    "diarization": false,
    "transcription_hint": "brainstorm notes"
  },
  "metadata": {
    "source": "watcher",
    "created_at": "2025-11-11T15:01:05Z"
  }
}
```

**Notes:**  
- `options.stt` defines whether Whisper or another STT engine is used.  
- `payload` supports both absolute and relative URIs.  
- `metadata.source` allows analytics and lineage tracking across tools.

---

## 🔄 Architecture Boundaries

| Layer | Owned by | Description |
|--------|-----------|-------------|
| **File Watching** | Watcher | Detects, renames, and manages raw audio file states. |
| **Speech-to-Text** | Watcher or EchoForge (configurable) | Can be run in watcher (preferred) or delegated to EchoForge if `stt.mode = "internal_whisper"`. |
| **Capture & Summarization** | EchoForge | Receives JSON payloads, performs semantic analysis and tagging. |
| **Export & Indexing** | EchoForge | Outputs artifacts (Markdown, DOCX, etc.) and manages provenance logs. |

---

## 🧠 Integration Modes

| Mode | Description | Ideal Use Case |
|------|--------------|----------------|
| **use_watcher** | EchoForge assumes transcript provided by watcher. | High-performance, low-latency pipelines. |
| **internal_whisper** | EchoForge runs Whisper internally on received audio. | Simplified deployment, no watcher preprocessing. |
| **auto** | EchoForge checks for transcript; if none, invokes Whisper internally. | Best for mixed or dynamic environments. |

---

## 🗃️ File & Directory Structure

```
watcher/
 ├─ inbox/           # Raw audio files
 ├─ transcripts/     # Whisper outputs (.json, .txt)
 ├─ processed/       # Moved after successful POST to EchoForge
 ├─ logs/            # Watcher-level logs
echo_forge/
 ├─ artifacts/       # Generated Markdown/DOCX/PDF outputs
 ├─ sessions/        # Session digest JSONs
 ├─ logs/            # Processing logs
 └─ config/          # system config + keys
```

---

## ⚙️ Configuration Parameters

### EchoForge (example: `config.json`)
```json
{
  "stt": { "mode": "use_watcher" },
  "watcher_endpoint": "http://localhost:5173/v1/ingest",
  "export": {
    "default_format": "md",
    "destination": "local",
    "folder": "/EchoForge/{{date_folder}}"
  },
  "analytics": { "enable": true }
}
```

### Watcher (example: `watcher.conf`)
```ini
[Paths]
inbox=/watcher/inbox
transcripts=/watcher/transcripts
processed=/watcher/processed

[EchoForge]
post_to=http://localhost:5173/v1/ingest
on_success=move_to_processed
session_id=sess-2025-11-11-A
project=EchoForge
```

---

## 🧩 Integration Principles

1. **Separation of Concerns:** Watcher handles file I/O and STT, EchoForge handles semantics and metadata.  
2. **Idempotency:** Use SHA256 or hash signature to prevent duplicate submissions.  
3. **Temporal Tracking:** Preserve timestamps for analytics and productivity mapping.  
4. **Minimal Coupling:** Both systems can evolve independently.  
5. **CFP Ethics Integration:** All exports retain provenance and authorship transparency.

---

## 📊 Productivity Analytics

EchoForge timestamps all artifacts and can derive time spent per stage:  
- **Watcher latency:** File creation → POST event.  
- **EchoForge latency:** Ingest → Artifact generation.  
- **Aggregate:** Enables measurement of AI productivity uplift per SDLC phase.

---

## ✅ Summary

| Element | Description |
|----------|-------------|
| **Integration Type** | Event-driven (watcher → EchoForge via HTTP POST) |
| **Schema Type** | JSON (session/project aware) |
| **STT Engine** | Whisper (primary) |
| **Export Targets** | Markdown, DOCX, PDF, Notion, Obsidian |
| **Collision Risk** | Minimal — clean boundaries |
| **Next Steps** | Implement bridge script + configuration example |

---

**Captured via:** CFP Capture Protocol  
**Flow Stage:** Consolidation  
**Transparency:** This artifact was co-authored via AI-assisted cognitive reflection and post-flow structuring under the CFP ethical collaboration framework.
