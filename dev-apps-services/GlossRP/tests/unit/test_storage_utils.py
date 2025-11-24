"""Unit tests for small helpers inside the storage adapter."""

import pytest

from glossrp.storage.adapter import _normalize_raw_categories


@pytest.mark.parametrize(
    "raw,expected",
    [
        (None, None),
        ([], None),
        (["", "  "], None),
        (["Framework", "  Tool  "], ["Framework", "Tool"]),
        (["One", None, "Two"], ["One", "Two"]),
    ],
)
def test_normalize_raw_categories(raw, expected):
    assert _normalize_raw_categories(raw) == expected
