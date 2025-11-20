param(
  [Parameter(Mandatory = $true)][string]$Path,
  [string]$Branch = "main",
  [string]$DefaultBranch,
  [switch]$Push
)

if (-not (Test-Path ".git")) { Write-Host "[x] Run at repo root"; exit 1 }
if (-not (Test-Path $Path)) { Write-Host "[x] Not found: $Path"; exit 1 }

Push-Location $Path
try {
  git fetch --all

  # Determine remote default branch via origin/HEAD; allow override via -DefaultBranch
  $originHeadRef = (& git symbolic-ref --short refs/remotes/origin/HEAD 2>$null)
  $detectedDefault = if ($originHeadRef) { ($originHeadRef -split '/')[1] } else { $null }
  $resolvedDefault = if ($DefaultBranch) { $DefaultBranch } elseif ($detectedDefault) { $detectedDefault } else { 'main' }

  function Test-RemoteBranch([string]$b) {
    return ((& git branch -a) -match "remotes/origin/$b")
  }

  $currentBranch = (& git symbolic-ref --short -q HEAD)
  $isDetached = [string]::IsNullOrEmpty($currentBranch)

  if (Test-RemoteBranch $Branch) {
    git checkout $Branch 2>$null | Out-Null
    git pull origin $Branch
  }
  else {
    if ($isDetached) {
      if (Test-RemoteBranch $resolvedDefault) {
        Write-Host "[i] Detached HEAD; checking out '$resolvedDefault' tracking origin/$resolvedDefault" -ForegroundColor Cyan
        git checkout -B $resolvedDefault "origin/$resolvedDefault"
        git pull origin $resolvedDefault
      }
      else {
        Write-Host "[!] Detached HEAD and no usable default branch found; skipping pull" -ForegroundColor Yellow
      }
    }
    else {
      if (Test-RemoteBranch $currentBranch) {
        git pull origin $currentBranch
      }
      elseif (Test-RemoteBranch $resolvedDefault) {
        Write-Host "[i] Current branch has no remote; switching to default '$resolvedDefault'" -ForegroundColor Cyan
        git checkout -B $resolvedDefault "origin/$resolvedDefault"
        git pull origin $resolvedDefault
      }
      else {
        Write-Host "[!] Branch '$Branch' not found and no default available; skipping pull" -ForegroundColor Yellow
      }
    }
  }
}
finally { Pop-Location }

git add $Path
if ($null -ne (git status --porcelain)) {
  git commit -m "chore: bump submodule '$Path' to latest '$Branch'"
  Write-Host "[✓] Updated and committed pointer for $Path" -ForegroundColor Green
  if ($Push) {
    $current = (git rev-parse --abbrev-ref HEAD).Trim()
    if ($current -ne "main") { git branch -M main }
    git push -u origin main
  }
}
else {
  Write-Host "[=] No changes in $Path" -ForegroundColor Yellow
}
