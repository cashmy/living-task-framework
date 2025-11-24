"""Initial GlossRP schema.

Revision ID: 20241123_000001
Revises:
Create Date: 2025-11-23
"""

from __future__ import annotations

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql
from pgvector.sqlalchemy import Vector

# revision identifiers, used by Alembic.
revision = "20241123_000001"
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    term_status_enum = sa.Enum("active", "deprecated", "experimental", name="term_status_enum")
    term_version_status_enum = sa.Enum(
        "current", "superseded", "archived", name="term_version_status_enum"
    )
    category_status_enum = sa.Enum("active", "pending", "deprecated", name="category_status_enum")
    embedding_purpose_enum = sa.Enum(
        "general",
        "retrieval",
        "definition",
        "relationship-hint",
        "other",
        name="embedding_purpose_enum",
    )

    op.create_table(
        "terms",
        sa.Column("term_id", sa.String(length=128), primary_key=True),
        sa.Column("primary_name", sa.String(length=256), nullable=False),
        sa.Column("acronym", sa.String(length=64)),
        sa.Column("domain", sa.String(length=128), nullable=False),
        sa.Column("status", term_status_enum, nullable=False, server_default="active"),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
        ),
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
            server_onupdate=sa.text("CURRENT_TIMESTAMP"),
        ),
    )

    op.create_table(
        "term_versions",
        sa.Column(
            "term_version_id",
            postgresql.UUID(as_uuid=True),
            primary_key=True,
            server_default=sa.text("gen_random_uuid()"),
        ),
        sa.Column(
            "term_id",
            sa.String(length=128),
            sa.ForeignKey("terms.term_id", ondelete="CASCADE"),
            nullable=False,
        ),
        sa.Column("version", sa.String(length=32), nullable=False),
        sa.Column("summary_human", sa.Text(), nullable=False),
        sa.Column("summary_architecture", sa.Text(), nullable=False),
        sa.Column("status", term_version_status_enum, nullable=False, server_default="current"),
        sa.Column("source_file_path", sa.String(length=512), nullable=False),
        sa.Column("raw_markdown", sa.Text()),
        sa.Column("raw_categories", postgresql.ARRAY(sa.Text())),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
        ),
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
            server_onupdate=sa.text("CURRENT_TIMESTAMP"),
        ),
        sa.UniqueConstraint("term_id", "version", name="uq_term_version"),
    )
    op.create_index(
        "ix_term_versions_raw_categories",
        "term_versions",
        ["raw_categories"],
        unique=False,
        postgresql_using="gin",
    )

    op.create_table(
        "term_categories",
        sa.Column(
            "category_id",
            postgresql.UUID(as_uuid=True),
            primary_key=True,
            server_default=sa.text("gen_random_uuid()"),
        ),
        sa.Column("name", sa.String(length=128), nullable=False, unique=True),
        sa.Column("description", sa.Text()),
        sa.Column("status", category_status_enum, nullable=False, server_default="pending"),
    )

    op.create_table(
        "term_embeddings",
        sa.Column(
            "embedding_id",
            postgresql.UUID(as_uuid=True),
            primary_key=True,
            server_default=sa.text("gen_random_uuid()"),
        ),
        sa.Column(
            "term_version_id",
            postgresql.UUID(as_uuid=True),
            sa.ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
            nullable=False,
        ),
        sa.Column("embedding", Vector()),
        sa.Column("model_name", sa.String(length=128), nullable=False),
        sa.Column("purpose", embedding_purpose_enum, nullable=False, server_default="general"),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
        ),
    )

    op.create_table(
        "term_metadata",
        sa.Column(
            "metadata_id",
            postgresql.UUID(as_uuid=True),
            primary_key=True,
            server_default=sa.text("gen_random_uuid()"),
        ),
        sa.Column(
            "term_version_id",
            postgresql.UUID(as_uuid=True),
            sa.ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
            nullable=False,
        ),
        sa.Column("key", sa.String(length=128), nullable=False),
        sa.Column("value", postgresql.JSONB(), nullable=False),
        sa.UniqueConstraint("term_version_id", "key", name="uq_term_metadata_key"),
    )

    op.create_table(
        "term_category_assignments",
        sa.Column(
            "term_version_id",
            postgresql.UUID(as_uuid=True),
            sa.ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
            primary_key=True,
        ),
        sa.Column(
            "category_id",
            postgresql.UUID(as_uuid=True),
            sa.ForeignKey("term_categories.category_id", ondelete="CASCADE"),
            primary_key=True,
        ),
    )

    op.create_table(
        "scs_blocks",
        sa.Column(
            "scs_block_id",
            postgresql.UUID(as_uuid=True),
            primary_key=True,
            server_default=sa.text("gen_random_uuid()"),
        ),
        sa.Column(
            "term_version_id",
            postgresql.UUID(as_uuid=True),
            sa.ForeignKey("term_versions.term_version_id", ondelete="CASCADE"),
            nullable=False,
        ),
        sa.Column("tier", sa.String(length=8), nullable=False),
        sa.Column("block_type", sa.String(length=64), nullable=False),
        sa.Column("content", sa.Text(), nullable=False),
        sa.Column("metadata_payload", postgresql.JSONB()),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default=sa.text("TRUE")),
        sa.UniqueConstraint("term_version_id", "tier", "block_type", name="uq_scs_block"),
    )


def downgrade() -> None:
    op.drop_table("scs_blocks")
    op.drop_table("term_category_assignments")
    op.drop_table("term_metadata")
    op.drop_table("term_embeddings")
    op.drop_table("term_categories")
    op.drop_index("ix_term_versions_raw_categories", table_name="term_versions")
    op.drop_table("term_versions")
    op.drop_table("terms")

    sa.Enum(name="embedding_purpose_enum").drop(op.get_bind(), checkfirst=True)
    sa.Enum(name="category_status_enum").drop(op.get_bind(), checkfirst=True)
    sa.Enum(name="term_version_status_enum").drop(op.get_bind(), checkfirst=True)
    sa.Enum(name="term_status_enum").drop(op.get_bind(), checkfirst=True)
