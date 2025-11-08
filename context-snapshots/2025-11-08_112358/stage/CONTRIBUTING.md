# Contributing to the Living Task Framework (LTF)

## Philosophy

This repo is the **thinking hub + coordination layer** for apps, research, and education artifacts.
Deployable apps live as **separate repos** and are included here as **git submodules**.

- --

## Quick Start

```bash

# clone

git clone https://github.com/<org>/living-task-framework.git
cd living-task-framework

# initialize submodules

make init

# or:

git submodule update --init --recursive
```

- --

## Submodule Workflow

Each app (for example, `projects/ai-thought-capture`) is its **own repository**.

To update an app inside LTF:

```bash
cd projects/ai-thought-capture
git pull origin main
cd ../..
git add projects/ai-thought-capture
git commit -m "chore: bump ai-thought-capture submodule"
```

- *Important:**

- Do **not** commit app code directly in this repo.
- Always commit in the app’s repo, then update the pointer here.

- --

## Hooks

This repo enforces a `pre-push` check to keep submodules in sync.

Install once:

```bash
pwsh ./tools/scripts/Install-GitHooks.ps1
```

If blocked on push, fix with:

```bash
pwsh ./tools/scripts/Update-Submodules.ps1 -Push
```

Bypass (only if you are sure you understand the implications):

```bash
git push --no-verify
```

- --

## Line Endings

We enforce LF (`\n`) by default across all text files.
Windows scripts (`*.ps1`, `*.bat`) remain CRLF via `.gitattributes` for shell compatibility.

- --

## Labels & Issues

We use a shared label taxonomy (`.github/labels.json`) to ensure semantic consistency:

| Category | Examples | Description |
|-----------|-----------|-------------|
| **Concept** | `concept:cip-e`, `concept:dmp`, `concept:vsyn`, `concept:vcs` | Core collaboration principles |
| **Type** | `type:guide`, `type:app`, `type:research` | Artifact nature |
| **Status** | `status:proposal`, `status:active`, `status:paused` | Lifecycle stage |

To sync labels (once authenticated via GitHub CLI):

```bash
pwsh ./tools/scripts/Apply-RepoLabels.ps1
```

- --

## Reflective Practice

When you notice a major flow or context shift, record a checkpoint entry in:

```text
reflections/reflective_checkpoints.md
```

Include:

- **What changed** (decision, perspective, context),
- **Why it matters**, and
- **Next intended step**.

This helps maintain *continuity of cognition* across the collaborative cycle.

- --

## Commit & Branch Conventions

- **Branch base:** `main`
- **Commit prefixes:**
  - `feat:` — new functionality
  - `fix:` — bug fix
  - `docs:` — documentation change
  - `chore:` — maintenance, updates, etc.
  - `refactor:` — internal restructure without changing external behavior

Example:

```bash
git commit -m "feat: add reflective dashboard visual"
```

- --

## Summary

1. **Initialize** submodules before you start (`make init` or PowerShell equivalent).
2. **Use** the provided update and push scripts to stay aligned.
3. **Respect** the pre-push hook — it protects you from pointer drift.
4. **Reflect** after significant conceptual or structural updates.
5. **Label** everything consistently; it’s how meaning travels in this framework.

Thank you for contributing to the Living Task Framework!
