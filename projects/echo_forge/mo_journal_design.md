# EchoForge MO Journal Design (Co-Draft)

> Status: DRAFT (collaborative)  
> Owners: Cash ↔ EnaC  
> Last updated: 2025-11-14

This document captures the shared understanding of how MO (Meta Observation) journals will live inside EchoForge. It stays alongside the charter so every surface (mobile, desktop, web) inherits the same schema, privacy defaults, and instrumentation approach.

---

## 1. Purpose & Intent
- **Why**: Preserve the reflective practice that anchors EchoForge’s collaboration mandate while enabling EnaCs to learn routing patterns without diluting user-owned context.
- **Who**: Primarily the human author (self-awareness) with EnaC augmentation (pattern detection, auto-USM hints). Future collaborators can reference sanitized summaries when explicitly shared.
- **Where**: `projects/echo_forge/mo_journal/` (new root). The watcher or other EnaCs may write sub-artifacts inside this tree, but the canonical entries remain human-readable Markdown.

### Success Criteria
1. Entries remain emotionally accurate (no loss of nuance, no shaming tone).
2. Privacy modes are explicit per entry and enforced by tooling.
3. EnaC instrumentation cannot overwrite or delete human-authored journals.
4. Future schemas (e.g., orchestration-only logs) must link back to this design before diverging.

---

## 2. Folder Layout (proposal)
```
projects/echo_forge/
  config/
    mo_journal_prefs.example.yaml
    mo_journal_instrumentation.example.yaml
  templates/
    mo_journal/
      reflective.md          # base template per user/mode
  mo_journal/
    README.md                # short orientation + how to opt-in/out
    entries/
      2025-11-14-entry-001.md
      ...
    system/
      watcher_events.jsonl   # optional EnaC-only logs (metadata-only)
    drafts/
      2025-11-14-brainstorm.md
```
- `entries/`: authoritative reflective journals (Observation → Context → AI Reflection → Insight → Action Items).
- `system/`: optional machine-authored traces (capability usage, routing comments). Never stores transcript text unless privacy mode allows it.
- `drafts/`: workspace for in-progress reflections (ignored by automation unless promoted).
- `templates/`: central library under `projects/echo_forge/templates/` so other domains (summaries, prompts) can co-exist.

> **Note**: Template variants now live under `projects/echo_forge/templates/`; add per-mode files there as needs emerge.

---

## 3. Entry Template (baseline)
**Naming convention** (filename + heading):
```
moj-XXXX-[Code]-[slug].md

Examples:
- moj-0123-FutFeat-tier3-enhancements.md
- moj-0124-Insight-capture-trust-loop.md
```
- `moj-XXXX`: Global counter (zero-padded to 4 digits minimum) shared across all entries.
- `[Code]`: Short tag indicating the focus (see table).
- `[slug]`: Human-readable summary in kebab case for quick scanning.

| Code | Meaning | Use When |
|------|---------|----------|
| `FutFeat` | Future feature or enhancement | Capturing Tier 2/3 capability ideas |
| `Insight` | Personal/system insight | Noting behavior shifts or lessons |
| `Meta` | Collaboration/meta-state | Protocol, mode, or EnaC reflections |
| `Diag` | Diagnostics/debugging | Tracking watcher/capability investigations |
| `Share` | Intended for external sharing | Preparing exports to Trello/Jira/email |

> Add new codes as needed; keep them short (<10 chars) to avoid unwieldy filenames.

````markdown
# MO Journal Entry #moj-XXXX: [Title]
**Date**: YYYY-MM-DD  
**Session Context**: [link or short phrase]  
**Privacy Mode**: [metadata-only | partial | full]

---

## Observation
- [Human-authored reflection of what was noticed]

## Context
- [Triggering event, emotional state, system conditions]

## AI Reflection (optional EnaC contribution)
- [Structured analysis referencing capability registry / divergences]

