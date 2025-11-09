# Cleanup Legacy Snapshots Script
# Run this after closing all snapshot files in VS Code

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "LTF Snapshot Cleanup - Rename Pivotal + Remove Tests" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Step 1: Rename pivotal moment snapshots
Write-Host "[1/2] Renaming pivotal moment snapshots..." -ForegroundColor Yellow
Write-Host ""

$pivotalRenames = @{
  "2025-11-09_114451" = "2025-11-09_114451-pivotal-ltf-first-self-validation"
  "2025-11-09_114821" = "2025-11-09_114821-pivotal-ltf-roi-analysis"
  "2025-11-09_115202" = "2025-11-09_115202-pivotal-ltf-killer-app-vision"
}

foreach ($old in $pivotalRenames.Keys) {
  $oldPath = "context-snapshots\$old"
  $newPath = "context-snapshots\$($pivotalRenames[$old])"
  
  if (Test-Path $oldPath) {
    try {
      Rename-Item $oldPath $newPath -ErrorAction Stop
      Write-Host "  ✓ $old -> $($pivotalRenames[$old].Split('-')[-1])" -ForegroundColor Green
    } catch {
      Write-Host "  ✗ $old (file in use - close in VS Code)" -ForegroundColor Red
    }
  } else {
    Write-Host "  - $old (already renamed)" -ForegroundColor Gray
  }
}

# Step 2: Remove test snapshots
Write-Host ""
Write-Host "[2/2] Removing test snapshots..." -ForegroundColor Yellow
Write-Host ""

$testSnapshots = @(
  "2025-11-09_113345",  # Early tests
  "2025-11-09_113412",
  "2025-11-09_113429",
  "2025-11-09_113823",
  "2025-11-09_113846",
  "2025-11-09_114359",
  "2025-11-09_114431",
  "2025-11-09_115231",  # Between pivotal moments
  "2025-11-09_115244",
  "2025-11-09_121329",  # Phase 4 testing
  "2025-11-09_121448",
  "2025-11-09_121538",
  "2025-11-09_122210",
  "2025-11-09_122426",
  "2025-11-09_125908",  # After cognitive extraction
  "2025-11-09_125942"
)

$removed = 0
foreach ($snapshot in $testSnapshots) {
  $path = "context-snapshots\$snapshot"
  if (Test-Path $path) {
    try {
      Remove-Item $path -Recurse -Force -ErrorAction Stop
      Write-Host "  ✓ Removed $snapshot" -ForegroundColor Gray
      $removed++
    } catch {
      Write-Host "  ✗ $snapshot (file in use)" -ForegroundColor Red
    }
  }
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "Cleanup Complete!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
Write-Host "Removed $removed test snapshots" -ForegroundColor Gray
Write-Host ""
Write-Host "Remaining snapshots:" -ForegroundColor Cyan
.\tools\context\Resume-LTF.ps1 -List
