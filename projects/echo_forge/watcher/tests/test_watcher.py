from pathlib import Path
import sys
import importlib
import json

PACKAGE_ROOT = Path(__file__).resolve().parents[1]
PROJECT_ROOT = PACKAGE_ROOT.parent
if str(PROJECT_ROOT) not in sys.path:
    sys.path.append(str(PROJECT_ROOT))

watcher_core = importlib.import_module("watcher.watcher_core")
is_file_stable = watcher_core.is_file_stable
process_file = watcher_core.process_file
journal_logger_mod = importlib.import_module("watcher.journal_logger")
JournalLogger = journal_logger_mod.JournalLogger


def test_is_file_stable(tmp_path: Path):
    f = tmp_path / "t.txt"
    f.write_text("hello")
    assert is_file_stable(f, checks=1, interval=0.01)


def test_process_file_once(tmp_path: Path):
    inbox = tmp_path / "inbox"
    processed = tmp_path / "processed"
    failed = tmp_path / "failed"
    inbox.mkdir()
    p = inbox / "sample.mp3"
    p.write_text("audiocontent")
    res = process_file(p, processed, failed)
    assert res["status"] == "ok"
    assert (processed / "originals" / "sample.mp3").exists()
    assert "metadata" in res
    assert res["metadata"]["stt_engine"] == "stt_stub"
    assert res.get("transcript_preview") is not None
    assert any(str(x).endswith(".md") for x in processed.iterdir())


def test_journal_logger_writes_event(tmp_path: Path):
    log_path = tmp_path / "watcher_events.jsonl"
    logger = JournalLogger(
        log_path,
        {"log_level": "info", "event_frequency": "normal"},
    )
    payload = {
        "type": "watcher_ingest",
        "status": "ok",
        "source_file": "sample",
    }
    logger.log_event(payload)
    data = log_path.read_text(encoding="utf-8").strip().splitlines()
    assert len(data) == 1
    event = json.loads(data[0])
    assert event["status"] == "ok"
    assert event["event_id"].startswith("wev-")