## Insight
- [What this reveals about patterns, preferences, risks]

## Action Items
- Immediate / Short-term / Long-term buckets (checkbox lists encouraged)

## Related Artifacts
- Links to captures, manifests, or EnaC diagnostics (relative paths)
````
- **Sequential numbering**: global `moj-XXXX` increments to preserve lineage across days (no daily reset).
- **Privacy Mode** drives instrumentation behavior (see §4).
- **Filename rule**: `moj-XXXX-[Code]-[slug].md` keeps visual filtering simple and will help future mobile/cloud sync logic.

---

## 4. Privacy & Config Modes
Introduce a lightweight config file the user can edit (and surfaces can render).

```yaml
# projects/echo_forge/config/mo_journal_prefs.yaml
journal_storage:
  include_transcripts: false
  include_summaries: true
  include_ai_reflections: true
  retention_policy: keep_all   # keep_all | archive_6_months | delete_30_days
  share_with_collaborators: false

instrumentation:
  allow_system_entries: true
  redact_pii_patterns:
    - "email"
    - "phone"
  default_privacy_mode: metadata-only

# projects/echo_forge/config/mo_journal_instrumentation.yaml
instrumentation_control:
  log_level: info        # debug | info | warn | off
  event_frequency: normal  # minimal | normal | verbose
  rollover_strategy: rotate_daily  # rotate_daily | size_based | none
  max_retained_files: 14
  notes: "Toggle to debug when diagnosing EnaC routing."
```
- **Opt-in/out** toggles map directly to watcher CLI flags (once instrumentation lands).
- Future mobile/desktop clients must read this config before logging anything.

---

## 5. Instrumentation Hooks (outline)
1. **Watcher ingestion** emits a _system entry_ summarizing: timestamp, source file, STT capability, confidence, summary reference.
2. If privacy mode ≥ partial, system entry can link to human-created journal once available (no copying of transcript).
3. Manual MO entries can cite system metadata via frontmatter references:
   ```yaml
   system_refs:
     watcher_event_id: "wev-2025-11-14-0013"
     capability_profile: "stt_whisper_local"
   ```
4. Additional EnaCs (synthesis, review) append comments instead of modifying the base entry (think append-only blocks).
5. Instrumentation settings read from `projects/echo_forge/config/mo_journal_instrumentation.yaml`, allowing dynamic tuning without code changes (e.g., temporarily crank to `debug` to inspect routing, then revert to conserve space).

We’ll convert this outline into concrete tasks while implementing logging.

---

## 6. Collaboration Workflow
- **Co-drafting**: keep comments inline (Markdown blockquotes with `TODO` or `OPEN QUESTION`).
- **Promotion**: when a draft entry graduates to `entries/`, note the decision in git commit message for traceability.
- **EnaC edits**: only additive. Any automated rewrite must go through PR-style review or human confirmation.

---

## 7. Open Decisions / Questions
| Topic | Question | Status |
|-------|----------|--------|
| Numbering | Global `moj-XXXX` vs per-day `entry-00N`? | ✅ Global `moj-XXXX` confirmed |
| Templates | Do we need per-mood/per-mode variants? | _TBD_ |
| System Logs | Should watcher logs live in JSONL or SQLite? | JSONL for now (keep simple) |
| Sharing | How do we expose sanitized summaries to collaborators? | Export summaries/todos into Trello/Jira/GitHub; add optional share-to-email/social toggle | 

Add notes directly below this table as decisions land.

---

## 8. Next Actions
1. Confirm folder layout + numbering scheme (Cash ↔ EnaC).
2. Wire `journal_prefs.yaml` parsing into watcher CLI (respect opt-in/out).
3. Implement metadata-only system entries (JSONL under `mo_journal/system/`).
4. Draft human-facing `README.md` explaining how to create entries and adjust privacy.
5. Expand tests to cover config + journaling behavior.

*(Update this checklist as tasks move to repo-level TODOs.)*
