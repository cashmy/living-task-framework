# Quick test for Phase 4 enhanced template
# Load the functions from Save-LTFContext-v2.ps1

. "d:\@living-task-framework\tools\context\Save-LTFContext-v2.ps1"

$sessionStatePath = "d:\@living-task-framework\context-snapshots\2025-11-09_121329\session-state.yaml"

# Create a simple manifest
$manifest = @{
  project = @{
    name = "living-task-framework"
    type = "research"
    repo = "https://github.com/cashmy/living-task-framework"
    branch = "main"
  }
}

# Create simple influencer refs
$influencerRefs = @(
  @{
    category = "architecture"
    path = "core/architecture/LTF_Concept_Map_v0.91.md"
    github_url = "https://github.com/cashmy/living-task-framework/blob/main/core/architecture/LTF_Concept_Map_v0.91.md"
    last_modified = "2025-11-08"
  }
)

$timestamp = "2025-11-09_121329"

Write-Host "Testing Phase 4 with extraction results..." -ForegroundColor Cyan
Write-Host ""

$prompt = New-TransferPrompt `
  -Manifest $manifest `
  -InfluencerRefs $influencerRefs `
  -Timestamp $timestamp `
  -SessionStatePath $sessionStatePath

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "Generated Transfer Prompt (first 100 lines):" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""

# Show first 100 lines
$lines = $prompt -split "`n"
$lines[0..([Math]::Min(99, $lines.Count-1))] | ForEach-Object { Write-Host $_ }

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "Total lines: $($lines.Count)" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Green
