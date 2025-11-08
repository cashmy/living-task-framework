<#
.SYNOPSIS
  Installs repo-tracked git hooks by setting core.hooksPath and ensuring pre-push & pre-commit are executable.
.USAGE
  pwsh ./tools/scripts/Install-GitHooks.ps1
#>

$ErrorActionPreference = "Stop"

# Ensure we're in a git repo
if (-not (Test-Path ".git")) {
  Write-Host "[x] Run this from the repository root (where .git exists)" -ForegroundColor Red
  exit 1
}

# Ensure .githooks exists
if (-not (Test-Path ".githooks")) {
  New-Item -ItemType Directory -Path ".githooks" | Out-Null
}

# Write pre-push if missing
$prePushPath = ".githooks/pre-push"
if (-not (Test-Path $prePushPath)) {
@"
#!/usr/bin/env bash
set -euo pipefail
echo "[pre-push] Checking submodule status…"
NEEDS_INIT=\$(git submodule status --recursive | awk '/^-/{print \$2}')
if [ -n "\${NEEDS_INIT}" ]; then
  echo "[x] Uninitialized submodules detected:"
  echo "\${NEEDS_INIT}" | sed 's/^/   • /'
  echo "    Run: git submodule update --init --recursive"
  echo "    Or: pwsh ./tools/scripts/Update-Submodules.ps1"
  exit 1
fi
NEEDS_COMMIT=\$(git submodule status --recursive | awk '/^\+/{print \$2}')
if [ -n "\${NEEDS_COMMIT}" ]; then
  echo "[x] Submodules have new commits not recorded in superproject:"
  echo "\${NEEDS_COMMIT}" | sed 's/^/   • /'
  echo "    Fix: commit the pointer bumps:"
  echo "    git add <submodule-paths> && git commit -m \"chore: bump submodule pointers\""
  echo "    Or: pwsh ./tools/scripts/Update-Submodules.ps1 -Push"
  exit 1
fi
DIRTY_PATHS=\$(
  git submodule foreach --recursive '
    if ! git diff --quiet || ! git diff --cached --quiet; then
      echo \$path
    fi
  ' | sed '/^Entering /d'
)
if [ -n "\${DIRTY_PATHS}" ]; then
  echo "[x] Dirty submodules detected (uncommitted changes):"
  echo "\${DIRTY_PATHS}" | sed 's/^/   • /'
  echo "    Commit or stash changes inside these submodules, then re-run."
  exit 1
fi
echo "[pre-push] OK: submodules are initialized, clean, and pointers are committed."
exit 0
"@ | Set-Content -NoNewline -Path $prePushPath -Encoding UTF8
}

# Write pre-commit if missing
$preCommitPath = ".githooks/pre-commit"
if (-not (Test-Path $preCommitPath)) {
@"
#!/usr/bin/env bash
set -euo pipefail
echo "[pre-commit] Preparing Markdown changes…"
STAGED_MD=\$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(md|mdx)$' || true)
if [ -n "\${STAGED_MD}" ]; then
  echo "\${STAGED_MD}" | while read -r file; do
    [ -f "\$file" ] || continue
    perl -0777 -pe 's/[ \t]+(\r?\n)/\1/g; END{ if(substr($_,-1) !~ /\n/) { $_ .= "\n" } }' "\$file" > "\$file.__tmp__"
    if ! cmp -s "\$file" "\$file.__tmp__"; then
      mv "\$file.__tmp__" "\$file"
      git add "\$file"
      echo "  • tidied: \$file"
    else
      rm -f "\$file.__tmp__"
    fi
  done
else
  echo "[pre-commit] No staged Markdown files to tidy."
fi
if command -v markdownlint-cli2 >/dev/null 2>&1; then
  echo "[pre-commit] Running markdownlint-cli2…"
  markdownlint-cli2 "**/*.md" || { echo "[x] markdownlint issues detected. Fix and re-stage."; exit 1; }
elif command -v markdownlint >/dev/null 2>&1; then
  echo "[pre-commit] Running markdownlint…"
  markdownlint "**/*.md" || { echo "[x] markdownlint issues detected. Fix and re-stage."; exit 1; }
else
  echo "[pre-commit] Skipping lint: markdownlint not installed."
fi
echo "[pre-commit] OK."
exit 0
"@ | Set-Content -NoNewline -Path $preCommitPath -Encoding UTF8
}

# Configure Git to use .githooks
& git config core.hooksPath .githooks

# Mark executable via bash if available
try {
  bash -lc "chmod +x .githooks/pre-push .githooks/pre-commit" | Out-Null
} catch {
  Write-Host "[!] Could not chmod via bash. Hooks will still run on Git for Windows." -ForegroundColor Yellow
}

Write-Host "[✓] Git hooks installed (pre-push & pre-commit) and core.hooksPath set to .githooks" -ForegroundColor Green
