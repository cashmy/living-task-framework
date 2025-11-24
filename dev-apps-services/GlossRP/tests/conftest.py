"""Pytest configuration for GlossRP."""

from __future__ import annotations

import os
import sys
from pathlib import Path

import pytest

PROJECT_ROOT = Path(__file__).resolve().parents[1]
SRC_PATH = PROJECT_ROOT / "src"

if str(SRC_PATH) not in sys.path:
    sys.path.insert(0, str(SRC_PATH))


@pytest.fixture(autouse=True)
def _ensure_required_env(monkeypatch: pytest.MonkeyPatch) -> None:
    """Provide required environment variables for settings during tests."""

    monkeypatch.setenv(
        "DATABASE_URL",
        os.environ.get(
            "DATABASE_URL",
            "postgresql+psycopg://placeholder:placeholder@localhost:5432/glossrp",
        ),
    )
