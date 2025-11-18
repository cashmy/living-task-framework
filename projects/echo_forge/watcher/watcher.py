"""CLI entry for the watcher.

Supports a one-shot processing mode (`--once`) and a continuous mode that watches the inbox.
"""

from pathlib import Path
import argparse
import time
import logging
import sys

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

try:
    from .watcher_core import process_file
    from .capability_registry import load_registry, select_capability
    from .journal_logger import (
        JournalLogger,
        build_event_payload,
        load_instrumentation_config,
        load_journal_prefs,
    )
    from . import stt_stub

    PACKAGE_ROOT = Path(__file__).resolve().parent
except ImportError:
    if __package__ not in {None, ""}:
        raise
    PACKAGE_ROOT = Path(__file__).resolve().parent
    if str(PACKAGE_ROOT) not in sys.path:
        sys.path.insert(0, str(PACKAGE_ROOT))
    from watcher_core import process_file
    from capability_registry import load_registry, select_capability
    from journal_logger import (
        JournalLogger,
        build_event_payload,
        load_instrumentation_config,
        load_journal_prefs,
    )
    import stt_stub

PROJECT_ROOT = PACKAGE_ROOT.parent

DEFAULT_CAPABILITIES = PROJECT_ROOT / "capabilities.yaml"
DEFAULT_JOURNAL_PREFS = PROJECT_ROOT / "config" / "mo_journal_prefs.yaml"
DEFAULT_JOURNAL_INSTRUMENTATION = (
    PROJECT_ROOT / "config" / "mo_journal_instrumentation.yaml"
)
DEFAULT_JOURNAL_LOG = PROJECT_ROOT / "mo_journal" / "system" / "watcher_events.jsonl"

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")


STT_IMPLEMENTATIONS = {
    "stt_stub": stt_stub.transcribe,
    "stt_whisper_local": stt_stub.transcribe,  # placeholder until real adapter wired
    "stt_whisper_api": stt_stub.transcribe,
    "synthesis_gpt": stt_stub.transcribe,  # defensive default
    "synthesis_claude": stt_stub.transcribe,
}


def _resolve_transcriber(capability_name: str):
    return STT_IMPLEMENTATIONS.get(capability_name, stt_stub.transcribe)


def _log_result(journal_logger, journal_prefs, capability, result):
    if not journal_logger:
        return
    storage = (journal_prefs or {}).get("journal_storage", {})
    include_transcripts = storage.get("include_transcripts", False)
    summary_snippet = None
    if include_transcripts and result.get("transcript_preview"):
        summary_snippet = result.get("transcript_preview")
    payload = build_event_payload(
        result=result,
        capability=capability,
        summary_snippet=summary_snippet,
    )
    level = "info" if result.get("status") == "ok" else "warn"
    journal_logger.log_event(payload, level=level)


class NewFileHandler(FileSystemEventHandler):
    def __init__(
        self,
        processed_dir: Path,
        failed_dir: Path,
        transcriber,
        capability,
        journal_logger: JournalLogger,
        journal_prefs: dict,
    ):
        super().__init__()
        self.processed_dir = processed_dir
        self.failed_dir = failed_dir
        self.transcriber = transcriber
        self.capability = capability
        self.journal_logger = journal_logger
        self.journal_prefs = journal_prefs

    def on_created(self, event):
        if event.is_directory:
            return
        path = Path(event.src_path)
        logging.info(f"Detected new file: {path}")
        time.sleep(0.2)  # brief debounce
        res = process_file(
            path,
            self.processed_dir,
            self.failed_dir,
            transcriber=self.transcriber,
            capability=self.capability,
        )
        logging.info(f"Processed: {res}")
        _log_result(self.journal_logger, self.journal_prefs, self.capability, res)


def scan_once(
    inbox: Path,
    processed_dir: Path,
    failed_dir: Path,
    *,
    transcriber,
    capability,
    journal_logger: JournalLogger,
    journal_prefs: dict,
):
    for ext in ("*.wav", "*.mp3", "*.m4a", "*.flac"):
        for p in inbox.glob(ext):
            print("Processing", p)
            r = process_file(
                p,
                processed_dir,
                failed_dir,
                transcriber=transcriber,
                capability=capability,
            )
            print(r)
            _log_result(journal_logger, journal_prefs, capability, r)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--inbox", default="Ideas/Inbox")
    parser.add_argument("--processed-dir", default="Ideas/Processed")
    parser.add_argument("--failed-dir", default="Ideas/Failed")
    parser.add_argument("--once", action="store_true")
    parser.add_argument(
        "--capabilities-file",
        default=str(DEFAULT_CAPABILITIES),
        help="Path to capabilities.yaml (defaults to EchoForge canonical file)",
    )
    parser.add_argument(
        "--stt-policy",
        choices=["auto", "local-first", "cloud-first"],
        default="auto",
        help="Selection policy when choosing STT capability",
    )
    parser.add_argument("--max-cost", type=int, default=3)
    parser.add_argument("--max-latency", type=int, default=3)
    parser.add_argument("--require-offline", action="store_true")
    parser.add_argument(
        "--journal-prefs",
        default=str(DEFAULT_JOURNAL_PREFS),
        help="Path to MO journal preferences file",
    )
    parser.add_argument(
        "--journal-instrumentation",
        default=str(DEFAULT_JOURNAL_INSTRUMENTATION),
        help="Path to MO journal instrumentation config",
    )
    parser.add_argument(
        "--journal-log",
        default=str(DEFAULT_JOURNAL_LOG),
        help="JSONL file where watcher events are recorded",
    )
    args = parser.parse_args()

    inbox = Path(args.inbox)
    processed_dir = Path(args.processed_dir)
    failed_dir = Path(args.failed_dir)
    inbox.mkdir(parents=True, exist_ok=True)

    journal_prefs = load_journal_prefs(Path(args.journal_prefs))
    journal_instr = load_instrumentation_config(Path(args.journal_instrumentation))
    journal_logger = JournalLogger(Path(args.journal_log), journal_instr)

    registry = load_registry(Path(args.capabilities_file))
    stt_capability = select_capability(
        registry,
        "stt",
        policy=args.stt_policy,
        max_cost=args.max_cost,
        max_latency=args.max_latency,
        require_offline=args.require_offline,
    ) or {"name": "stt_stub", "privacy_mode": "local", "tier_ready": "T1"}
    transcriber = _resolve_transcriber(stt_capability.get("name", "stt_stub"))
    logging.info(
        f"Using STT capability: {stt_capability.get('name')} ({stt_capability.get('privacy_mode')})"
    )

    if args.once:
        scan_once(
            inbox,
            processed_dir,
            failed_dir,
            transcriber=transcriber,
            capability=stt_capability,
            journal_logger=journal_logger,
            journal_prefs=journal_prefs,
        )
        return

    event_handler = NewFileHandler(
        processed_dir,
        failed_dir,
        transcriber,
        stt_capability,
        journal_logger,
        journal_prefs,
    )
    observer = Observer()
    observer.schedule(event_handler, str(inbox), recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()


if __name__ == "__main__":
    main()
