#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------
# Bootstrap Living Task Framework repo (local folder with '@' prefix)
# - Creates scaffold under @living-task-framework/
# - Initializes git (if needed)
# - Adds submodules safely (removes empty target dirs first)
# - Normalizes line endings via .gitattributes
# - Optionally wires 'origin' remote if passed as arg
# Usage:
#   ./bootstrap_ltf.sh [REMOTE_URL]
# Example:
#   ./bootstrap_ltf.sh https://github.com/<org>/living-task-framework.git
# ------------------------------------------------------------------------------

LTF_DIR="@living-task-framework"
REMOTE_URL="${1:-}"  # optional

# path -> url mapping for submodules (add more as needed)
declare -A SUBMODULES=(
  ["projects/ai-thought-capture"]="https://github.com/cashmy/AI-Thought-Capture.git"
  ["projects/ehr-consent-platform"]="https://github.com/cashmy/ehr-consent-platform.git"
)

say()  { printf "\033[1;32m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[!]\033[0m %s\n" "$*"; }
err()  { printf "\033[1;31m[x]\033[0m %s\n" "$*" >&2; }

# 0) Create root folder
if [[ -d "$LTF_DIR" ]]; then
  say "Found $LTF_DIR (reusing)."
else
  mkdir -p "$LTF_DIR"
  say "Created $LTF_DIR."
fi
cd "$LTF_DIR"

# 1) Create scaffold (idempotent)
say "Creating scaffold..."
mkdir -p core/{taxonomy,architecture,.github/workflows} \
         education/workbooks \
         research/{whitepapers,studies} \
         reflections/logs \
         analytics/metrics \
         tools/{scripts,packages} \
         projects/{examples,ai-thought-capture,ehr-consent-platform,reflective-dashboard} \
         assets/{diagrams,media}

# 2) Minimal stubs (only if not present)
[[ -f README.md ]] || cat > README.md <<'MD'
# Living Task Framework (LTF)

> **Naming note:** Locally this folder is named `@living-task-framework/` for sort priority.  
> The remote GitHub repository slug should be `living-task-framework` (no `@`) for compatibility.

A modular, evidence-driven system for human–AI co-creation:
- **CIP-E**, **DMP**
- **VS Family:** VS (Verbalized Sampling), VSyn (Variable Synchronicity), VcS (Vector Co-Synthesis)
MD

[[ -f core/manifest.yaml ]] || cat > core/manifest.yaml <<'YAML'
framework:
  name: Living Task Framework
  version: 0.91
  principles: [CIP-E, DMP, VS, VSyn, VcS, Reflective Checkpoints]
  description: Unified architecture for human–AI collaboration.

modules:
  - id: ai-thought-capture
    type: app
    repo: https://github.com/cashmy/AI-Thought-Capture
    path: projects/ai-thought-capture
    depends_on: [core, analytics]
    concepts: [CIP-E, DMP, VS, VSyn]

  - id: ehr-consent-platform
    type: app
    repo: https://github.com/cashmy/ehr-consent-platform
    path: projects/ehr-consent-platform
    depends_on: [core, analytics]
    concepts: [CIP-E, DMP, VcS]

documents:
  - path: core/architecture/LTF_Concept_Map_v0.91.md
    tags: [architecture, overview]
  - path: education/DMP_Communication_Styles_Guide.md
    tags: [education, prompting]
  - path: analytics/Semantic_Linkage_Graph_Design_Note.md
    tags: [analytics, visualization]
YAML

[[ -f core/taxonomy/Glossary.md ]] || cat > core/taxonomy/Glossary.md <<'MD'
# 📘 LTF Glossary (stub)
- **VS** — Verbalized Sampling (Speak to Think)
- **VSyn** — Variable Synchronicity (Think in Time)
- **VcS** — Vector Co-Synthesis (Keep Meaning in Motion)
MD

[[ -f core/architecture/LTF_Concept_Map_v0.91.md ]] || cat > core/architecture/LTF_Concept_Map_v0.91.md <<'MD'
# 🧭 LTF Concept Map v0.91 (stub)
See `/core/taxonomy/Glossary.md` for VS/VSyn/VcS.
MD

