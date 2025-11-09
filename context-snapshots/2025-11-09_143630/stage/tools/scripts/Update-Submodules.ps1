<#
.SYNOPSIS
  Updates all git submodules to latest on main (or specific branch), commits the pointer bump in the superproject, and optionally pushes.

.PARAMETER Branch
  The branch to pull in each submodule. Default: main

.PARAMETER Push
  Switch: if set, push the commit to origin/main

.EXAMPLE
  ./tools/scripts/Update-Submodules.ps1
  ./tools/scripts/Update-Submodules.ps1 -Branch main -Push
#>

param(
  [string]$Branch = "main",
  [switch]$Push
)

$ErrorActionPreference = "Stop"

function Invoke-InRepo {
  param([string]$Path, [scriptblock]$Script)
  Write-Host "==> $Path" -ForegroundColor Green
  Push-Location $Path
  try { & $Script } finally { Pop-Location }
}

# Ensure we're at repo root (has .git)
if (-not (Test-Path ".git")) {
  Write-Host "[x] Run this from the repository root" -ForegroundColor Red
  exit 1
}

# Initialize submodules if needed
git submodule update --init --recursive | Out-Null

# Collect submodule paths
$submodulePaths = (& git config --file .gitmodules --get-regexp path) `
  -replace 'submodule\..*\.path ', ''

if (-not $submodulePaths) {
  Write-Host "[!] No submodules registered." -ForegroundColor Yellow
  exit 0
}

foreach ($p in $submodulePaths) {
  if (-not (Test-Path $p)) {
    Write-Host "[!] Missing submodule path: $p (skipping)" -ForegroundColor Yellow
    continue
  }
  Invoke-InRepo -Path $p -Script {
    git fetch --all
    # If the branch exists, checkout and pull
    $branch = $using:Branch
    $hasBranch = (& git branch -a) -match "remotes/origin/$branch"
    if ($hasBranch) {
      git checkout $branch 2>$null | Out-Null
      git pull origin $branch
    } else {
      Write-Host "[!] Branch '$branch' not found; pulling default" -ForegroundColor Yellow
      git pull
    }
  }
}

# Update superproject pointers
git add .
if ($null -ne (git status --porcelain)) {
  git commit -m "chore: bump submodule pointers to latest '$Branch'"
  if ($Push) {
    # Ensure we're on main
    $current = (git rev-parse --abbrev-ref HEAD).Trim()
    if ($current -ne "main") { git branch -M main }
    git push -u origin main
  }
} else {
  Write-Host "[=] No submodule changes detected." -ForegroundColor Yellow
}
