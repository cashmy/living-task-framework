"""Async storage adapter implementation for GlossRP."""

from __future__ import annotations

from collections.abc import Sequence
from uuid import UUID

from sqlalchemy import delete, func, select, text
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from glossrp.db.models import (
    SCSBlock,
    Term,
    TermCategory,
    TermCategoryAssignment,
    TermEmbedding,
    TermMetadata,
    TermStatus,
    TermVersion,
    TermVersionStatus,
)
from glossrp.storage.dto import (
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


class StorageAdapter:
    """Encapsulates persistence operations for GlossRP."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def healthcheck(self) -> bool:
        """Simple query to verify DB connectivity."""

        await self._session.execute(text("SELECT 1"))
        return True

    async def upsert_term_bundle(
        self,
        term: TermPayload,
        version: TermVersionPayload,
        *,
        metadata_entries: Sequence[MetadataEntryPayload] | None = None,
        embeddings: Sequence[EmbeddingPayload] | None = None,
        scs_blocks: Sequence[SCSBlockPayload] | None = None,
    ) -> TermVersion:
        """Insert or update a term and its version payload in one transaction."""

        db_term = await self._ensure_term(term)
        term_version = await self._upsert_term_version(db_term.term_id, version)

        await self._replace_metadata(term_version.term_version_id, metadata_entries or [])
        await self._replace_embeddings(term_version.term_version_id, embeddings or [])
        await self._replace_scs_blocks(term_version.term_version_id, scs_blocks or [])
        return term_version

    async def get_raw_category_occurrences(self) -> list[RawCategoryOccurrence]:
        """Return aggregated counts for each raw category label."""

        sql = text(
            """
            SELECT LOWER(rc.raw_category) AS label, COUNT(*) AS occurrences
            FROM term_versions tv
            JOIN LATERAL unnest(tv.raw_categories) AS rc(raw_category) ON TRUE
            WHERE tv.raw_categories IS NOT NULL
            GROUP BY LOWER(rc.raw_category)
            ORDER BY occurrences DESC, label ASC
            """
        )
        rows = await self._session.execute(sql)
        return [
            RawCategoryOccurrence(label=row["label"], occurrences=row["occurrences"])
            for row in rows.mappings()
        ]

    async def get_terms_with_raw_category(self, label: str) -> list[TermVersionRawCategoryView]:
        """Return TermVersions containing the provided raw category label."""

        sql = text(
            """
            SELECT tv.term_version_id,
                   tv.term_id,
                   t.primary_name,
                   tv.version,
                   tv.raw_categories
            FROM term_versions tv
            JOIN terms t ON t.term_id = tv.term_id
            WHERE tv.raw_categories IS NOT NULL
              AND EXISTS (
                  SELECT 1
                  FROM unnest(tv.raw_categories) AS rc(raw_category)
                  WHERE LOWER(rc.raw_category) = :label
              )
            ORDER BY t.primary_name ASC, tv.version DESC
            """
        )
        rows = await self._session.execute(sql, {"label": label.strip().lower()})
        return [
            TermVersionRawCategoryView(
                term_version_id=row["term_version_id"],
                term_id=row["term_id"],
                primary_name=row["primary_name"],
                version=row["version"],
                raw_categories=row["raw_categories"],
            )
            for row in rows.mappings()
        ]

    async def create_category(self, payload: CategoryPayload) -> TermCategory:
        """Create a canonical category if it does not already exist."""

        normalized_name = payload.name.strip()
        stmt = select(TermCategory).where(func.lower(TermCategory.name) == normalized_name.lower())
        existing = await self._session.scalar(stmt)
        if existing:
            return existing

        category = TermCategory(
            name=normalized_name,
            description=payload.description,
            status=payload.status,
        )
        self._session.add(category)
        await self._session.flush()
        return category

    async def assign_category(
        self, term_version_id: UUID, category_id: UUID
    ) -> TermCategoryAssignment:
        """Assign a canonical category to a TermVersion (idempotent)."""

        assignment = await self._session.get(TermCategoryAssignment, (term_version_id, category_id))
        if assignment:
            return assignment

        assignment = TermCategoryAssignment(
            term_version_id=term_version_id,
            category_id=category_id,
        )
        self._session.add(assignment)
        await self._session.flush()
        return assignment

    async def get_term_record(
        self,
        *,
        term_id: str,
        version: str | None = None,
        include_metadata: bool = False,
        include_embeddings: bool = False,
        include_scs_blocks: bool = False,
    ) -> TermRecord | None:
        """Fetch a single term record with optional relational data."""

        stmt = select(TermVersion).join(Term).where(Term.term_id == term_id)
        if version:
            stmt = stmt.where(TermVersion.version == version)
        else:
            stmt = stmt.where(TermVersion.status == TermVersionStatus.current)
        stmt = stmt.limit(1)

        records = await self._load_term_versions(
            stmt,
            include_metadata=include_metadata,
            include_embeddings=include_embeddings,
            include_scs_blocks=include_scs_blocks,
        )
        return records[0] if records else None

    async def list_current_term_records(
        self,
        *,
        include_metadata: bool = False,
        include_embeddings: bool = False,
        include_scs_blocks: bool = False,
    ) -> list[TermRecord]:
        """Return all active/current term records for glossaries."""

        stmt = (
            select(TermVersion)
            .join(Term)
            .where(
                TermVersion.status == TermVersionStatus.current,
                Term.status == TermStatus.active,
            )
            .order_by(Term.primary_name.asc(), TermVersion.version.desc())
        )
        return await self._load_term_versions(
            stmt,
            include_metadata=include_metadata,
            include_embeddings=include_embeddings,
            include_scs_blocks=include_scs_blocks,
        )

    async def list_term_records_by_categories(
        self,
        category_names: Sequence[str],
        *,
        status: TermVersionStatus | None = None,
        include_metadata: bool = False,
        include_embeddings: bool = False,
        include_scs_blocks: bool = False,
    ) -> list[TermRecord]:
        """List term records limited to canonical categories (case-insensitive)."""

        normalized = [name.strip().lower() for name in category_names if name and name.strip()]
        if not normalized:
            return []

        stmt = (
            select(TermVersion)
            .distinct(TermVersion.term_version_id)
            .join(Term)
            .join(TermCategoryAssignment)
            .join(TermCategory)
            .where(func.lower(TermCategory.name).in_(normalized))
            .order_by(Term.primary_name.asc())
        )
        if status:
            stmt = stmt.where(TermVersion.status == status)
        else:
            stmt = stmt.where(TermVersion.status == TermVersionStatus.current)

        return await self._load_term_versions(
            stmt,
            include_metadata=include_metadata,
            include_embeddings=include_embeddings,
            include_scs_blocks=include_scs_blocks,
        )

    async def _ensure_term(self, payload: TermPayload) -> Term:
        term = await self._session.get(Term, payload.term_id)
        if term is None:
            term = Term(
                term_id=payload.term_id,
                primary_name=payload.primary_name,
                acronym=payload.acronym,
                domain=payload.domain,
                status=payload.status,
            )
            self._session.add(term)
        else:
            term.primary_name = payload.primary_name
            term.acronym = payload.acronym
            term.domain = payload.domain
            term.status = payload.status
        await self._session.flush()
        return term

    async def _upsert_term_version(self, term_id: str, payload: TermVersionPayload) -> TermVersion:
        stmt = select(TermVersion).where(
            TermVersion.term_id == term_id,
            TermVersion.version == payload.version,
        )
        term_version = await self._session.scalar(stmt)
        normalized_categories = _normalize_raw_categories(payload.raw_categories)

        if term_version is None:
            term_version = TermVersion(
                term_id=term_id,
                version=payload.version,
                summary_human=payload.summary_human,
                summary_architecture=payload.summary_architecture,
                status=payload.status,
                source_file_path=payload.source_file_path,
                raw_markdown=payload.raw_markdown,
                raw_categories=normalized_categories,
            )
            self._session.add(term_version)
        else:
            term_version.summary_human = payload.summary_human
            term_version.summary_architecture = payload.summary_architecture
            term_version.status = payload.status
            term_version.source_file_path = payload.source_file_path
            term_version.raw_markdown = payload.raw_markdown
            term_version.raw_categories = normalized_categories

        await self._session.flush()
        return term_version

    async def _replace_metadata(
        self, term_version_id: UUID, entries: Sequence[MetadataEntryPayload]
    ) -> None:
        await self._session.execute(
            delete(TermMetadata).where(TermMetadata.term_version_id == term_version_id)
        )
        if not entries:
            return

        records = [
            TermMetadata(
                term_version_id=term_version_id,
                key=entry.key,
                value=dict(entry.value),
            )
            for entry in entries
        ]
        self._session.add_all(records)
        await self._session.flush()

    async def _replace_embeddings(
        self, term_version_id: UUID, embeddings: Sequence[EmbeddingPayload]
    ) -> None:
        await self._session.execute(
            delete(TermEmbedding).where(TermEmbedding.term_version_id == term_version_id)
        )
        if not embeddings:
            return

        records = [
            TermEmbedding(
                term_version_id=term_version_id,
                embedding=list(payload.embedding),
                model_name=payload.model_name,
                purpose=payload.purpose,
            )
            for payload in embeddings
        ]
        self._session.add_all(records)
        await self._session.flush()

    async def _replace_scs_blocks(
        self, term_version_id: UUID, blocks: Sequence[SCSBlockPayload]
    ) -> None:
        await self._session.execute(
            delete(SCSBlock).where(SCSBlock.term_version_id == term_version_id)
        )
        if not blocks:
            return

        records = [
            SCSBlock(
                term_version_id=term_version_id,
                tier=block.tier,
                block_type=block.block_type,
                content=block.content,
                metadata_payload=dict(block.metadata_payload) if block.metadata_payload else None,
                is_active=block.is_active,
            )
            for block in blocks
        ]
        self._session.add_all(records)
        await self._session.flush()

    async def _load_term_versions(
        self,
        stmt,
        *,
        include_metadata: bool,
        include_embeddings: bool,
        include_scs_blocks: bool,
    ) -> list[TermRecord]:
        stmt = stmt.options(
            *self._term_version_options(
                include_metadata=include_metadata,
                include_embeddings=include_embeddings,
                include_scs_blocks=include_scs_blocks,
            )
        )
        result = await self._session.scalars(stmt)
        term_versions = result.all()
        return [
            self._serialize_term_record(
                tv,
                include_metadata=include_metadata,
                include_embeddings=include_embeddings,
                include_scs_blocks=include_scs_blocks,
            )
            for tv in term_versions
        ]

    def _term_version_options(
        self,
        *,
        include_metadata: bool,
        include_embeddings: bool,
        include_scs_blocks: bool,
    ) -> list:
        options = [
            selectinload(TermVersion.term),
            selectinload(TermVersion.categories).selectinload(TermCategoryAssignment.category),
        ]
        if include_metadata:
            options.append(selectinload(TermVersion.metadata_entries))
        if include_embeddings:
            options.append(selectinload(TermVersion.embeddings))
        if include_scs_blocks:
            options.append(selectinload(TermVersion.scs_blocks))
        return options

    def _serialize_term_record(
        self,
        term_version: TermVersion,
        *,
        include_metadata: bool,
        include_embeddings: bool,
        include_scs_blocks: bool,
    ) -> TermRecord:
        term = term_version.term
        canonical_categories = [
            CanonicalCategoryView(
                category_id=assignment.category.category_id,
                name=assignment.category.name,
                status=assignment.category.status,
            )
            for assignment in term_version.categories
            if assignment.category is not None
        ]

        metadata_entries = (
            [
                MetadataEntryView(
                    key=entry.key,
                    value=dict(entry.value),
                )
                for entry in term_version.metadata_entries
            ]
            if include_metadata
            else []
        )

        embeddings = (
            [
                EmbeddingView(
                    embedding_id=embedding.embedding_id,
                    model_name=embedding.model_name,
                    purpose=embedding.purpose,
                    embedding=list(embedding.embedding),
                )
                for embedding in term_version.embeddings
            ]
            if include_embeddings
            else []
        )

        scs_blocks = (
            [
                SCSBlockView(
                    tier=block.tier,
                    block_type=block.block_type,
                    content=block.content,
                    metadata_payload=dict(block.metadata_payload)
                    if block.metadata_payload is not None
                    else None,
                    is_active=block.is_active,
                )
                for block in term_version.scs_blocks
            ]
            if include_scs_blocks
            else []
        )

        version_record = TermVersionRecord(
            term_version_id=term_version.term_version_id,
            version=term_version.version,
            status=term_version.status,
            summary_human=term_version.summary_human,
            summary_architecture=term_version.summary_architecture,
            source_file_path=term_version.source_file_path,
            raw_categories=list(term_version.raw_categories)
            if term_version.raw_categories
            else None,
            canonical_categories=canonical_categories,
            metadata=metadata_entries,
            embeddings=embeddings,
            scs_blocks=scs_blocks,
        )

        return TermRecord(
            term_id=term.term_id,
            primary_name=term.primary_name,
            acronym=term.acronym,
            domain=term.domain,
            status=term.status,
            version=version_record,
        )


def _normalize_raw_categories(categories: Sequence[str | None] | None) -> list[str] | None:
    if not categories:
        return None

    normalized = [label.strip() for label in categories if label and label.strip()]
    return normalized or None
