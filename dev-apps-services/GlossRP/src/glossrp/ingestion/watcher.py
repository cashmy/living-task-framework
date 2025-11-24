"""Filesystem watcher for TermSpec ingestion."""

from __future__ import annotations

import argparse
import asyncio
import logging
from collections.abc import Iterable
from pathlib import Path

from watchfiles import Change, awatch

from glossrp.config import get_settings
from glossrp.db.session import get_session
from glossrp.ingestion.service import IngestionService
from glossrp.storage import StorageAdapter

LOGGER = logging.getLogger("glossrp.ingestion.watcher")


async def watch_termspecs(directory: Path) -> None:
    """Watch a directory for TermSpec changes and ingest updates."""

    directory = directory.expanduser().resolve()
    if not directory.exists():
        raise FileNotFoundError(f"TermSpec directory does not exist: {directory}")

    LOGGER.info("Watching TermSpec directory: %s", directory)
    async for changes in awatch(directory, recursive=True):
        targets = _filter_termspec_changes(changes)
        if not targets:
            continue
        for path in targets:
            await _ingest_path(path)


async def ingest_once(path: Path) -> None:
    """Manual override to ingest a specific TermSpec file once."""

    await _ingest_path(path.expanduser().resolve())


async def bootstrap_directory(directory: Path) -> None:
    """Ingest every TermSpec in the directory exactly once."""

    directory = directory.expanduser().resolve()
    targets = sorted(p for p in directory.rglob("*.md") if p.is_file())
    for path in targets:
        await _ingest_path(path)


async def _ingest_path(path: Path) -> None:
    LOGGER.info("Ingesting TermSpec: %s", path)
    async with get_session() as session:
        adapter = StorageAdapter(session)
        service = IngestionService(adapter, logger=LOGGER)
        await service.ingest_termspec(path)
        await session.commit()


def _filter_termspec_changes(changes: Iterable[tuple[Change, str]]) -> list[Path]:
    paths: list[Path] = []
    for change, raw_path in changes:
        if change not in {Change.added, Change.modified}:
            continue
        path = Path(raw_path)
        if path.suffix.lower() == ".md":
            paths.append(path)
    return paths


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="GlossRP TermSpec watcher")
    parser.add_argument(
        "--watch",
        action="store_true",
        help="Start the filesystem watcher using TERMSPEC_DIRECTORY",
    )
    parser.add_argument(
        "--replay",
        type=Path,
        help="Ingest a single TermSpec file and exit",
    )
    parser.add_argument(
        "--bootstrap",
        action="store_true",
        help="Ingest every TermSpec in the configured directory once",
    )
    return parser.parse_args()


async def _dispatch_from_cli(args: argparse.Namespace) -> None:
    settings = get_settings()
    directory = settings.termspec_directory

    if args.replay:
        await ingest_once(args.replay)
        return

    if args.bootstrap:
        await bootstrap_directory(directory)

    if args.watch or (not args.replay and not args.bootstrap):
        await watch_termspecs(directory)


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="[%(levelname)s] %(name)s: %(message)s")
    args = _parse_args()
    asyncio.run(_dispatch_from_cli(args))


if __name__ == "__main__":
    main()
