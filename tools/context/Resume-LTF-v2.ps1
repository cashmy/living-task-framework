# LTF Context Resume v2 - Smart snapshot filtering and restoration
# Usage: .\Resume-LTF.ps1 -List
#        .\Resume-LTF.ps1 -Type test -Latest
#        .\Resume-LTF.ps1 -Project ehr-consent -List

param(
  [string]$Project = "",
  [ValidateSet("", "test", "pivotal", "session", "burst", "checkpoint", "archive", "resume")]
  [string]$Type = "",
  [string]$Label = "",
  [switch]$Latest,
  [switch]$List
)

$snapshots = Get-ChildItem "context-snapshots" -Directory | Sort-Object Name -Descending

$allSnaps = @()
foreach ($dir in $snapshots) {
  $name = $dir.Name
  $sessionState = Join-Path $dir.FullName "session-state.yaml"
  
  # Try reading session-state.yaml first (most accurate)
  if (Test-Path $sessionState) {
    try {
      $content = Get-Content $sessionState -Raw
      
      # Parse YAML metadata (simple regex approach - handles indented fields)
      $timestamp = if ($content -match '\s+timestamp:\s*"([^"]+)"') { $matches[1] } else { "" }
      $snapType = if ($content -match '\s+snapshot_type:\s*"([^"]+)"') { $matches[1] } else { "" }
      $proj = if ($content -match '\s+project:\s*"([^"]+)"') { $matches[1] } else { "" }
      $snapLabel = if ($content -match '\s+snapshot_label:\s*"([^"]+)"') { $matches[1] } else { "" }
      
      # Only use YAML data if we got at least type (indicates new format)
      if ($snapType) {
        $allSnaps += @{
          Path   = $dir.FullName
          Name   = $name
          Time   = $timestamp
          Type   = $snapType
          Proj   = $proj
          Label  = $snapLabel
          Source = "yaml"
        }
        continue
      }
      # Otherwise fall through to filename parsing
    }
    catch {
      # Fall through to filename parsing
    }
  }
  
  # Fallback: Parse from directory name
  if ($name -match '^(\d{4}-\d{2}-\d{2}_\d{6})-([^-]+)-(.+)$') {
    $timestamp = $matches[1]
    $snapType = $matches[2]
    $rest = $matches[3]
    
    # Split rest into project-label by finding last reasonable split
    # Look for pattern: [project]-[label] where label is the last segment
    if ($rest -match '^(.+)-([^-]+(?:-[^-]+)*)$') {
      $proj = $matches[1]
      $snapLabel = $matches[2]
    }
    else {
      $proj = $rest
      $snapLabel = ""
    }
    
    $allSnaps += @{
      Path   = $dir.FullName
      Name   = $name
      Time   = $timestamp
      Type   = $snapType
      Proj   = $proj
      Label  = $snapLabel
      Source = "filename"
    }
  }
  elseif ($name -match '^(\d{4}-\d{2}-\d{2}_\d{6})$') {
    # Legacy format
    $allSnaps += @{
      Path   = $dir.FullName
      Name   = $name
      Time   = $matches[1]
      Type   = "legacy"
      Proj   = "unknown"
      Label  = ""
      Source = "filename"
    }
  }
}

# Filter
$filtered = $allSnaps

if ($Project) { 
  $filtered = $filtered | Where-Object { $_.Proj -like "*$Project*" } 
}
if ($Type) { 
  $filtered = $filtered | Where-Object { $_.Type -eq $Type } 
}
if ($Label) { 
  $filtered = $filtered | Where-Object { 
    ![string]::IsNullOrEmpty($_.Label) -and ($_.Label -like "*$Label*")
  }
}
if ($Latest -and $filtered.Count -gt 0) { $filtered = @($filtered[0]) }

# Display
$count = if ($filtered -is [array]) { $filtered.Count } else { 1 }
Write-Host ""
Write-Host "═══ LTF Snapshots ($count match$(if ($count -ne 1) {'es'})) ═══" -ForegroundColor Cyan
Write-Host ""

if ($List) {
  foreach ($s in $filtered) {
    $typeLabel = if ($s.Type) { $s.Type.ToUpper() } else { "?" }
    $col = switch ($s.Type) {
      "test" { "Yellow" }
      "pivotal" { "Magenta" }
      "session" { "Cyan" }
      "burst" { "Green" }
      "checkpoint" { "Blue" }
      "archive" { "Gray" }
      default { "White" }
    }
    Write-Host "  [$typeLabel]" -ForegroundColor $col -NoNewline
    Write-Host " $($s.Time) | $($s.Proj) | $($s.Label)"
  }
}
else {
  if ($filtered.Count -eq 0) {
    Write-Host "No matches. Try: -List" -ForegroundColor Yellow
  }
  else {
    $s = $filtered[0]
    Write-Host "Latest Match:" -ForegroundColor Green
    Write-Host "  Type: $($s.Type)"  
    Write-Host "  Project: $($s.Proj)"
    Write-Host "  Label: $($s.Label)"
    Write-Host ""
    
    $prompt = Join-Path $s.Path "transfer-prompt.md"
    if (Test-Path $prompt) {
      Write-Host "═══ Transfer Prompt ═══" -ForegroundColor Green
      Get-Content $prompt
    }
  }
}

Write-Host ""
