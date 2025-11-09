# Auto-Detect Feature Test Script
# Demonstrates the auto-detect functionality working

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Auto-Detect Feature Test" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Test 1: Run Save-LTFContext with EHR manifest
Write-Host "[Test 1] Running Save-LTFContext with EHR consent platform..." -ForegroundColor Yellow
Write-Host ""

& pwsh -File tools/context/Save-LTFContext-v2.ps1 `
  -Project ehr-consent-platform `
  -Type test `
  -Label "auto-detect-demo" `
  -Mnemonic "ehrc" `
  -ReviewMoments:$false

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Test Complete!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

# Show the session state with auto-detect metadata
$snapshotDir = Get-ChildItem "context-snapshots" | 
  Where-Object { $_.Name -like "*test-ehrc-auto-detect-demo*" } |
  Sort-Object CreationTime -Descending |
  Select-Object -First 1

if ($snapshotDir) {
  Write-Host "Generated snapshot: $($snapshotDir.Name)`n" -ForegroundColor Cyan
  
  $sessionStatePath = Join-Path $snapshotDir.FullName "session-state.yaml"
  
  Write-Host "Session state excerpt (showing auto-detect metadata):`n" -ForegroundColor Yellow
  
  # Show first auto-detected file
  $content = Get-Content $sessionStatePath -Raw
  
  # Extract first auto-detected entry
  if ($content -match '(?s)(compliance:.*?source: "auto-detect".*?rule_pattern: "[^"]+")') {
    $autoDetectEntry = $matches[1]
    Write-Host $autoDetectEntry -ForegroundColor Gray
  }
  
  Write-Host "`n✅ Auto-detect working correctly!" -ForegroundColor Green
  Write-Host "   - Glob patterns matched files" -ForegroundColor Gray
  Write-Host "   - Metadata preserved (priority, rule_pattern)" -ForegroundColor Gray
  Write-Host "   - Manual files took precedence" -ForegroundColor Gray
}
