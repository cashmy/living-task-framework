# EchoForge Config Home

Central location for project-level configuration files that EnaCs and surfaces can read without guessing feature paths.

## Current Files
| File | Purpose |
|------|---------|
| `mo_journal_prefs.example.yaml` | Default privacy/storage preferences for MO journal entries. Copy to `mo_journal_prefs.yaml` and customize. |
| `mo_journal_instrumentation.example.yaml` | Logging knobs for EnaC-generated MO journal events. Copy to `mo_journal_instrumentation.yaml` before editing. |

## Usage Pattern
1. Copy the `*.example.yaml` files to their non-example counterparts in the same directory.
2. Adjust values per environment or device.
3. Surfaces (watcher, desktop orchestrator, mobile) should load `projects/echo_forge/config` first, then merge feature-specific overrides if present elsewhere.
4. Commit example/default changes to the repo; keep personalized files out of version control unless intentionally shared.

As additional features (summaries, synthesis prompts, diagnostics) come online, add their configs here following the same naming convention (`<feature>_*.yaml`).
