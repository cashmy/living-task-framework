# EchoForge Watcher

Minimal Python watcher that monitors an `Ideas/Inbox` folder for new audio files and produces a Markdown artifact into `Ideas/Processed`.

This component originated inside AI Thought Capture but now lives under EchoForge so all runtime tooling, configs, and MO journal instrumentation share one home. The behavior and intent remain the same: provide a local-first ingest surface that can route to the right STT capability while defaulting to the stubbed adapter until a real engine is wired in.

Contents
- `watcher.py` — CLI entrypoint and optional long-running watcher using `watchdog`, with capability-registry awareness.
- `watcher_core.py` — core processing primitives (stability checks, processing, markdown emission).
- `stt_stub.py` — stubbed transcription adapter (replace with Whisper/OpenAI/etc.).
- `requirements.txt` — minimal dependencies.
- `tests/test_watcher.py` — basic pytest-based tests.
- `run_watcher.ps1` — convenience PowerShell script to run the watcher on Windows.

Quick start (PowerShell, run from repo root)

1. (Optional) Create a Python venv and activate it.
2. Install dependencies:

```pwsh
python -m pip install -r projects/echo_forge/watcher/requirements.txt
```

3. Create folders (or point `--inbox`/`--processed-dir` to existing ones):

```pwsh
mkdir "Ideas/Inbox"
mkdir "Ideas/Processed"
mkdir "Ideas/Processed/originals"
```

4. Run once to process the inbox (defaults automatically find EchoForge configs):

```pwsh
python -m projects.echo_forge.watcher.watcher --inbox "Ideas/Inbox" --processed-dir "Ideas/Processed" --once
```

5. Or run continuously, forcing local-first privacy:

```pwsh
python -m projects.echo_forge.watcher.watcher --inbox "Ideas/Inbox" --processed-dir "Ideas/Processed" --stt-policy local-first --require-offline
```

> **Why `python -m …`?** Running the entrypoint as a module keeps relative imports intact no matter where you invoke the watcher from. If you prefer not to type the long command, use `projects/echo_forge/watcher/run_watcher.ps1`—it wraps the same module call and exposes the `--once` flag.

### Capability-aware flags

- `--capabilities-file`: Path to EchoForge capability registry (defaults to `projects/echo_forge/capabilities.yaml`).
- `--stt-policy`: `auto`, `local-first`, or `cloud-first` routing logic.
- `--max-cost`, `--max-latency`: Filter unacceptable options (scale 1-5).
- `--require-offline`: Only allow engines with full offline support.
- `--journal-prefs`: Path to MO journal storage/privacy prefs (`projects/echo_forge/config/mo_journal_prefs.yaml`).
- `--journal-instrumentation`: Controls log level/verbosity for EnaC events (`projects/echo_forge/config/mo_journal_instrumentation.yaml`).
- `--journal-log`: JSONL destination for system events (`projects/echo_forge/mo_journal/system/watcher_events.jsonl`).

Once real adapters are implemented, update `STT_IMPLEMENTATIONS` in `watcher.py` to map capability names to the appropriate transcriber.

### MO journal integration

Running the watcher now records metadata-only events into the EchoForge MO journal (`mo_journal/system/watcher_events.jsonl`). Use the config files under `projects/echo_forge/config/` to control whether transcript previews are included, what log level to emit, and how verbose the logging should be. Human-authored journal entries can reference these event IDs to anchor reflections back to specific ingest runs.

### Generating a human MO journal entry from a watcher run

1. **Confirm prefs/instrumentation** – copy the example configs in `projects/echo_forge/config/` (see MO journal README) and tweak privacy/logging before you run the watcher.
2. **Run the watcher** – invoke either the PowerShell helper or the direct CLI. The defaults already write to `mo_journal/system/watcher_events.jsonl`, or override via `--journal-log` if you want a scratch file.
3. **Grab the event payload** – after the watcher finishes, open the JSONL log and copy the block you care about. Example PowerShell:
	```pwsh
	Get-Content projects/echo_forge/mo_journal/system/watcher_events.jsonl -Tail 1 | ConvertFrom-Json
	```
	Note the `event_id`, capability, timestamps, and summary snippet (if enabled).
4. **Seed a reflective entry** – duplicate `projects/echo_forge/templates/mo_journal/reflective.md` into `projects/echo_forge/mo_journal/drafts/` using the next `moj-XXXX` number. Reference the watcher event inside the "Observation" block (e.g., `Watcher Event: wev-abcd1234`).
5. **Interpret + promote** – fill in insights, critiques, and next actions that respond to the ingestion run. When it’s publish-ready, move the file into `mo_journal/entries/` and commit alongside the updated JSONL log (if new events were added).

This flow keeps EnaC-generated telemetry (`system/*.jsonl`) separate from the human-authored narrative while preserving traceability between them.

> Need a faster start? Use `python projects/echo_forge/mo_journal/tools/seed_from_watcher.py --title "My reflection"` to auto-generate a draft referencing the latest watcher event.
