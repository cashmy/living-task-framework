# EchoForge Charter & Tier Map

## 0. Purpose
EchoForge is an AI thought-capture companion that preserves liminal ideas, synthesizes them into actionable work, and evolves alongside the user. This charter establishes the local cognitive contract so the app can leverage ECL/MxVA principles without requiring the full CORE-PRIMER sequence for every session. It defines the guardrails, tiers, and integration patterns that every EchoForge component (human-facing or EnaC-internal) must respect.

---

## 1. CIP-E Baseline (EchoForge Edition)
| Dimension | Definition | Non-Negotiables |
|-----------|------------|-----------------|
| **Context** | Liminal capture moments where the user cannot operate traditional tools. | Hands-free bias, minimal distraction, privacy-first ingestion. |
| **Intent** | Convert raw voice sparks into structured, recallable intelligence. | Preserve nuance, avoid dilution, keep provenance. |
| **Purpose** | Accelerate downstream creative/strategic work by auto-synthesizing ideas into plans and tasks. | Outputs must remain human-auditable, editable, and exportable. |
| **Emotion** | Calm, trusted, non-judgmental companion; no punitive or shaming tones when ideas are messy. | UI language stays encouraging; errors framed as recoverable. |
| **Evolution** | Learn from repeated themes, adapt model routing, and expand orchestration sophistication without breaking historical artifacts. | Auto-USM updates logged, divergence handling transparent, migrations reversible. |

---

## 2. Output Guardrails
### OS-EF (EchoForge Output Safety)
- No executable-looking formatting in system-level or review summaries (no fenced code blocks or CLI prompts) unless the user explicitly requests runnable snippets.
- Metadata-heavy sections (manifests, YAML) may be generated internally but must be wrapped in explanatory prose before leaving the EnaC boundary.
- Privacy flag respected: if a capture is marked private, no sync targets or notifications fire without affirmative opt-in.

### DOD-EF (Default Output Density)
- Default to concise, scannable summaries (title • summary • classification • 3 tasks).
- Expansion triggers: user requests “deeper detail,” classification confidence < 0.6, or divergence unresolved.
- Collapse when returning to baseline review to prevent runaway verbosity cascades in multi-model orchestration.

---

## 3. EchoForge Tier Definitions
| Tier | Scope | Responsibilities | Example Features |
|------|-------|------------------|------------------|
| **T1 – Charter Core** | Invariant, model-agnostic rules that stay hidden from users. | Enforce CIP-E, OS-EF, DOD-EF, privacy defaults, artifact schemas, provenance tracking. | Folder contracts (`Ideas/Inbox`, manifest fields), stable naming, failure handling, context saturation warnings. |
| **T2 – Model-Aware Intelligence** | Bindings between charter core and specific AI capabilities (LLMs, STT engines, embeddings). | Declare capability profiles, route tasks based on strengths, manage cost/latency trade-offs, maintain mode semantics. | Whisper-local vs cloud STT selection, Claude vs GPT synthesis routing, fallback policies, capability matrix. |
| **T3 – Orchestration & EnaC Collaboration** | Multi-model handoffs, divergence detection, MO journal, human-in-the-loop reconciliation. | Register EnaCs, log task delegation, detect conflicting classifications, surface consensus prompts, sync state across devices. | Review UI showing divergence alerts, MO Journal entries, cross-device context distribution, auto-USM updates. |

> **Mode Toggle**
> - **Design Mode**: Architecture, planning, and retrospectives must reference this charter explicitly (T1 active, T2/T3 optional).
> - **Runtime Mode**: User-facing flows may expose selected T2/T3 behaviors (e.g., divergence alerts) but cannot modify T1 invariants without a charter update.

### Mode Toggle Directory
| Toggle | Description | Activation Signals | Notes |
|--------|-------------|--------------------|-------|
| **Design Mode** | Planning and architecture work; speculative tier exploration. | Editing artifacts inside `projects/echo_forge/`, design reviews, retrospectives. | Must cite relevant charter clauses; permits T3 brainstorming without runtime changes. |
| **Runtime Mode** | Live user experience (watcher, UI, sync, API). | Deploying/operating components that touch user data. | T1 invariants locked; T2/T3 behaviors only via capability flags and documented rollout plans. |
| **Capture-Only Mode** | Minimal client usage when offline or using hardware recorders. | User records while disconnected; watcher processes later. | Guarantees ingest/privacy only; synthesis deferred. |
| **Review & Collaboration Mode** | Human-in-loop verification and collaborator edits. | Reviewer opens desktop/web UI to triage captures. | Enables inline edits, divergence alerts, consensus prompts. |
| **Diagnostics / Orchestration Mode** | EnaC-level tracing, capability tuning, MO journal inspection. | Developer sets diagnostics flag or runs tooling. | May surface extra metadata but must still obey OS-EF formatting. |

---

