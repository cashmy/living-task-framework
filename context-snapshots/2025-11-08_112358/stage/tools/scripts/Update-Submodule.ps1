param(
  [Parameter(Mandatory=$true)][string]$Path,
  [string]$Branch = "main"
)

if (-not (Test-Path ".git")) { Write-Host "[x] Run at repo root"; exit 1 }
if (-not (Test-Path $Path)) { Write-Host "[x] Not found: $Path"; exit 1 }

Push-Location $Path
try {
  git fetch --all
  $hasBranch = (& git branch -a) -match "remotes/origin/$Branch"
  if ($hasBranch) { git checkout $Branch 2>$null | Out-Null; git pull origin $Branch } else { git pull }
} finally { Pop-Location }

git add $Path
if ($null -ne (git status --porcelain)) {
  git commit -m "chore: bump submodule '$Path' to latest '$Branch'"
  Write-Host "[✓] Updated and committed pointer for $Path" -ForegroundColor Green
} else {
  Write-Host "[=] No changes in $Path" -ForegroundColor Yellow
}
