"""Utility to seed an MO journal draft from the latest watcher event."""

from __future__ import annotations

import argparse
import json
import re
import textwrap
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional, Tuple

DEFAULT_LOG = Path("projects/echo_forge/mo_journal/system/watcher_events.jsonl")
DEFAULT_DRAFTS = Path("projects/echo_forge/mo_journal/drafts")
DEFAULT_ENTRIES = Path("projects/echo_forge/mo_journal/entries")
DEFAULT_TEMPLATE_TITLE = "Watcher reflection"

CODE_PRESETS: Dict[str, Dict[str, List[str]]] = {
    "Diag": {
        "immediate": [
            "[ ] Confirm event telemetry matches expectations",
            "[ ] Capture any anomalies or errors observed",
        ],
        "short": [
            "[ ] Update diagnostics backlog if follow-up is required",
        ],
        "long": [
            "[ ] Consider automation or visibility improvements",
        ],
    },
    "FutFeat": {
        "immediate": [
            "[ ] Outline desired feature behavior",
            "[ ] Identify affected charter sections or configs",
        ],
        "short": [
            "[ ] Break down delivery phases or experiments",
        ],
        "long": [
            "[ ] Record research questions or dependency spikes",
        ],
    },
    "Meta": {
        "immediate": [
            "[ ] Describe the meta insight or pattern",
        ],
        "short": [
            "[ ] Link to prior MO entries for continuity",
        ],
        "long": [
            "[ ] Decide whether this affects charter/protocol",
        ],
    },
}

DEFAULT_SESSION_CONTEXT = "Watcher relocation verification"
DEFAULT_ENERGY_TONE = "Pending"

CONTEXT_PRESETS: Dict[str, Dict[str, str]] = {
    "watcher-relocation": {
        "session": "Watcher relocation verification",
        "energy": "Focused, steady execution",
    },
    "automation-scouting": {
        "session": "Automation exploratory session",
        "energy": "Curious, systems-oriented",
    },
    "futfeat-design": {
        "session": "Future feature design notebook",
        "energy": "Optimistic, horizon scanning",
    },
}

SNIPPET_LIBRARY: Dict[str, List[str]] = {
    "triage": [
        "[ ] Review raw telemetry for missing fields",
        "[ ] Validate privacy mode vs actual content",
        "[ ] Confirm log rotation/retention still compliant",
    ],
    "collab": [
        "[ ] Summarize key findings for collaborators",
        "[ ] Decide whether to share artifacts externally",
    ],
    "automation": [
        "[ ] Identify manual steps suitable for automation",
        "[ ] Capture constraints before implementation",
    ],
}

ENTRY_PATTERN = re.compile(r"moj-(\d{4})-", re.IGNORECASE)


def read_latest_event(log_path: Path) -> Tuple[dict, str]:
    if not log_path.exists():
        raise FileNotFoundError(f"Log not found: {log_path}")
    last_line: Optional[str] = None
    with log_path.open("r", encoding="utf-8") as handle:
        for line in handle:
            stripped = line.strip()
            if stripped:
                last_line = stripped
    if not last_line:
        raise ValueError(f"No events found in {log_path}")
    data = json.loads(last_line)
    event_id = data.get("event_id") or "unknown"
    return data, event_id


def next_entry_number(*directories: Path) -> int:
    highest = 0
    for directory in directories:
        if not directory.exists():
            continue
        for path in directory.glob("moj-*.md"):
            match = ENTRY_PATTERN.match(path.name)
            if match:
                highest = max(highest, int(match.group(1)))
    return highest + 1


def slugify(text: str) -> str:
    slug = re.sub(r"[^a-zA-Z0-9-]+", "-", text.strip().lower()).strip("-")
    return slug or "entry"


def format_checklist(items: List[str]) -> str:
    if not items:
        return "- [ ] (add items)"
    return "\n".join(items)


def artifact_notes(event: dict) -> str:
    capability = event.get("capability") or "unknown"
    privacy_mode = event.get("privacy_mode") or "unknown"
    notes = []
    if privacy_mode == "cloud":
        notes.append(
            "- [ ] Confirm cloud privacy defaults are acceptable for this run."
        )
    if capability and capability.startswith("stt_whisper"):
        notes.append("- [ ] Compare Whisper tiers (local vs API) for this scenario.")
    return "\n".join(notes)


