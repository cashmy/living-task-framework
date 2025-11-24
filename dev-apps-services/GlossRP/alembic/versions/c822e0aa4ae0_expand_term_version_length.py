"""Expand term version length

Revision ID: c822e0aa4ae0
Revises: 20241123_000001
Create Date: 2025-11-23 15:33:08.190243
"""

from __future__ import annotations

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = "c822e0aa4ae0"
down_revision = "20241123_000001"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.alter_column(
        "term_versions",
        "version",
        existing_type=sa.String(length=32),
        type_=sa.String(length=256),
        existing_nullable=False,
    )


def downgrade() -> None:
    op.alter_column(
        "term_versions",
        "version",
        existing_type=sa.String(length=256),
        type_=sa.String(length=32),
        existing_nullable=False,
    )
