# EchoForge EntryStore Schema v1.0

Date: 2025-11-19  

This document defines the initial **PostgreSQL schema** for the EchoForge EntryStore, aligned with:

- EchoForge Platform Spec  
- EchoForge Subsystem & Pipeline Specs  
- Decision 002 — EntryStore Migration (JSONL → PostgreSQL, dual-mode)  

JSONL remains the **canonical append-only ledger**; PostgreSQL provides the **operational query layer** for UI/API and analytics.

---

## 1. Core Design

- **JSONL**: append-only log, replayable, highly portable, ideal for watcher v1.
- **PostgreSQL**: structured, indexed, transactional, ideal for:
  - querying Entries  
  - filtering + pagination  
  - joining classifications  
  - backing FastAPI/other UI clients  

The goal is to:

- preserve JSONL as long-term ground truth  
- let PostgreSQL evolve independently as the operational store  
- support a dual-mode strategy during transition and beyond.

---

## 2. Enumerated Types

PostgreSQL `ENUM`s constrain core fields while remaining extensible.

```sql
CREATE TYPE entry_source_type AS ENUM ('audio', 'text', 'document');

CREATE TYPE entry_status AS ENUM ('ingested', 'normalized', 'failed');
```

You can later extend these with:

```sql
ALTER TYPE entry_source_type ADD VALUE 'other';
ALTER TYPE entry_status ADD VALUE 'archived';
```

---

## 3. `entries` Table

The `entries` table is the **operational view** of each Entry that EchoForge processes.

```sql
CREATE TABLE entries (
    id              UUID PRIMARY KEY,
    source_type     entry_source_type NOT NULL,
    source_path     TEXT NOT NULL,          -- original file path or logical identifier
    verbatim_path   TEXT NOT NULL,          -- path/URI to normalized/verbatim artifact
    ingest_ts       TIMESTAMPTZ NOT NULL DEFAULT now(),  -- when watcher first saw it
    normalized_ts   TIMESTAMPTZ,            -- when normalization completed (if applicable)
    status          entry_status NOT NULL,
    error_message   TEXT,                   -- last known error state, if status = 'failed'

    raw_metadata    JSONB,                  -- optional: size, mime, STT provider, etc.
    checksum        TEXT,                   -- optional: hash for idempotence and dedupe

    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

### Recommended Indexes

```sql
CREATE INDEX idx_entries_status
    ON entries (status);

CREATE INDEX idx_entries_ingest_ts
    ON entries ( ingest_ts DESC );

CREATE INDEX idx_entries_source_type
    ON entries (source_type);
```

These support common operations:

- list recent Entries  
- filter by status  
- filter by source type (audio/text/document)  

---

## 4. `classification_labels` Table

The `classification_labels` table stores the **master classification vocabulary** used to tag Entries.

```sql
CREATE TABLE classification_labels (
    id          SERIAL PRIMARY KEY,
    key         TEXT UNIQUE NOT NULL,   -- stable key (e.g. 'idea', 'todo', 'product-concept')
    name        TEXT NOT NULL,          -- human-readable label (e.g. 'Idea', 'To-Do')
    category    TEXT,                   -- optional grouping (e.g. 'writing', 'product', 'architecture')
    description TEXT,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,

    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

This table is:

- safe to extend as the classification system evolves  
- suitable for both human-curated and AI-suggested labels  
- a natural home for SCS-generated label keys.

---

## 5. `entry_classifications` Table

`entry_classifications` is the **link table** between `entries` and `classification_labels`.

It supports:

- many-to-many relationships  
- multiple labeling sources (human, SCS, other models)  
- optional confidence scores  

```sql
CREATE TABLE entry_classifications (
    entry_id    UUID NOT NULL REFERENCES entries(id) ON DELETE CASCADE,
    label_id    INTEGER NOT NULL REFERENCES classification_labels(id),
    confidence  REAL,                     -- 0.0–1.0, optional
    source      TEXT,                     -- e.g. 'human', 'SCS-v1', 'import'
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),

    PRIMARY KEY (entry_id, label_id, source)
);
```

### Recommended Indexes

```sql
CREATE INDEX idx_entry_classifications_entry_id
    ON entry_classifications (entry_id);

CREATE INDEX idx_entry_classifications_label_id
    ON entry_classifications (label_id);
```

These support:

- fetching all labels for an Entry  
- finding all Entries with a given label  
- analytics over classification usage.

---

## 6. Dual-Mode Behavior (JSONL + PostgreSQL)

Under the **dual-mode strategy** from Decision 002:

- JSONL remains the **canonical ledger**:
  - watcher writes each Entry to JSONL first  
  - JSONL is never retroactively edited in normal operation  

- PostgreSQL is the **operational view**:
  - a sync pathway (or immediate mirror) writes `entries` rows  
  - `entry_classifications` rows are added/updated as SCS or humans tag Entries  
  - UI/API access PostgreSQL exclusively for reads  

A typical write-path:

1. Watcher ingests source → creates Entry model.  
2. Append Entry to JSONL (`entries.jsonl`).  
3. Insert or upsert into `entries` table.  
4. When classifications exist, insert into `entry_classifications`.  

Later, you may evolve toward:

- PostgreSQL as primary operational store  
- JSONL as archival or replay artifact  
- or a hybrid event-sourced model.

---

## 7. Example Migration Script (v1 Initial)

Below is a **single migration script** you could adapt into Alembic:

```sql
-- 001_initial_entries_schema.sql

BEGIN;

CREATE TYPE entry_source_type AS ENUM ('audio', 'text', 'document');
CREATE TYPE entry_status AS ENUM ('ingested', 'normalized', 'failed');

CREATE TABLE entries (
    id              UUID PRIMARY KEY,
    source_type     entry_source_type NOT NULL,
    source_path     TEXT NOT NULL,
    verbatim_path   TEXT NOT NULL,
    ingest_ts       TIMESTAMPTZ NOT NULL DEFAULT now(),
    normalized_ts   TIMESTAMPTZ,
    status          entry_status NOT NULL,
    error_message   TEXT,
    raw_metadata    JSONB,
    checksum        TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_entries_status
    ON entries (status);

CREATE INDEX idx_entries_ingest_ts
    ON entries (ingest_ts DESC);

CREATE INDEX idx_entries_source_type
    ON entries (source_type);

CREATE TABLE classification_labels (
    id          SERIAL PRIMARY KEY,
    key         TEXT UNIQUE NOT NULL,
    name        TEXT NOT NULL,
    category    TEXT,
    description TEXT,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE entry_classifications (
    entry_id    UUID NOT NULL REFERENCES entries(id) ON DELETE CASCADE,
    label_id    INTEGER NOT NULL REFERENCES classification_labels(id),
    confidence  REAL,
    source      TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (entry_id, label_id, source)
);

CREATE INDEX idx_entry_classifications_entry_id
    ON entry_classifications (entry_id);

CREATE INDEX idx_entry_classifications_label_id
    ON entry_classifications (label_id);

COMMIT;
```

---

## 8. Next Steps

Implementation-layer tasks (for Milestone 03 and beyond):

1. Define ORM models (e.g., SQLModel/SQLAlchemy) matching this schema.  
2. Wire an `EntryStore` abstraction that:
   - writes first to JSONL  
   - mirrors to PostgreSQL  
   - reads from PostgreSQL for queries  

3. Integrate migrations via Alembic.  
4. Extend the schema incrementally as EchoForge’s needs evolve (e.g. adding:
   - `projects`,  
   - `sources`,  
   - `tags`,  
   - or `sessions`).  

---

End of `EchoForge_EntryStore_Schema_v1.0.md`.
