# Test enhanced transfer prompt generation with existing session state

$sessionStatePath = "context-snapshots\2025-11-09_125644\session-state.yaml"
$templatePath = "core/prompts/context-transfer-full.txt"
$outputPath = "context-snapshots\2025-11-09_125644\transfer-prompt-enhanced.md"

# Import functions from Save-LTFContext-v2.ps1
. .\tools\context\Save-LTFContext-v2.ps1

# Test extraction detection
if (Test-ExtractionResults -SessionStatePath $sessionStatePath) {
  Write-Host "✓ Cognitive extraction results detected!" -ForegroundColor Green
  
  # Get extraction results
  $extractionResults = Get-ExtractionResultsFromState -SessionStatePath $sessionStatePath
  
  # Load session state for manifest
  $stateContent = Get-Content $sessionStatePath -Raw | ConvertFrom-Yaml
  $manifest = @{
    project = $stateContent.session_metadata.project
    type = $stateContent.session_metadata.type
    repository = $stateContent.session_metadata.repository
  }
  
  $influencerRefs = $stateContent.influencers
  $timestamp = $stateContent.session_metadata.timestamp
  
  # Generate enhanced template
  Write-Host "Generating enhanced transfer prompt..." -ForegroundColor Cyan
  $prompt = Expand-EnhancedTemplate `
    -TemplatePath $templatePath `
    -Manifest $manifest `
    -ExtractionResults $extractionResults `
    -InfluencerRefs $influencerRefs `
    -Timestamp $timestamp
  
  # Save
  $prompt | Set-Content -Path $outputPath -Encoding UTF8
  Write-Host "✓ Enhanced transfer prompt: $outputPath" -ForegroundColor Green
  
} else {
  Write-Host "✗ No cognitive extraction results found" -ForegroundColor Red
}
