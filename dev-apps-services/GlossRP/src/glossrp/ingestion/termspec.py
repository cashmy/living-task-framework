"""Utilities for parsing TermSpec markdown files."""

from __future__ import annotations

import re
from collections.abc import Mapping
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import yaml

SECTION_PATTERN = re.compile(r"^#{1,3}\s+(?P<title>.+)$", re.MULTILINE)
SCS_PATTERN = re.compile(r"```(?P<tag>SCS_T\d)\n(?P<body>.*?)```", re.DOTALL)
FRONT_MATTER_PATTERN = re.compile(r"^---\n(?P<yaml>.+?)\n---\n", re.DOTALL)
HTML_FRONT_MATTER_PATTERN = re.compile(r"^<!--\s*(?P<body>.+?)\s*-->\n", re.DOTALL)
INLINE_BOLD_PATTERN = re.compile(
    r"^\s*[-*]\s*\*\*(?P<key>[^*]+)\*\*\s*[:：]\s*(?P<value>.+)$",
    re.MULTILINE,
)
INLINE_PLAIN_PATTERN = re.compile(
    r"^\s*[-*]\s*(?P<key>[^:]+)\s*[:：]\s*(?P<value>.+)$",
    re.MULTILINE,
)
INLINE_HEADING_PATTERN = re.compile(
    r"^##\s*(?P<key>[A-Za-z0-9 .()\-]+)\s*[:：]\s*(?P<value>.+)$",
    re.MULTILINE,
)
METADATA_KEY_ALIASES = {
    "term id": "term_id",
    "term code": "term_id",
    "id": "term_id",
    "term": "primary_name",
    "primary name": "primary_name",
    "name": "primary_name",
    "long form": "primary_name",
    "acronym": "acronym",
    "short handle": "acronym",
    "version": "version",
    "status": "status",
    "domain": "domain",
    "layer": "domain",
    "classification": "domain",
    "summary": "summary_human",
    "human description": "summary_human",
    "summary human": "summary_human",
    "architecture-facing definition": "summary_architecture",
    "definition": "summary_architecture",
}
CANONICAL_METADATA_KEYS = {
    "term_id",
    "primary_name",
    "acronym",
    "version",
    "status",
    "domain",
    "summary_human",
    "summary_architecture",
}


@dataclass(slots=True)
class SCSBlock:
    """Structured representation of compiler slices."""

    tier: str
    block_type: str
    content: str


@dataclass(slots=True)
class TermSpecRecord:
    """Parsed representation of a TermSpec markdown document."""

    term_id: str
    primary_name: str
    acronym: str | None
    version: str
    status: str
    domain: str
    summary_human: str
    summary_architecture: str
    raw_categories: list[str] | None
    metadata: Mapping[str, Any]
    scs_blocks: list[SCSBlock]


class TermSpecParseError(RuntimeError):
    """Raised when a TermSpec cannot be parsed into the required fields."""


def parse_termspec(markdown: str, source_path: Path) -> TermSpecRecord:
    """Parse TermSpec markdown into a structured record."""

    fm, body = _split_front_matter(markdown)
    metadata = _coerce_metadata(fm)
    inline_metadata = _extract_inline_metadata(body)

    term_id = _first_nonempty(
        metadata.get("term_id"),
        metadata.get("id"),
        inline_metadata.get("term_id"),
        _extract_heading_term_id(body),
        _infer_term_id_from_filename(source_path),
    )
    if not term_id:
        raise TermSpecParseError(f"TermSpec {source_path} is missing a term identifier")

    primary_name = _first_nonempty(
        metadata.get("primary_name"),
        metadata.get("name"),
        inline_metadata.get("primary_name"),
        _extract_primary_name(body),
        _extract_term_heading_name(body),
        _extract_first_heading_text(body),
    )
    if not primary_name:
        raise TermSpecParseError(f"TermSpec {source_path} is missing a primary name")

    acronym = _first_nonempty(
        metadata.get("acronym"),
        metadata.get("short_code"),
        inline_metadata.get("acronym"),
    )
    version = _first_nonempty(
        metadata.get("version"),
        inline_metadata.get("version"),
        _extract_version(body),
        "v1.0",
    )
    status = _first_nonempty(metadata.get("status"), inline_metadata.get("status"), "active")
    domain = _first_nonempty(metadata.get("domain"), inline_metadata.get("domain"), "unknown")

    summary_human = _first_nonempty(
        metadata.get("summary_human"),
        inline_metadata.get("summary_human"),
        _extract_section(body, "2. Purpose"),
        _extract_section(body, "2. Definition"),
        _extract_section(body, "Human-Facing Summary"),
        _extract_first_paragraph(body),
        primary_name,
    )
    summary_architecture = _first_nonempty(
        metadata.get("summary_architecture"),
        inline_metadata.get("summary_architecture"),
        _extract_section(body, "3. Definition"),
        _extract_section(body, "Architecture-Facing Definition"),
        _extract_section(body, "Canonical Definition"),
        summary_human,
    )

    raw_categories = _collect_raw_categories(metadata, body)
    scs_blocks = _extract_scs_blocks(body)

    normalized_metadata = dict(metadata)
    normalized_metadata.setdefault("source_path", str(source_path))
    for key, value in inline_metadata.items():
        normalized_metadata.setdefault(key, value)

    return TermSpecRecord(
        term_id=term_id.strip(),
        primary_name=primary_name.strip(),
        acronym=acronym.strip() if isinstance(acronym, str) else None,
        version=version.strip(),
        status=status.strip(),
        domain=domain.strip(),
        summary_human=summary_human.strip(),
        summary_architecture=summary_architecture.strip(),
        raw_categories=raw_categories,
        metadata=normalized_metadata,
        scs_blocks=scs_blocks,
    )


