"""Unit tests for retrieval engine behaviors."""

from __future__ import annotations

from collections.abc import Sequence
from unittest.mock import AsyncMock
from uuid import uuid4

import pytest

from glossrp.db.models import (
    CategoryStatus,
    EmbeddingPurpose,
    TermStatus,
    TermVersionStatus,
)
from glossrp.retrieval.engine import RetrievalEngine, TermNotFoundError
from glossrp.storage import (
    CanonicalCategoryView,
    EmbeddingView,
    MetadataEntryView,
    RawCategoryOccurrence,
    SCSBlockView,
    StorageAdapter,
    TermRecord,
    TermVersionRawCategoryView,
    TermVersionRecord,
)


@pytest.mark.asyncio
async def test_single_term_serializes_full_payload() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    record = _make_term_record(
        canonical_categories=[
            CanonicalCategoryView(
                category_id=uuid4(),
                name="Framework",
                status=CategoryStatus.active,
            )
        ],
        metadata=[MetadataEntryView(key="source", value={"author": "ops"})],
        embeddings=[
            EmbeddingView(
                embedding_id=uuid4(),
                model_name="text-unit-test",
                purpose=EmbeddingPurpose.general,
                embedding=[0.1, 0.2, 0.3],
            )
        ],
        scs_blocks=[
            SCSBlockView(
                tier="t1",
                block_type="definition",
                content="line",
                metadata_payload={"priority": 1},
                is_active=True,
            )
        ],
        raw_categories=["framework", "reference"],
    )
    storage.get_term_record.return_value = record

    engine = RetrievalEngine(storage)
    result = await engine.single_term(
        "TERM-1",
        include_metadata=True,
        include_embeddings=True,
        include_scs_blocks=True,
    )

    storage.get_term_record.assert_awaited_with(
        term_id="TERM-1",
        version=None,
        include_metadata=True,
        include_embeddings=True,
        include_scs_blocks=True,
    )
    assert result["term_id"] == "TERM-1"
    assert result["version"]["canonical_categories"][0]["name"] == "Framework"
    assert result["version"]["metadata"][0]["value"] == {"author": "ops"}
    assert result["version"]["embeddings"][0]["purpose"] == EmbeddingPurpose.general.value
    assert result["version"]["scs_blocks"][0]["metadata_payload"] == {"priority": 1}
    assert result["version"]["raw_categories"] == ["framework", "reference"]


@pytest.mark.asyncio
async def test_single_term_missing_raises() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    storage.get_term_record.return_value = None
    engine = RetrievalEngine(storage)

    with pytest.raises(TermNotFoundError):
        await engine.single_term("missing")


@pytest.mark.asyncio
async def test_human_glossary_flat_sorted() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    beta = _make_term_record(term_id="B", primary_name="Beta")
    alpha = _make_term_record(term_id="A", primary_name="Alpha")
    storage.list_current_term_records.return_value = [beta, alpha]

    engine = RetrievalEngine(storage)
    result = await engine.human_glossary_flat()

    assert [entry["primary_name"] for entry in result] == ["Alpha", "Beta"]


@pytest.mark.asyncio
async def test_human_glossary_grouped_handles_uncategorized() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    categorized = _make_term_record(
        primary_name="Categorized",
        canonical_categories=[
            CanonicalCategoryView(category_id=uuid4(), name="Ops", status=CategoryStatus.active)
        ],
    )
    uncategorized = _make_term_record(primary_name="Unknown", canonical_categories=[])
    storage.list_current_term_records.return_value = [categorized, uncategorized]

    engine = RetrievalEngine(storage)
    result = await engine.human_glossary_grouped()

    assert result[0]["category"] == "Ops"
    assert result[0]["terms"][0]["primary_name"] == "Categorized"
    assert result[1]["category"] == "uncategorized"
    assert result[1]["terms"][0]["primary_name"] == "Unknown"


@pytest.mark.asyncio
async def test_ai_glossary_listing_includes_raw_categories() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    record = _make_term_record(
        metadata=[MetadataEntryView(key="key", value={"value": "v"})],
        raw_categories=["framework"],
    )
    storage.list_current_term_records.return_value = [record]

    engine = RetrievalEngine(storage)
    result = await engine.ai_glossary_listing(include_raw_categories=True)

    assert result[0]["metadata"] == [{"key": "key", "value": {"value": "v"}}]
    assert result[0]["raw_categories"] == ["framework"]


@pytest.mark.asyncio
async def test_canonical_terms_by_categories_summarizes_records() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    record = _make_term_record(primary_name="Alpha")
    storage.list_term_records_by_categories.return_value = [record]

    engine = RetrievalEngine(storage)
    result = await engine.canonical_terms_by_categories(["Ops"])

    storage.list_term_records_by_categories.assert_awaited_with(["Ops"])
    assert result == [
        {
            "term_id": record.term_id,
            "primary_name": "Alpha",
            "acronym": record.acronym,
            "domain": record.domain,
            "summary_human": record.version.summary_human,
            "canonical_categories": [
                category.name for category in record.version.canonical_categories
            ],
        }
    ]


@pytest.mark.asyncio
async def test_raw_category_occurrences_serializes_counts() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    storage.get_raw_category_occurrences.return_value = [
        RawCategoryOccurrence(label="framework", occurrences=5)
    ]

    engine = RetrievalEngine(storage)
    result = await engine.raw_category_occurrences()

    assert result == [{"label": "framework", "occurrences": 5}]


@pytest.mark.asyncio
async def test_terms_with_raw_category_serializes_rows() -> None:
    storage = AsyncMock(spec=StorageAdapter)
    row = TermVersionRawCategoryView(
        term_version_id=uuid4(),
        term_id="TERM",
        primary_name="Alpha",
        version="v1",
        raw_categories=["framework"],
    )
    storage.get_terms_with_raw_category.return_value = [row]

    engine = RetrievalEngine(storage)
    result = await engine.terms_with_raw_category("framework")

    storage.get_terms_with_raw_category.assert_awaited_with("framework")
    assert result == [
        {
            "term_version_id": row.term_version_id,
            "term_id": "TERM",
            "primary_name": "Alpha",
            "version": "v1",
            "raw_categories": ["framework"],
        }
    ]


def _make_term_record(
    *,
    term_id: str = "TERM-1",
    primary_name: str = "Alpha",
    acronym: str | None = "ALP",
    domain: str = "Core",
    status: TermStatus = TermStatus.active,
    canonical_categories: Sequence[CanonicalCategoryView] | None = None,
    metadata: Sequence[MetadataEntryView] | None = None,
    embeddings: Sequence[EmbeddingView] | None = None,
    scs_blocks: Sequence[SCSBlockView] | None = None,
    raw_categories: Sequence[str] | None = None,
) -> TermRecord:
    canonical = list(canonical_categories or [])
    metadata_entries = list(metadata or [])
    embedding_entries = list(embeddings or [])
    scs_entries = list(scs_blocks or [])

    version_record = TermVersionRecord(
        term_version_id=uuid4(),
        version="v1",
        status=TermVersionStatus.current,
        summary_human="Human summary",
        summary_architecture="Architecture summary",
        source_file_path="termspecs/alpha.md",
        raw_categories=list(raw_categories) if raw_categories is not None else None,
        canonical_categories=canonical,
        metadata=metadata_entries,
        embeddings=embedding_entries,
        scs_blocks=scs_entries,
    )
    return TermRecord(
        term_id=term_id,
        primary_name=primary_name,
        acronym=acronym,
        domain=domain,
        status=status,
        version=version_record,
    )
