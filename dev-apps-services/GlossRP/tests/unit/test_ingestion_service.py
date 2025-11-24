"""Tests for ingestion service orchestration."""

from pathlib import Path
from unittest.mock import AsyncMock

import pytest

from glossrp.ingestion.service import IngestionService
from glossrp.storage import StorageAdapter

SPEC_CONTENT = """---
term_id: ECL
primary_name: Evolutionary Context Layering
version: v1.0
status: Active
summary_human: Human summary
summary_architecture: Architecture summary
raw_categories:
  - Framework
---
# 2. Purpose
Human summary
# 3. Definition
Architecture summary
"""


@pytest.mark.asyncio
async def test_ingestion_service_calls_storage(tmp_path: Path) -> None:
    spec_path = tmp_path / "ECL.md"
    spec_path.write_text(SPEC_CONTENT, encoding="utf-8")

    storage = AsyncMock(spec=StorageAdapter)
    service = IngestionService(storage)

    await service.ingest_termspec(spec_path)

    storage.upsert_term_bundle.assert_awaited()
