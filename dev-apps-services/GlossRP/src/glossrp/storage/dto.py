"""Data transfer objects for storage adapter operations."""

from __future__ import annotations

from collections.abc import Mapping, Sequence
from dataclasses import dataclass
from typing import Any
from uuid import UUID

from glossrp.db.models import (
    CategoryStatus,
    EmbeddingPurpose,
    TermStatus,
    TermVersionStatus,
)


@dataclass(slots=True)
class TermPayload:
    """Input structure for inserting or updating Term rows."""

    term_id: str
    primary_name: str
    domain: str
    acronym: str | None = None
    status: TermStatus = TermStatus.active


@dataclass(slots=True)
class TermVersionPayload:
    """Input structure for inserting or updating TermVersion rows."""

    version: str
    summary_human: str
    summary_architecture: str
    source_file_path: str
    status: TermVersionStatus = TermVersionStatus.current
    raw_markdown: str | None = None
    raw_categories: Sequence[str | None] | None = None


@dataclass(slots=True)
class MetadataEntryPayload:
    """Metadata key/value pairs captured from a TermSpec."""

    key: str
    value: Mapping[str, Any]


@dataclass(slots=True)
class EmbeddingPayload:
    """Embedding vector information for a TermVersion."""

    embedding: Sequence[float]
    model_name: str
    purpose: EmbeddingPurpose = EmbeddingPurpose.general


@dataclass(slots=True)
class SCSBlockPayload:
    """Semantic Compiler Slice payload extracted from TermSpecs."""

    tier: str
    block_type: str
    content: str
    metadata_payload: Mapping[str, Any] | None = None
    is_active: bool = True


@dataclass(slots=True)
class RawCategoryOccurrence:
    """Occurrence counts for each raw category label."""

    label: str
    occurrences: int


@dataclass(slots=True)
class TermVersionRawCategoryView:
    """Lightweight view for TermVersions tagged with a raw category label."""

    term_version_id: UUID
    term_id: str
    primary_name: str
    version: str
    raw_categories: list[str] | None = None


@dataclass(slots=True)
class CategoryPayload:
    """Inputs for creating canonical categories."""

    name: str
    description: str | None = None
    status: CategoryStatus = CategoryStatus.pending


@dataclass(slots=True)
class CanonicalCategoryView:
    """Canonical category details for retrieval responses."""

    category_id: UUID
    name: str
    status: CategoryStatus


@dataclass(slots=True)
class MetadataEntryView:
    """Metadata entry included in retrieval responses."""

    key: str
    value: dict[str, Any]


@dataclass(slots=True)
class SCSBlockView:
    """Semantic Compiler Slice representation for retrieval responses."""

    tier: str
    block_type: str
    content: str
    metadata_payload: dict[str, Any] | None
    is_active: bool


@dataclass(slots=True)
class EmbeddingView:
    """Embedding representation for retrieval responses."""

    embedding_id: UUID
    model_name: str
    purpose: EmbeddingPurpose
    embedding: list[float]


@dataclass(slots=True)
class TermVersionRecord:
    """Aggregated TermVersion data for retrieval."""

    term_version_id: UUID
    version: str
    status: TermVersionStatus
    summary_human: str
    summary_architecture: str
    source_file_path: str
    raw_categories: list[str] | None
    canonical_categories: list[CanonicalCategoryView]
    metadata: list[MetadataEntryView]
    embeddings: list[EmbeddingView]
    scs_blocks: list[SCSBlockView]


@dataclass(slots=True)
class TermRecord:
    """Aggregated Term + TermVersion data for retrieval."""

    term_id: str
    primary_name: str
    acronym: str | None
    domain: str
    status: TermStatus
    version: TermVersionRecord


__all__ = [
    "CategoryPayload",
    "CanonicalCategoryView",
    "EmbeddingPayload",
    "EmbeddingView",
    "MetadataEntryPayload",
    "MetadataEntryView",
    "RawCategoryOccurrence",
    "SCSBlockPayload",
    "SCSBlockView",
    "TermPayload",
    "TermRecord",
    "TermVersionPayload",
    "TermVersionRecord",
    "TermVersionRawCategoryView",
]
