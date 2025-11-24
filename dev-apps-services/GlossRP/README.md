# GlossRP Service Scaffold

This scaffold bootstraps the Glossary Retrieval Protocol (GlossRP) microservice in alignment with the v2.2 architecture docs. It targets a single-runtime Python stack and keeps deterministic ECL-BASE responsibilities front and center.

## Stack Overview

- **Runtime:** Python 3.11.x (pinned via `.python-version`)
- **REST API:** FastAPI + Uvicorn
- **gRPC API:** grpcio (async via `grpc.aio`)
- **ORM / DB Access:** SQLAlchemy 2.x with asyncpg
- **Vector Support:** pgvector extension via `pgvector`
- **Dependency Management:** pip + `requirements.txt` (Poetry optional post-M10)
- **Formatting & Linting:** Ruff + black-compatible settings
- **Testing:** Pytest + HTTPX test client + grpc.aio test utilities

## Supported Platforms

GlossRP must run across contributor environments and future deployment targets. We currently validate
the stack on the following operating systems and recommend sticking to one of them when developing:

- **Windows 11 (x64):** native PowerShell scripts plus watcher CLI are exercised here daily.
- **macOS 14 Sonoma (ARM/Intel):** standard POSIX shell flow (`source .venv/bin/activate`).
- **Ubuntu 22.04 LTS:** baseline for CI / containerized deployments.

Nothing in the codebase is OS-specific, so other Linux distributions (and, later, mobile/web shells)
should work provided Python 3.11.9 and PostgreSQL with `pgvector` are available. Using the `uv` lockfile
described below is the quickest way to ensure parity across these environments.

## Python Runtime & Virtual Environment

GlossRP intentionally targets a single interpreter version so determinism is easy to maintain. The
`.python-version` file pins **3.11.9** for any pyenv-style launcher, and all commands below assume that
runtime. Create an isolated environment before installing dependencies:

```powershell
py -3.11 -m venv .venv
.\.venv\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

(On non-Windows systems, swap the activation command for `source .venv/bin/activate`.)

### Using `uv` for reproducible installs

For deterministic dependency resolution across Windows/macOS/Linux, run:

```bash
uv sync --frozen
```

This creates/updates `.venv/` and installs exactly what `uv.lock` specifies. It is the preferred path
for CI and new contributors, though `pip install -r requirements.txt` remains available when `uv`
is not installed yet.

## Project Layout

```
├─ protos/                  # gRPC service definitions (source of truth)
├─ scripts/                 # Local orchestration helpers (run, lint, etc.)
├─ src/glossrp/
│  ├─ api/
│  │  ├─ rest/             # FastAPI application + routers
│  │  └─ grpc/             # gRPC server wiring (generated stubs imported here)
│  ├─ config/              # Settings, environment loading, logging config
│  ├─ db/                  # Async session factory, migrations hooks
│  ├─ ingestion/           # TermSpec ingestion orchestration
│  ├─ retrieval/           # Deterministic retrieval engine
│  ├─ schemas/             # Pydantic models + DTOs
│  └─ __init__.py
├─ tests/                  # Pytest suites (unit, integration later)
└─ pyproject.toml          # Dependencies + scripts
```

The tools suite (Glossary Exporter / Category Curation) will live outside this root, but the APIs and storage adapters they depend on are defined here.

## Getting Started

1. **Activate the virtual environment** (see the previous section). Each shell session should begin with
   `./.venv/Scripts/activate` (PowerShell) or `source .venv/bin/activate` (bash/zsh).
2. **Install / refresh dependencies:**
   ```
   python -m pip install -r requirements.txt
   ```
3. **Run the REST API locally:**
   ```
   python -m uvicorn glossrp.api.rest.main:app --reload
   ```
4. **Run the gRPC server locally:**
   ```
   python -m glossrp.api.grpc.server
   ```
5. **Run tests:**
   ```
   python -m pytest
   ```

## TermSpec Staging Directory

- A writable folder now lives at `termspec-staging/`. Drop TermSpec `.md` files here when exercising the ingestion pipeline locally.
- The service resolves this location via the `TERMSPEC_DIRECTORY` setting (see `.env.example`). Point it at another path if you keep specs elsewhere (e.g., shared drive or cloud mount).
- Git ignores everything inside the folder except the placeholder README/`.gitkeep`, so you can iterate on private specs without polluting commits.

## TermSpec Watcher & Manual Replays

- **Watch mode:** start a background watcher that automatically ingests any new or modified TermSpec under `TERMSPEC_DIRECTORY`:
   ```
   python -m glossrp.ingestion.watcher --watch
   ```
- **Bootstrap mode:** ingest every TermSpec currently in the directory once:
   ```
   python -m glossrp.ingestion.watcher --bootstrap
   ```
- **Manual replay:** ingest a specific file without enabling the watcher:
   ```
   python -m glossrp.ingestion.watcher --replay path/to/TermSpec.md
   ```
- The watcher relies on the same `.env` + database configuration as the REST/gRPC services. Run it from an activated virtual environment so dependencies and env vars resolve correctly.

## Database Migrations (Alembic)

GlossRP uses Alembic for schema migrations. Commands are run from the project root:

```bash
# create a new migration
python -m alembic revision -m "describe change"

# apply migrations
python -m alembic upgrade head

# rollback one step
python -m alembic downgrade -1
```

The Alembic env automatically reads `.env` to discover `DATABASE_URL`. For offline SQL generation use `python -m alembic upgrade head --sql`.

## Continuous Integration

The repository includes a dedicated workflow (`.github/workflows/glossrp-ci.yml`) that runs `uv sync`
and `pytest tests/unit` on **Ubuntu**, **macOS**, and **Windows** whenever files under
`dev-apps-services/GlossRP/` change. Keep the `uv.lock` file up to date so these matrix builds remain
deterministic across operating systems.

## Next Steps

- Wire SQLAlchemy models to the logical data model v2.2
- Implement StorageAdapter methods (CRUD + pgvector helpers)
- Flesh out ingestion pipeline (TermSpec parsing, raw category capture)
- Build deterministic retrieval modes (single term, vector bundle, category)
- Expose milestone REST and gRPC endpoints per architecture docs
- Integrate config/monitoring toggles for raw category inspection and curation endpoints

This scaffold intentionally keeps implementation light so we can iterate alongside the EnaC-led design without rewriting foundational plumbing.