## 4. ECL-Core vs ECL-Edge Boundary (EchoForge View)
- **Core**: Charter, manifest schema, EnaC contracts, capability matrix, MO journal definitions. Never reference UI frameworks or specific storage tech.
- **Edge**: Watcher implementation, STT adapters, UI shells, sync connectors. Can be swapped freely if they honour Core contracts.
- **Bridge Notes**: When EchoForge needs to integrate with other LTF projects, create a `link.note.md` in the sibling project pointing back to the canonical artifact inside `projects/echo_forge/` (include relative path + summary).

---

## 5. CFP Compatibility Map
| CFP Element | EchoForge Handling |
|-------------|--------------------|
| CORE-PRIMER Tier 3 | Not required for end-users; EnaC instances inherit rules internally. |
| OS-1 / DOD-1 | Specialized into OS-EF / DOD-EF; deviations must be documented in this charter. |
| Mode Concepts | EchoForge supports Editor, Rewrite, Structure-Lock, Capture semantics internally; user UI defaults to Capture/Review. |
| CSAC | Session state stored as MO Journal + manifest; exporting to global CSAC requires an adapter to map metadata fields. |
| Behavioral Protocols | Seven protocols distilled into UI microcopy and reviewer flows (e.g., no shame language, encourage iteration). |

---

## 6. Initial Capability Matrix (Stub)
| Domain | Candidate EnaCs / Tech | Notes |
|--------|------------------------|-------|
| Capture Ingest | Watchdog Python service, OS-level shortcuts, future mobile API | Local-first bias, offline capability required. |
| STT | Whisper.cpp, OpenAI Whisper API, AssemblyAI | Flag cost vs speed; ensure confidence score exposed. |
| Synthesis | Claude (safety), GPT (structured plans), local LLM (offline) | Route by task type; log divergences. |
| Storage & Review | Markdown vault + SQLite manifest, LiteFS, eventual cloud sync | Must keep provenance + privacy tags. |
| Sync Targets | Obsidian, Notion, Trello, GitHub Issues | Each accessed through Edge adapters honoring OS-EF rules. |

(Expand this matrix as components are evaluated.)

---

## 7. Component Tier Progression
The codebase stays unified; tiers represent capability envelopes that activate as EchoForge matures.

### 7.1 Capture UI & Review Surface
| Tier | Outcome | Notes |
|------|---------|-------|
| **T1** | Queue of captures with transcript + summary, approve/archive actions only. | Enforces OS-EF tone, provenance metadata visible, no collaboration affordances. |
| **T2** | Adds classification confidence meters, inline edits, collaborator comments, device sync indicators. | Pulls from manifest/MO journal for richer context; feature flags gate exposure. |
| **T3** | Orchestration dashboard with divergence alerts, consensus prompts, Stage-6 insights (theme evolution, auto-USM). | Requires multi-model routing; DOD-EF still default. |

### 7.2 Watcher / Ingest Pipeline
| Tier | Outcome | Notes |
|------|---------|-------|
| **T1** | Single watcher, deterministic flow, stub STT acceptable, minimal logging. | Guarantees naming, privacy defaults, failure handling. |
| **T2** | Capability-aware ingest: parallel queue, retries, pluggable STT adapters with confidence gating. | Uses capability registry to pick engines, records latency/cost metrics. |
| **T3** | Distributed ingest mesh with context offloading, cross-device state sync, MO journal hooks per task. | Enables HOMSP/orchestrated deployments while honoring Core contracts. |

### 7.3 API / Backend Services
| Tier | Outcome | Notes |
|------|---------|-------|
| **T1** | CRUD endpoints for captures, summaries, manifest queries. | Contracts stable across tiers; payloads minimal. |
| **T2** | Streaming status, webhook notifications, collaborator roles/permissions. | Introduces auth tiers, richer payloads, rate governance. |
| **T3** | Orchestration events, divergence reports, auto-USM feeds, external EnaC hooks. | Backward compatible via tier flags in responses. |

### 7.4 Synthesis & AI Modules
| Tier | Outcome | Notes |
|------|---------|-------|
| **T1** | Single-model summaries + task scaffolds. | Deterministic prompts, schema compliance. |
| **T2** | Capability routing among Claude/GPT/local models, confidence scoring, fallback prompts. | Logs model-choice rationale for audit. |
| **T3** | Multi-model orchestration with divergence detection, reconciliation, auto-learning feedback loops. | MO journal captures each handoff; user can choose consensus vs specialist. |

### 7.5 Storage, Sync & Knowledge Surfaces
| Tier | Outcome | Notes |
|------|---------|-------|
| **T1** | Markdown artifacts + local SQLite manifest, manual export only. | Ensures provenance, privacy tagging. |
| **T2** | Bi-directional sync (Obsidian/Notion/Trello), conflict detection, incremental backups. | Edge adapters enforce OS-EF formatting. |
| **T3** | Federated knowledge graph, semantic recall across sessions, contextual suggestions during capture. | Supports distributed deployments while preserving core schema. |

---

