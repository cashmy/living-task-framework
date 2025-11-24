"""Tests for TermSpec parser."""

from pathlib import Path

from glossrp.ingestion.termspec import parse_termspec

SAMPLE_SPEC = """---
term_id: ECL
primary_name: Evolutionary Context Layering
acronym: ECL
version: v2.0
status: Active
domain: Framework
raw_categories:
  - Layer
  - Alignment
summary_human: Human summary
summary_architecture: Architecture summary
---
# 5. Structural Components
- SKY Layer
- CORE Layer
- BASE Layer

```SCS_T1
ECL anchors SKY/CORE/BASE coordination.
```
"""


def test_parse_termspec_extracts_core_fields(tmp_path: Path) -> None:
    file_path = tmp_path / "ECL.md"
    file_path.write_text(SAMPLE_SPEC, encoding="utf-8")

    record = parse_termspec(SAMPLE_SPEC, file_path)

    assert record.term_id == "ECL"
    assert record.primary_name == "Evolutionary Context Layering"
    assert record.acronym == "ECL"
    assert record.version == "v2.0"
    assert record.domain == "Framework"
    assert record.raw_categories == ["Layer", "Alignment"]
    assert len(record.scs_blocks) == 1


def test_parse_termspec_infers_term_id_from_filename(tmp_path: Path) -> None:
    file_path = tmp_path / "fallback_entry.md"
    file_path.write_text("# Missing metadata", encoding="utf-8")

    record = parse_termspec("# Missing metadata", file_path)

    assert record.term_id == "FALLBACK_ENTRY"
    assert record.primary_name == "Missing metadata"
