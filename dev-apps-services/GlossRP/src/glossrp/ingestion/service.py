"""TermSpec ingestion orchestration."""

from __future__ import annotations

import logging
from pathlib import Path
from typing import Mapping

from glossrp.db.models import TermStatus, TermVersionStatus
from glossrp.ingestion.termspec import TermSpecParseError, TermSpecRecord, parse_termspec
from glossrp.storage import (
    MetadataEntryPayload,
    SCSBlockPayload,
    StorageAdapter,
    TermPayload,
    TermVersionPayload,
)


class IngestionService:
    """Coordinates TermSpec ingestion into the canonical store."""

    def __init__(self, storage: StorageAdapter, logger: logging.Logger | None = None) -> None:
        self._storage = storage
        self._logger = logger or logging.getLogger(__name__)

    async def ingest_termspec(self, path: Path) -> None:
        """Parse a TermSpec markdown file and persist it via the storage adapter."""

        content = path.read_text(encoding="utf-8")
        try:
            record = parse_termspec(content, path)
        except TermSpecParseError:
            self._logger.exception("Failed to parse TermSpec: %s", path)
            raise

        term_payload = TermPayload(
            term_id=record.term_id,
            primary_name=record.primary_name,
            acronym=record.acronym,
            domain=record.domain or "unknown",
            status=_map_term_status(record.status),
        )

        term_version_payload = TermVersionPayload(
            version=record.version,
            summary_human=record.summary_human,
            summary_architecture=record.summary_architecture,
            status=_map_term_version_status(record.status),
            source_file_path=str(path),
            raw_markdown=content,
            raw_categories=record.raw_categories,
        )

        metadata_entries = _convert_metadata(record.metadata)
        scs_payloads = [
            SCSBlockPayload(
                tier=block.tier,
                block_type=block.block_type,
                content=block.content,
            )
            for block in record.scs_blocks
        ]

        await self._storage.upsert_term_bundle(
            term_payload,
            term_version_payload,
            metadata_entries=metadata_entries,
            embeddings=None,
            scs_blocks=scs_payloads,
        )

        self._logger.info("Ingested TermSpec %s (term_id=%s)", path, record.term_id)


def _map_term_status(status: str | None) -> TermStatus:
    lookup = (status or "active").strip().lower()
    mapping = {
        "active": TermStatus.active,
        "deprecated": TermStatus.deprecated,
        "experimental": TermStatus.experimental,
    }
    return mapping.get(lookup, TermStatus.active)


def _map_term_version_status(status: str | None) -> TermVersionStatus:
    lookup = (status or "current").strip().lower()
    if lookup in {"deprecated", "archived"}:
        return TermVersionStatus.archived
    return TermVersionStatus.current


def _convert_metadata(metadata: Mapping[str, object]) -> list[MetadataEntryPayload]:
    entries: list[MetadataEntryPayload] = []
    for key, raw_value in metadata.items():
        payload = _coerce_metadata_value(raw_value)
        entries.append(MetadataEntryPayload(key=str(key), value=payload))
    return entries


def _coerce_metadata_value(value: object) -> dict[str, object]:
    if isinstance(value, Mapping):
        return dict(value)
    if isinstance(value, list):
        return {"items": value}
    return {"value": value}