def build_entry_content(
    *,
    number: int,
    code: str,
    title: str,
    event: dict,
    event_id: str,
    privacy_mode: str,
    template_snippets: List[str],
    presets: Dict[str, List[str]],
    artifact_todos: str,
    session_context: str,
    energy_tone: str,
) -> str:
    created_at = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
    source_file = event.get("source_file", "(unknown)")
    capability = event.get("capability", "stt_stub")
    markdown_path = event.get("markdown_path")
    summary_line = (
        f"Watcher event `{event_id}` processed `{source_file}` using `{capability}`."
    )

    body = f"""---
title: "{title}"
description: "Seeded from watcher event {event_id}"
created_at: {datetime.now().date()}
privacy_mode: {privacy_mode}
---

# MO Journal Entry #moj-{number:04d} [{code}]: {title}

**Date**: {created_at}  
**Session Context**: {session_context}  
**Privacy Mode**: {privacy_mode}  
**Energy / Emotional Tone**: {energy_tone}

---

## Observation

- {summary_line}
- Markdown artifact: `{markdown_path}`
- Capability tier: `{event.get("capability_tier", "unknown")}` with privacy `{event.get("privacy_mode", "n/a")}`.

## Context

- Trigger: Latest watcher run referenced by this event.
- Environment: Repo root CLI, `python -m projects.echo_forge.watcher.watcher --once`.
- Notes: Replace this block with richer context describing what you were testing or validating.

## AI Reflection (optional)

> Add EnaC notes here. Capture risks, opportunities, or divergence signals discovered during the run.

## Insight

- Summarize why this watcher run mattered and what you learned.

## Action Items

### Immediate (This Session)

{format_checklist(presets.get("immediate", []))}

{"\n".join(template_snippets).strip()}

### Short-Term

{format_checklist(presets.get("short", []))}

### Long-Term / Research

{format_checklist(presets.get("long", []))}

{artifact_todos}

## Related Artifacts

- Capture: `{markdown_path}`
- System entry: `mo_journal/system/watcher_events.jsonl → {event_id}`
- Capability profile: `{capability}`

## Share Intent (optional)

- Collaboration targets: 
- Notes: 
"""
    return textwrap.dedent(body)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Seed an MO journal draft from watcher telemetry"
    )
    parser.add_argument(
        "--log", type=Path, default=DEFAULT_LOG, help="Path to watcher JSONL log"
    )
    parser.add_argument(
        "--drafts-dir",
        type=Path,
        default=DEFAULT_DRAFTS,
        help="Directory where drafts should be created",
    )
    parser.add_argument(
        "--entries-dir",
        type=Path,
        default=DEFAULT_ENTRIES,
        help="Directory to scan for existing entry numbers",
    )
    parser.add_argument(
        "--code", default="Diag", help="Short code (FutFeat, Diag, Meta, etc.)"
    )
    parser.add_argument(
        "--title", default=DEFAULT_TEMPLATE_TITLE, help="Working title for the entry"
    )
    parser.add_argument(
        "--privacy-mode",
        default="metadata-only",
        choices=["metadata-only", "partial", "full"],
        help="Initial privacy setting",
    )
    parser.add_argument(
        "--action-template",
        action="append",
        choices=sorted(SNIPPET_LIBRARY.keys()),
        help="Optional action snippet to inject (triage, collab, automation, …)",
    )
    parser.add_argument(
        "--context-preset",
        choices=sorted(CONTEXT_PRESETS.keys()),
        help="Session context + energy pair to prefill metadata",
    )
    parser.add_argument(
        "--session-context",
        help="Manual override for the Session Context line",
    )
    parser.add_argument(
        "--energy-tone",
        help="Manual override for the Energy / Emotional Tone line",
    )
    parser.add_argument(
        "--event-id",
        help="Optional event id to search for. Defaults to the latest entry in the log.",
    )
    args = parser.parse_args()

    log_path = args.log
    event, latest_event_id = read_latest_event(log_path)

    if args.event_id and args.event_id != latest_event_id:
        # Naive search through log for requested event id
        with log_path.open("r", encoding="utf-8") as handle:
            found = None
            for line in handle:
                stripped = line.strip()
                if not stripped:
                    continue
                data = json.loads(stripped)
                if data.get("event_id") == args.event_id:
                    found = data
            if not found:
                raise ValueError(f"Event id {args.event_id} not found in {log_path}")
            event = found
            latest_event_id = args.event_id

    next_number = next_entry_number(args.drafts_dir, args.entries_dir)
    slug = slugify(args.title)
    filename = f"moj-{next_number:04d}-{args.code}-{slug}.md"
    output_path = args.drafts_dir / filename
    output_path.parent.mkdir(parents=True, exist_ok=True)

    snippet_ids = args.action_template or []
    snippets = ["\n" + s for key in snippet_ids for s in SNIPPET_LIBRARY.get(key, [])]
    presets = CODE_PRESETS.get(args.code, CODE_PRESETS.get("Diag", {}))
    artifact_todos = artifact_notes(event)

    context_defaults = {
        "session": DEFAULT_SESSION_CONTEXT,
        "energy": DEFAULT_ENERGY_TONE,
    }
    if args.context_preset:
        context_defaults.update(CONTEXT_PRESETS.get(args.context_preset, {}))
    if args.session_context:
        context_defaults["session"] = args.session_context
    if args.energy_tone:
        context_defaults["energy"] = args.energy_tone

    content = build_entry_content(
        number=next_number,
        code=args.code,
        title=args.title,
        event=event,
        event_id=latest_event_id,
        privacy_mode=args.privacy_mode,
        template_snippets=snippets,
        presets=presets,
        artifact_todos=artifact_todos,
        session_context=context_defaults["session"],
        energy_tone=context_defaults["energy"],
    )
    output_path.write_text(content, encoding="utf-8")
    print(f"Draft created: {output_path}")


if __name__ == "__main__":
    main()
