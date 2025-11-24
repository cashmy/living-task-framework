"""Storage adapter layer."""

from .adapter import StorageAdapter
from .dto import (
    CategoryPayload,
    CanonicalCategoryView,
    EmbeddingPayload,
    EmbeddingView,
    MetadataEntryPayload,
    MetadataEntryView,
    RawCategoryOccurrence,
    SCSBlockPayload,
    SCSBlockView,
    TermPayload,
    TermRecord,
    TermVersionPayload,
    TermVersionRawCategoryView,
    TermVersionRecord,
)

__all__ = [
    "CategoryPayload",
    "CanonicalCategoryView",
    "EmbeddingPayload",
    "EmbeddingView",
    "MetadataEntryPayload",
    "MetadataEntryView",
    "RawCategoryOccurrence",
    "SCSBlockPayload",
    "StorageAdapter",
    "TermPayload",
    "TermRecord",
    "TermVersionPayload",
    "TermVersionRecord",
    "TermVersionRawCategoryView",
]
