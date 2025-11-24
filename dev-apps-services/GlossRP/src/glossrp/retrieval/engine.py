"""Deterministic retrieval engine implementation."""

from __future__ import annotations

from collections import defaultdict
from typing import Any, Sequence

from glossrp.storage import (
    RawCategoryOccurrence,
    StorageAdapter,
    TermRecord,
    TermVersionRawCategoryView,
)

UNCATEGORIZED_LABEL = "uncategorized"


class RetrievalError(RuntimeError):
    """Base class for retrieval failures."""


class TermNotFoundError(RetrievalError):
    """Raised when a requested term cannot be found."""


class RetrievalEngine:
    """Implements canonical and raw-category retrieval behaviors."""

    def __init__(self, storage: StorageAdapter) -> None:
        self._storage = storage

    async def single_term(
        self,
        term_id: str,
        *,
        version: str | None = None,
        include_metadata: bool = False,
        include_embeddings: bool = False,
        include_scs_blocks: bool = False,
    ) -> dict[str, Any]:
        """Return a consolidated view of a single term."""

        record = await self._storage.get_term_record(
            term_id=term_id,
            version=version,
            include_metadata=include_metadata,
            include_embeddings=include_embeddings,
            include_scs_blocks=include_scs_blocks,
        )
        if record is None:
            raise TermNotFoundError(term_id)

        return _serialize_term_record(
            record,
            include_metadata=include_metadata,
            include_embeddings=include_embeddings,
            include_scs_blocks=include_scs_blocks,
        )

    async def human_glossary_flat(self) -> list[dict[str, Any]]:
        """Return a flat, alphabetized glossary of active/current terms."""

        records = await self._storage.list_current_term_records()
        entries = [_summarize_term_record(record) for record in records]
        entries.sort(key=lambda entry: entry["primary_name"].lower())
        return entries

    async def human_glossary_grouped(self) -> list[dict[str, Any]]:
        """Return a glossary grouped by canonical categories."""

        records = await self._storage.list_current_term_records()
        return _group_terms_by_category(records)

    async def ai_glossary_listing(
        self, *, include_raw_categories: bool = False
    ) -> list[dict[str, Any]]:
        """Return an AI-friendly glossary listing with optional raw labels."""

        records = await self._storage.list_current_term_records(include_metadata=True)
        listing: list[dict[str, Any]] = []
        for record in records:
            metadata = [{"key": meta.key, "value": meta.value} for meta in record.version.metadata]
            entry = {
                "term_id": record.term_id,
                "primary_name": record.primary_name,
                "acronym": record.acronym,
                "domain": record.domain,
                "version": record.version.version,
                "summary_human": record.version.summary_human,
                "summary_architecture": record.version.summary_architecture,
                "canonical_categories": [
                    category.name for category in record.version.canonical_categories
                ],
                "metadata": metadata,
            }
            if include_raw_categories:
                entry["raw_categories"] = record.version.raw_categories or []
            listing.append(entry)
        return listing

    async def canonical_terms_by_categories(
        self, category_names: Sequence[str]
    ) -> list[dict[str, Any]]:
        """Return canonical retrieval scoped to the provided categories."""

        records = await self._storage.list_term_records_by_categories(category_names)
        return [_summarize_term_record(record) for record in records]

    async def raw_category_occurrences(self) -> list[dict[str, Any]]:
        """Return frequency counts for each raw category label."""

        occurrences = await self._storage.get_raw_category_occurrences()
        return [_serialize_raw_category_occurrence(item) for item in occurrences]

    async def terms_with_raw_category(self, label: str) -> list[dict[str, Any]]:
        """Return TermVersions that reference the provided raw category label."""

        rows = await self._storage.get_terms_with_raw_category(label)
        return [_serialize_raw_category_term(row) for row in rows]


def _serialize_term_record(
    record: TermRecord,
    *,
    include_metadata: bool,
    include_embeddings: bool,
    include_scs_blocks: bool,
) -> dict[str, Any]:
    version = record.version
    payload: dict[str, Any] = {
        "term_id": record.term_id,
        "primary_name": record.primary_name,
        "acronym": record.acronym,
        "domain": record.domain,
        "status": record.status.value,
        "version": {
            "term_version_id": version.term_version_id,
            "version": version.version,
            "status": version.status.value,
            "summary_human": version.summary_human,
            "summary_architecture": version.summary_architecture,
            "source_file_path": version.source_file_path,
            "raw_categories": version.raw_categories,
            "canonical_categories": [
                {
                    "category_id": category.category_id,
                    "name": category.name,
                    "status": category.status.value,
                }
                for category in version.canonical_categories
            ],
        },
    }

    if include_metadata:
        payload["version"]["metadata"] = [
            {"key": entry.key, "value": entry.value} for entry in version.metadata
        ]
    if include_embeddings:
        payload["version"]["embeddings"] = [
            {
                "embedding_id": embedding.embedding_id,
                "model_name": embedding.model_name,
                "purpose": embedding.purpose.value,
                "embedding": embedding.embedding,
            }
            for embedding in version.embeddings
        ]
    if include_scs_blocks:
        payload["version"]["scs_blocks"] = [
            {
                "tier": block.tier,
                "block_type": block.block_type,
                "content": block.content,
                "metadata_payload": block.metadata_payload,
                "is_active": block.is_active,
            }
            for block in version.scs_blocks
        ]

    return payload


def _summarize_term_record(record: TermRecord) -> dict[str, Any]:
    return {
        "term_id": record.term_id,
        "primary_name": record.primary_name,
        "acronym": record.acronym,
        "domain": record.domain,
        "summary_human": record.version.summary_human,
        "canonical_categories": [category.name for category in record.version.canonical_categories],
    }


def _group_terms_by_category(records: Sequence[TermRecord]) -> list[dict[str, Any]]:
    buckets: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for record in records:
        entry = _summarize_term_record(record)
        names = entry["canonical_categories"]
        if not names:
            buckets[UNCATEGORIZED_LABEL].append(entry)
            continue
        for name in names:
            buckets[name].append(entry)

    ordered_categories = sorted(
        buckets.keys(),
        key=lambda name: (name == UNCATEGORIZED_LABEL, name.lower()),
    )
    grouped: list[dict[str, Any]] = []
    for category in ordered_categories:
        terms = buckets[category]
        terms.sort(key=lambda entry: entry["primary_name"].lower())
        grouped.append({"category": category, "terms": terms})
    return grouped


def _serialize_raw_category_occurrence(item: RawCategoryOccurrence) -> dict[str, Any]:
    return {"label": item.label, "occurrences": item.occurrences}


def _serialize_raw_category_term(row: TermVersionRawCategoryView) -> dict[str, Any]:
    return {
        "term_version_id": row.term_version_id,
        "term_id": row.term_id,
        "primary_name": row.primary_name,
        "version": row.version,
        "raw_categories": row.raw_categories,
    }
