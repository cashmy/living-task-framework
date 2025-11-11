# LTF Context Tools - Usage Guide

To create a snapshot of the current state of the repository, follow these steps:

## Where Files Are Created

* *Understanding the file structure**:

| File Type | Location | Example |
|-----------|----------|---------|
| **Context Snapshots** | `context-snapshots/YYYY-MM-DD_HHMMSS-*/` | `context-snapshots/2025-11-10_151722-pivotal-ltf-cfp-validated-need-expansion-v2/` |
| **Pivotal Moments** | `reflections/pivotal-moments/` | `reflections/pivotal-moments/2025-11-10-cfp-validated-need-and-expansion.md` |
| **Session Buffers** | `temp/session-buffers/` | `temp/session-buffers/session-2025-11-10_151722.yaml` |

* *Folder Structure**:

```text
@living-task-framework/
├── context-snapshots/          # Snapshot packages (upload to new AI)
│   └── 2025-11-10_HHMMSS-*/
│       ├── transfer-prompt.md
│       ├── session-state.yaml
│       └── RESUME_README.md
│
├── reflections/
│   └── pivotal-moments/        # Detailed pivotal moment documents
│       └── 2025-11-10-*.md
│
└── temp/
    └── session-buffers/        # Temporary moment detection buffers
        └── session-*.yaml
```

* *What goes where**:
* **Snapshots** (`context-snapshots/`): Reference packages for AI handoff
* **Pivotal Moments** (`reflections/`): Detailed markdown documents with full context
* **Buffers** (`temp/`): Temporary storage for moment detection (before finalizing)

- --

## Create a Context Snapshot

### PowerShell (Windows, Mac, Linux)

```pwsh
pwsh tools/context/Save-LTFContext-v2.ps1 -Type resume -Label "my-checkpoint"

# or with notes

pwsh tools/context/Save-LTFContext-v2.ps1 -Type pivotal -Label "feature-x" -Notes "Stability snapshot before switching chats"
```

## Bash (Mac, Linux, WSL)

```bash
bash tools/context/save-ltf-context.sh -type resume -label "my-checkpoint"

# or with notes

bash tools/context/save-ltf-context.sh -type pivotal -label "feature-x" -notes "Stability snapshot before switching chats"
```

## Resume from a Snapshot

### PowerShell

```pwsh
pwsh tools/context/Resume-LTF.ps1 -Project my-project -Type resume -Latest

# or specify a label

pwsh tools/context/Resume-LTF.ps1 -Project my-project -Type resume -Label "feature-x"
```

## Bash

```bash
bash tools/context/resume-ltf.sh -project my-project -type resume -latest

# or specify a label

bash tools/context/resume-ltf.sh -project my-project -type resume -label "feature-x"
```

## Output

The snapshot creates a directory with:

- `transfer-prompt.md` — paste its contents into a fresh AI chat
- `session-state.yaml` — session metadata and implementation status
- `RESUME_README.md` — handoff instructions (for RESUME snapshots)
- `.ltf-influencers.yaml` — manifest snapshot (for RESUME snapshots)

📖 **For comprehensive documentation**, see `CLI_GUIDE.md` in this directory.