[[ -f core/.github/workflows/lint-docs.yml ]] || cat > core/.github/workflows/lint-docs.yml <<'YML'
name: Lint Docs
on: [push, pull_request]
jobs:
  markdownlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: DavidAnson/markdownlint-cli2-action@v15
        with:
          globs: |
            **/*.md
YML

[[ -f core/.github/workflows/sync-submodules.yml ]] || cat > core/.github/workflows/sync-submodules.yml <<'YML'
name: Sync Submodules
on:
  workflow_dispatch:
  push:
    branches: [main]
jobs:
  update-submodules:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: recursive
      - name: Update submodules
        run: |
          git submodule update --init --recursive
          git submodule foreach git pull origin main || true
      - name: Commit updated submodules
        run: |
          git add .
          git -c user.name="automation" -c user.email="bot@example.com" commit -m "chore: sync submodules" || echo "no changes"
          git push || true
YML

[[ -f reflections/reflective_checkpoints.md ]] || cat > reflections/reflective_checkpoints.md <<'MD'
# 🧭 Reflective Checkpoints Log (stub)
See `/LTF/methods/LTF_Core_Principles.md` for the checkpoint practice.
MD

[[ -f tools/scripts/bootstrap.ps1 ]] || cat > tools/scripts/bootstrap.ps1 <<'PS1'
param([string]$Org = "<your-org>")
git submodule update --init --recursive
Write-Host "Submodules initialized."
PS1

[[ -f projects/examples/README.md ]] || echo "# Project Examples (stub)" > projects/examples/README.md

# 3) .gitignore (keep repo lean; protect against vendoring if submodules absent)
[[ -f .gitignore ]] || cat > .gitignore <<'GIT'
.DS_Store
Thumbs.db
*.log
*.tmp
*.swp
__pycache__/
*.pyc
.venv/
node_modules/
dist/
coverage/
sandbox/
assets/media/*
assets/diagrams/*.sketch
assets/diagrams/*.fig
# prevent accidental vendoring if submodules not yet added
projects/ai-thought-capture/*
projects/ehr-consent-platform/*
GIT

# 4) .gitattributes (normalize line endings; keep Windows scripts CRLF)
if [[ ! -f .gitattributes ]]; then
  cat > .gitattributes <<'GATTR'
* text=auto eol=lf
*.ps1 eol=crlf
*.bat eol=crlf
GATTR
fi

# 5) git init & first commit (if new)
if [[ ! -d ".git" ]]; then
  say "Initializing git repo..."
  git init
fi

# 6) Add submodules safely
for path in "${!SUBMODULES[@]}"; do
  url="${SUBMODULES[$path]}"

  # Already registered?
  if git config -f .gitmodules --get-regexp path | grep -q "^submodule\..*\.path $path$" 2>/dev/null; then
    say "Submodule already registered at $path (skipping)."
    continue
  fi

  # If target exists and is empty, remove it so git submodule can create it
  if [[ -d "$path" && -z "$(ls -A "$path" 2>/dev/null || true)" ]]; then
    rmdir "$path"
  fi

  # If path exists and is NOT empty (and not a submodule), skip to avoid nesting
  if [[ -d "$path" && ! -d "$path/.git" && -n "$(ls -A "$path" 2>/dev/null || true)" ]]; then
    warn "Directory $path is not empty; skipping submodule add to avoid nesting."
    continue
  fi

  say "Adding submodule: $url -> $path"
  git submodule add "$url" "$path" || warn "Could not add submodule for $path."
done

git submodule update --init --recursive

# 7) Stage and commit any new changes
if [[ -n "$(git status --porcelain)" ]]; then
  git add .
  git commit -m "chore: bootstrap/refresh LTF scaffold and submodules"
fi

# 8) Optional remote
if [[ -n "$REMOTE_URL" ]]; then
  if git remote get-url origin &>/dev/null; then
    warn "Remote 'origin' already set: $(git remote get-url origin)"
  else
    git remote add origin "$REMOTE_URL"
    say "Added remote origin: $REMOTE_URL"
  fi
  # Standardize on 'main' before first push (safe if already on master)
  current_branch="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "$current_branch" != "main" ]]; then
    git branch -M main || true
  fi
  warn "Reminder: push when ready → git push -u origin main"
fi

say "Done. LTF scaffold is ready at $(pwd)"
