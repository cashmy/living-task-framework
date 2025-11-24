"""SQLAlchemy models aligned with GlossRP Logical Data Model v2.2."""

from __future__ import annotations

import enum
import uuid
from datetime import datetime

from sqlalchemy import (
    ARRAY,
    Boolean,
    DateTime,
    Enum,
    ForeignKey,
    Index,
    String,
    Text,
    UniqueConstraint,
    text,
)
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from pgvector.sqlalchemy import Vector


class Base(DeclarativeBase):
    """Declarative base supplying metadata for Alembic."""


class TermStatus(enum.Enum):
    active = "active"
    deprecated = "deprecated"
    experimental = "experimental"


class TermVersionStatus(enum.Enum):
    current = "current"
    superseded = "superseded"
    archived = "archived"


class CategoryStatus(enum.Enum):
    active = "active"
    pending = "pending"
    deprecated = "deprecated"


class EmbeddingPurpose(enum.Enum):
    general = "general"
    retrieval = "retrieval"
    definition = "definition"
    relationship_hint = "relationship-hint"
    other = "other"


class Term(Base):
    __tablename__ = "terms"

    term_id: Mapped[str] = mapped_column(String(128), primary_key=True)
    primary_name: Mapped[str] = mapped_column(String(256), nullable=False)
    acronym: Mapped[str | None] = mapped_column(String(64))
    domain: Mapped[str] = mapped_column(String(128), nullable=False)
    status: Mapped[TermStatus] = mapped_column(
        Enum(TermStatus, name="term_status_enum"), nullable=False, default=TermStatus.active
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"), nullable=False
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=text("CURRENT_TIMESTAMP"),
        server_onupdate=text("CURRENT_TIMESTAMP"),
        nullable=False,
    )

    versions: Mapped[list[TermVersion]] = relationship(
        back_populates="term", cascade="all, delete-orphan"
    )


class TermVersion(Base):
    __tablename__ = "term_versions"
    __table_args__ = (
        UniqueConstraint("term_id", "version", name="uq_term_version"),
        Index("ix_term_versions_raw_categories", "raw_categories", postgresql_using="gin"),
    )

    term_version_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    term_id: Mapped[str] = mapped_column(
        String(128), ForeignKey("terms.term_id", ondelete="CASCADE"), nullable=False
    )
    version: Mapped[str] = mapped_column(String(32), nullable=False)
    summary_human: Mapped[str] = mapped_column(Text, nullable=False)
    summary_architecture: Mapped[str] = mapped_column(Text, nullable=False)
    status: Mapped[TermVersionStatus] = mapped_column(
        Enum(TermVersionStatus, name="term_version_status_enum"),
        nullable=False,
        default=TermVersionStatus.current,
    )
    source_file_path: Mapped[str] = mapped_column(String(512), nullable=False)
    raw_markdown: Mapped[str | None] = mapped_column(Text)
    raw_categories: Mapped[list[str] | None] = mapped_column(ARRAY(Text))
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"), nullable=False
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=text("CURRENT_TIMESTAMP"),
        server_onupdate=text("CURRENT_TIMESTAMP"),
        nullable=False,
    )

    term: Mapped[Term] = relationship(back_populates="versions")
    embeddings: Mapped[list[TermEmbedding]] = relationship(
        back_populates="term_version", cascade="all, delete-orphan"
    )
    metadata_entries: Mapped[list[TermMetadata]] = relationship(
        back_populates="term_version", cascade="all, delete-orphan"
    )
    categories: Mapped[list[TermCategoryAssignment]] = relationship(
        back_populates="term_version", cascade="all, delete-orphan"
    )
    scs_blocks: Mapped[list[SCSBlock]] = relationship(
        back_populates="term_version", cascade="all, delete-orphan"
    )


class TermEmbedding(Base):
    __tablename__ = "term_embeddings"

    embedding_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    term_version_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
        nullable=False,
    )
    embedding: Mapped[list[float]] = mapped_column(Vector())
    model_name: Mapped[str] = mapped_column(String(128), nullable=False)
    purpose: Mapped[EmbeddingPurpose] = mapped_column(
        Enum(EmbeddingPurpose, name="embedding_purpose_enum"),
        nullable=False,
        default=EmbeddingPurpose.general,
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"), nullable=False
    )

    term_version: Mapped[TermVersion] = relationship(back_populates="embeddings")


class TermCategory(Base):
    __tablename__ = "term_categories"

    category_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    name: Mapped[str] = mapped_column(String(128), unique=True, nullable=False)
    description: Mapped[str | None] = mapped_column(Text)
    status: Mapped[CategoryStatus] = mapped_column(
        Enum(CategoryStatus, name="category_status_enum"),
        nullable=False,
        default=CategoryStatus.pending,
    )

    assignments: Mapped[list[TermCategoryAssignment]] = relationship(
        back_populates="category", cascade="all, delete-orphan"
    )


class TermCategoryAssignment(Base):
    __tablename__ = "term_category_assignments"

    term_version_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
        primary_key=True,
    )
    category_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("term_categories.category_id", ondelete="CASCADE"),
        primary_key=True,
    )

    term_version: Mapped[TermVersion] = relationship(back_populates="categories")
    category: Mapped[TermCategory] = relationship(back_populates="assignments")


class TermMetadata(Base):
    __tablename__ = "term_metadata"
    __table_args__ = (UniqueConstraint("term_version_id", "key", name="uq_term_metadata_key"),)

    metadata_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    term_version_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
        nullable=False,
    )
    key: Mapped[str] = mapped_column(String(128), nullable=False)
    value: Mapped[dict] = mapped_column(JSONB, nullable=False)

    term_version: Mapped[TermVersion] = relationship(back_populates="metadata_entries")


class SCSBlock(Base):
    __tablename__ = "scs_blocks"
    __table_args__ = (
        UniqueConstraint("term_version_id", "tier", "block_type", name="uq_scs_block"),
    )

    scs_block_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    term_version_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
        nullable=False,
    )
    tier: Mapped[str] = mapped_column(String(8), nullable=False)
    block_type: Mapped[str] = mapped_column(String(64), nullable=False)
    content: Mapped[str] = mapped_column(Text, nullable=False)
    metadata_payload: Mapped[dict | None] = mapped_column(JSONB)
    is_active: Mapped[bool] = mapped_column(Boolean, nullable=False, default=True)

    term_version: Mapped[TermVersion] = relationship(back_populates="scs_blocks")
