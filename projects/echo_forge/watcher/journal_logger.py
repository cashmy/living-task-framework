from __future__ import annotations

import json
import uuid
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Optional

import yaml


DEFAULT_PREFS: Dict[str, Any] = {
    "journal_storage": {
        "include_transcripts": False,
        "include_summaries": True,
        "include_ai_reflections": True,
        "retention_policy": "keep_all",
        "share_with_collaborators": False,
    },
    "privacy_defaults": {
        "default_privacy_mode": "metadata-only",
        "redact_pii_patterns": ["email", "phone"],
        "prompt_for_consent_on_share": True,
    },
    "instrumentation": {
        "allow_system_entries": True,
        "attach_system_refs_to_entries": True,
    },
}

DEFAULT_INSTRUMENTATION: Dict[str, Any] = {
    "log_level": "info",
    "event_frequency": "normal",
    "rollover_strategy": "rotate_daily",
    "max_file_size_mb": 5,
    "max_retained_files": 14,
    "emit_stack_traces": False,
}

LOG_LEVEL_ORDER = {"off": 0, "error": 1, "warn": 2, "info": 3, "debug": 4}


def _deep_merge(
    base: Dict[str, Any], override: Optional[Dict[str, Any]]
) -> Dict[str, Any]:
    if not override:
        return dict(base)
    result = dict(base)
    for key, value in override.items():
        if isinstance(value, dict) and isinstance(result.get(key), dict):
            result[key] = _deep_merge(result[key], value)
        else:
            result[key] = value
    return result


def _load_yaml(path: Path) -> Dict[str, Any]:
    if not path.exists():
        return {}
    with path.open("r", encoding="utf-8") as handle:
        data = yaml.safe_load(handle) or {}
        if not isinstance(data, dict):
            raise ValueError(f"Expected mapping in {path}, got {type(data).__name__}")
        return data


def load_journal_prefs(path: Path) -> Dict[str, Any]:
    """Load journal preference YAML, falling back to defaults."""
    try:
        user_cfg = _load_yaml(path)
    except Exception:
        user_cfg = {}
    return _deep_merge(DEFAULT_PREFS, user_cfg)


def load_instrumentation_config(path: Path) -> Dict[str, Any]:
    """Load instrumentation YAML, falling back to defaults."""
    try:
        user_cfg = _load_yaml(path)
    except Exception:
        user_cfg = {}
    return _deep_merge(DEFAULT_INSTRUMENTATION, user_cfg)


class JournalLogger:
    def __init__(
        self, log_path: Path, instrumentation: Optional[Dict[str, Any]] = None
    ):
        self.log_path = log_path
        self.instrumentation = instrumentation or dict(DEFAULT_INSTRUMENTATION)
        self.log_level = self.instrumentation.get("log_level", "info").lower()
        self.event_frequency = self.instrumentation.get(
            "event_frequency", "normal"
        ).lower()
        self.log_path.parent.mkdir(parents=True, exist_ok=True)

    def _should_log(self, level: str) -> bool:
        desired = LOG_LEVEL_ORDER.get(self.log_level, 3)
        incoming = LOG_LEVEL_ORDER.get(level.lower(), 3)
        if desired == 0:
            return False
        if incoming > desired:
            return False
        lvl = level.lower()
        if self.event_frequency == "minimal" and lvl in {"info", "debug"}:
            return False
        if self.event_frequency == "normal" and lvl == "debug":
            return False
        return True

    def log_event(self, event: Dict[str, Any], *, level: str = "info") -> None:
        if not self._should_log(level):
            return
        payload = dict(event)
        payload.setdefault("event_id", f"wev-{uuid.uuid4().hex[:12]}")
        payload.setdefault("timestamp", datetime.now(timezone.utc).isoformat())
        with self.log_path.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(payload, ensure_ascii=False))
            handle.write("\n")


def build_event_payload(
    *,
    result: Dict[str, Any],
    capability: Dict[str, Any],
    summary_snippet: Optional[str] = None,
) -> Dict[str, Any]:
    metadata = result.get("metadata") or {}
    payload = {
        "type": "watcher_ingest",
        "status": result.get("status"),
        "source_file": result.get("file") or metadata.get("source_file"),
        "markdown_path": result.get("markdown"),
        "original_path": result.get("original"),
        "capability": capability.get("name"),
        "capability_tier": capability.get("tier_ready"),
        "privacy_mode": capability.get("privacy_mode"),
        "duration_seconds": metadata.get("duration"),
        "stt_confidence": metadata.get("stt_confidence"),
        "created_at": metadata.get("created_at"),
    }
    if summary_snippet:
        payload["summary"] = summary_snippet
    if metadata.get("tags"):
        payload["tags"] = metadata.get("tags")
    if metadata.get("classification"):
        payload["classification"] = metadata.get("classification")
    return payload