def _split_front_matter(markdown: str) -> tuple[dict[str, Any], str]:
    """Return (front_matter_dict, body)."""

    if match := FRONT_MATTER_PATTERN.match(markdown):
        fm_text = match.group("yaml")
        return yaml.safe_load(fm_text) or {}, markdown[match.end() :]

    if match := HTML_FRONT_MATTER_PATTERN.match(markdown):
        faux_yaml = match.group("body")
        parsed: dict[str, Any] = {}
        for line in faux_yaml.splitlines():
            if ":" not in line:
                continue
            key, value = line.split(":", 1)
            parsed[key.strip()] = value.strip()
        return parsed, markdown[match.end() :]

    return {}, markdown


def _coerce_metadata(raw: Mapping[str, Any] | None) -> dict[str, Any]:
    if not raw:
        return {}
    result: dict[str, Any] = {}
    for key, value in raw.items():
        lower = str(key).strip().lower()
        result[lower] = value
    return result


def _extract_heading_term_id(body: str) -> str | None:
    match = re.search(r"^#\s*([A-Za-z0-9_-]+)\s*$", body, re.MULTILINE)
    if match:
        return match.group(1)
    return None


def _extract_primary_name(body: str) -> str | None:
    match = re.search(r"^#{1,2}\s*1\.\s*Term\s+Name.*?\n\*\*(?P<name>.+?)\*\*", body, re.MULTILINE)
    if match:
        return match.group("name")
    return None


def _extract_version(body: str) -> str | None:
    match = re.search(r"^##\s*Version\s*(?P<value>.+)$", body, re.MULTILINE)
    if match:
        return match.group("value").strip()
    return None


def _extract_section(body: str, heading: str) -> str | None:
    target = heading.lstrip("# ").strip()
    if not target:
        return None
    pattern = re.compile(
        rf"^#+\s*{re.escape(target)}\s*(?P<section>.*?)(?:\n#+\s|\Z)", re.MULTILINE | re.DOTALL
    )
    match = pattern.search(body)
    if not match:
        return None
    return match.group("section").strip().strip("-").strip()


def _collect_raw_categories(metadata: Mapping[str, Any], body: str) -> list[str] | None:
    if raw := metadata.get("raw_categories"):
        if isinstance(raw, str):
            values = [label.strip() for label in raw.split(",") if label.strip()]
            return values or None
        if isinstance(raw, list):
            values = [str(label).strip() for label in raw if str(label).strip()]
            return values or None

    section = _extract_section(body, "# 5. Structural Components")
    if not section:
        return None
    labels = [line.strip("- *") for line in section.splitlines() if line.strip().startswith("-")]
    cleaned = [label for label in labels if label]
    return cleaned or None


def _extract_scs_blocks(body: str) -> list[SCSBlock]:
    blocks: list[SCSBlock] = []
    for match in SCS_PATTERN.finditer(body):
        tag = match.group("tag")
        tier = tag[-2:] if tag.startswith("SCS_") else tag
        content = match.group("body").strip()
        if content:
            blocks.append(SCSBlock(tier=tier, block_type=tag, content=content))
    return blocks


def _first_nonempty(*values: Any) -> Any:
    for value in values:
        if isinstance(value, str) and value.strip():
            return value
        if value:
            return value
    return None


def _extract_inline_metadata(body: str) -> dict[str, str]:
    result: dict[str, str] = {}
    for pattern in (INLINE_BOLD_PATTERN, INLINE_PLAIN_PATTERN, INLINE_HEADING_PATTERN):
        for match in pattern.finditer(body):
            key = match.group("key").strip().lower()
            value = match.group("value").strip()
            canonical = _canonicalize_metadata_key(key)
            if canonical and value and canonical not in result:
                result[canonical] = value
    return result


def _canonicalize_metadata_key(key: str) -> str | None:
    normalized = key.strip().lower()
    if normalized in CANONICAL_METADATA_KEYS:
        return normalized
    return METADATA_KEY_ALIASES.get(normalized)


def _infer_term_id_from_filename(path: Path) -> str | None:
    stem = path.stem
    if not stem:
        return None
    if "_TermSpec" in stem:
        stem = stem.split("_TermSpec", 1)[0]
    elif "_Spec" in stem:
        stem = stem.split("_Spec", 1)[0]
    candidate = stem.strip("-_ ")
    if not candidate:
        return None
    return candidate.replace("-", "_").upper()


def _extract_term_heading_name(body: str) -> str | None:
    match = re.search(r"^##\s*Term\s*:?\s*(?P<name>.+)$", body, re.MULTILINE)
    if match:
        return match.group("name").strip()
    return None


def _extract_first_heading_text(body: str) -> str | None:
    if match := SECTION_PATTERN.search(body):
        title = match.group("title").strip()
        if "—" in title:
            title = title.split("—", 1)[0].strip()
        return title or None
    return None


def _extract_first_paragraph(body: str) -> str | None:
    for block in re.split(r"\n\s*\n", body.strip()):
        text = block.strip()
        if not text or text.startswith("#"):
            continue
        return text
    return None