## 8. Component Inventory (Early)
| Component | Description | Current Maturity | Dependencies / Notes |
|-----------|-------------|------------------|----------------------|
| Watcher / Ingest Service | Monitors `Ideas/Inbox`, enforces stability, orchestrates processing. | **T1 implemented** | Needs MO journal logging + capability-aware STT selection. |
| STT Adapter Layer | Interface for Whisper-local/cloud engines with confidence telemetry. | **T1 stub** | Capability registry will capture cost/privacy per engine. |
| Synthesis Engine | Prompt wrappers for summaries, classifications, task scaffolds. | **T1 basic** | Tier-2 routing + divergence detection planned. |
| Manifest & MO Journal | Persistent provenance + orchestration ledger. | **Design** | Required before exposing Tier-3 UX. |
| Capture UI | Minimal queue/review experience. | **Concept** | Tier roadmap defined in §7.1; awaiting design/runtime checklist. |
| Review & Collaboration UI | Advanced reviewer tooling, comments, consensus workflows. | **Future** | Depends on manifest richness + MO journal instrumentation. |
| Sync Connectors | Edge adapters to Obsidian, Notion, Trello, GitHub, etc. | **Future** | Must respect OS-EF formatting + privacy toggles. |
| Capability Registry | Catalog of EnaC abilities, costs, constraints. | **Not started** | Implementation noted in action #2. |
| Orchestration Diagnostics | Tooling to inspect capability routing, divergence events. | **Not started** | Uses diagnostics mode + MO journal data. |

---

## 9. Implementation Notes & Next Actions
1. **MO Journal Instrumentation**: Update watcher pipeline to log each processing run with EnaC metadata (`ingest`, `stt`, `synthesis`, `review`).
2. **Capability Registry File**: Maintain `capabilities.yaml` (scoring latency, cost, privacy, offline support) and reference it from EnaCs to justify tech selections.
3. **Design vs Runtime Checklist**: Maintain `design_runtime_checklist.md` to remind contributors (human or EnaC) which mode they are in before modifying artifacts or runtime features.
4. **Cross-Project Links**: When another project references EchoForge work, add a `NOTE_echo_forge.md` in that project with a pointer back to the relevant file here.
5. **Watcher Relocation**: All watcher code, tests, and docs now live exclusively under `projects/echo_forge/watcher/`. Any ingest/runtime edits must occur here; legacy `projects/ai-thought-capture/watcher` remains deprecated with a link note.
6. **MO Journal Workflow**: Watcher events append to `projects/echo_forge/mo_journal/system/watcher_events.jsonl`. Human reflections MUST cite these event IDs when promoting drafts in `mo_journal/entries/`, ensuring EnaC telemetry and human narratives stay traceable.

This charter is considered the single source of truth for EchoForge’s cognitive contract. Any deviation (e.g., changing default output density or exposing new Tier-3 behaviors to end users) must be recorded as an explicit charter update with rationale and impact.

---

## 10. Deployment Vision & Surface Strategy
EchoForge must feel cohesive no matter which surface the user touches, so final deployment targets are declared up front. Each surface inherits the charter’s privacy defaults, capability registry, and MO journal contracts.

| Surface | Purpose | Delivery Model | Notes |
|---------|---------|----------------|-------|
| **Mobile Capture Companion (iOS / Android)** | Hands-free ingest, quick summary review, offline-first queueing. | Cross-platform client (React Native/Expo or Flutter) distributed via App Store / Play Store using on-device encrypted storage and optional LAN sync. | Must sync with the local desktop orchestrator before any cloud relay; respects Capture-Only mode when offline. |
| **Desktop Orchestrator (macOS / Windows / Linux)** | Runs watcher, capability routing, synthesis, MO journal review, collaborator tooling. | Packaged desktop app (Electron/Tauri + Python/Rust services) downloaded from EchoForge site or signed releases. | Serves as the canonical “home base” for configs, capability registry, and journals; can expose Diagnostics / Orchestration Mode. |
| **Web Dashboard** | Higher-level triage, divergence visualization, collaborator access. | Local-first SPA (Next.js/SvelteKit) served by the desktop orchestrator or a self-hosted node. | Only exposes data that already lives in the local CSAC; remote hosting requires opt-in and encrypted channels. |
| **Service Layer** | APIs for transcription, journaling, sync adapters, and future EnaC integrations. | Local FastAPI/Fastify-style services packaged with the desktop app; optional cloud relay if the user explicitly enables cross-device sync. | API boundaries must advertise tier flags so downstream clients know which capabilities are active. |

### Registry & Ledger Stance
- Capability registry stays as signed YAML/JSON under git; this provides transparent history without needing blockchain.
- No Ethereum or other distributed ledger is required for baseline deployments. If third-party EnaCs ever need tamper-evident attestations, we will evaluate append-only logs or Sigstore-style signing before introducing blockchain complexity.
- Any decentralized proofs must remain optional and never a prerequisite for local-only operation.

### Deployment Guardrails
- All new clients must be generated from artifacts in `projects/echo_forge/` to keep the “one-home” directive intact.
- Surface releases cannot bypass OS-EF/DOD-EF constraints; mobile/web copy must inherit tone guidance directly from this charter.
- Privacy/telemetry defaults mirror the configuration file (to be defined with MO journal work) so opt-in/opt-out behavior is consistent everywhere.
