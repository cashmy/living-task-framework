<#
.SYNOPSIS
  Creates/updates GitHub issue labels for the current repo using .github/labels.json

.REQUIREMENTS
  - GitHub CLI (gh) authenticated: gh auth login
  - .github/labels.json present in repo
#>

$ErrorActionPreference = "Stop"

if (-not (Test-Path ".github/labels.json")) {
  Write-Host "[x] Missing .github/labels.json" -ForegroundColor Red
  exit 1
}

# Ensure gh is available
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Write-Host "[x] GitHub CLI 'gh' not found." -ForegroundColor Red
  exit 1
}

# Get repo slug (owner/name)
$repo = (gh repo view --json nameWithOwner | ConvertFrom-Json).nameWithOwner
if (-not $repo) {
  Write-Host "[x] Unable to resolve repo slug. Run 'gh repo view' once or set GH repo explicitly." -ForegroundColor Red
  exit 1
}

# Read JSON
$labels = Get-Content ".github/labels.json" -Raw | ConvertFrom-Json

foreach ($lbl in $labels) {
  $name = $lbl.name
  $color = $lbl.color
  $desc = $lbl.description
  try {
    gh label create "$name" --color "$color" --description "$desc" --repo "$repo" 2>$null
    Write-Host "[+] Created: $name" -ForegroundColor Green
  } catch {
    gh label edit "$name" --color "$color" --description "$desc" --repo "$repo" 2>$null
    Write-Host "[~] Updated: $name" -ForegroundColor Yellow
  }
}
Write-Host "[✓] Labels synchronized." -ForegroundColor Green
