<#
.SYNOPSIS
  Resume LTF collaboration using v3.0 3-Layer Context Model snapshots

.DESCRIPTION
  Smart snapshot filtering and v3.0 context restoration with priority loading:
  - Context Layer 3: User State (WHO - relationship context) FIRST
  - Context Layer 2: Project CIP (WHAT - project identity)
  - Context Layer 1: Session Metadata (HOW/WHEN - temporal tracking)
  
  Displays transfer-prompt.md for manual context restoration or provides
  direct file access to the 3 layers.

.PARAMETER Project
  Filter snapshots by project name

.PARAMETER Type
  Filter by snapshot type (test, pivotal, session, burst, checkpoint, archive, resume)

.PARAMETER Label
  Filter by snapshot label

.PARAMETER Latest
  Show only the most recent matching snapshot

.PARAMETER List
  List all matching snapshots instead of showing transfer prompt

.PARAMETER Load
  Load context layers directly (displays file paths for manual loading)

.NOTES
  Version: 3.0
  Architecture: 3-Layer Context Model (User State → Project CIP → Session Metadata)
  CSAC Priority: Relationship context before technical context

.EXAMPLE
  .\Resume-LTF.ps1 -List
  List all available snapshots

.EXAMPLE
  .\Resume-LTF.ps1 -Latest
  Show transfer prompt for most recent snapshot

.EXAMPLE
  .\Resume-LTF.ps1 -Project ehr-consent -Latest -Load
  Load context layers for most recent ehr-consent snapshot
#>

param(
  [string]$Project = "",
  [ValidateSet("", "test", "pivotal", "session", "burst", "checkpoint", "archive", "resume")]
  [string]$Type = "",
  [string]$Label = "",
  [switch]$Latest,
  [switch]$List,
  [switch]$Load
)

$ErrorActionPreference = "Stop"

#region v3.0 Context Layer Functions

function Show-ContextLayers {
  <#
  .SYNOPSIS
    Display v3.0 context layer file paths in priority order
  
  .PARAMETER SnapshotPath
    Path to the snapshot directory
  #>
  param([string]$SnapshotPath)
  
  Write-Host "`n═══ v3.0 Context Layers (Load Priority Order) ═══" -ForegroundColor Cyan
  
  # Layer 3: User State (PRIORITY 1 - WHO)
  $userState = Join-Path $SnapshotPath "tier1_user_state.md"
  if (Test-Path $userState) {
    Write-Host "`n[1] Context Layer 3 - User State (WHO - HIGHEST PRIORITY)" -ForegroundColor Green
    Write-Host "    File: $userState" -ForegroundColor White
    Write-Host "    Load this FIRST to restore relationship context" -ForegroundColor Gray
  }
  
  # Layer 2: Project CIP (PRIORITY 2 - WHAT)
  $projectCIP = Join-Path $SnapshotPath "tier2_project_cip.md"
  if (Test-Path $projectCIP) {
    Write-Host "`n[2] Context Layer 2 - Project CIP (WHAT)" -ForegroundColor Cyan
    Write-Host "    File: $projectCIP" -ForegroundColor White
    Write-Host "    Load this SECOND to restore project identity" -ForegroundColor Gray
  }
  
  # Layer 1: Session Metadata (PRIORITY 3 - HOW/WHEN)
  $sessionMeta = Join-Path $SnapshotPath "tier3_session_metadata.md"
  if (Test-Path $sessionMeta) {
    Write-Host "`n[3] Context Layer 1 - Session Metadata (HOW/WHEN)" -ForegroundColor Yellow
    Write-Host "    File: $sessionMeta" -ForegroundColor White
    Write-Host "    Load this THIRD to restore temporal tracking" -ForegroundColor Gray
  }
  
  # Additional resources
  $manifest = Join-Path $SnapshotPath "influencer-manifest.yaml"
  if (Test-Path $manifest) {
    Write-Host "`n[4] Influencer Manifest (Reference-Based)" -ForegroundColor DarkCyan
    Write-Host "    File: $manifest" -ForegroundColor White
    Write-Host "    GitHub URLs for framework files" -ForegroundColor Gray
  }
  
  Write-Host ""
}

function Test-V3Snapshot {
  <#
  .SYNOPSIS
    Check if snapshot has v3.0 structure
  
  .PARAMETER SnapshotPath
    Path to the snapshot directory
  #>
  param([string]$SnapshotPath)
  
  $userState = Join-Path $SnapshotPath "tier1_user_state.md"
  $transferPrompt = Join-Path $SnapshotPath "transfer-prompt.md"
  
  return (Test-Path $userState) -or (Test-Path $transferPrompt)
}

#endregion v3.0 Context Layer Functions

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
    
    # Check for v3.0 structure
    $isV3 = Test-V3Snapshot -SnapshotPath $s.Path
    $v3Badge = if ($isV3) { " [v3.0]" } else { "" }
    
    Write-Host "  [$typeLabel]" -ForegroundColor $col -NoNewline
    Write-Host " $($s.Time) | $($s.Proj) | $($s.Label)$v3Badge"
  }
}
else {
  if ($filtered.Count -eq 0) {
    Write-Host "No matches. Try: -List" -ForegroundColor Yellow
  }
  else {
    $s = $filtered[0]
    $isV3 = Test-V3Snapshot -SnapshotPath $s.Path
    
    Write-Host "Latest Match:" -ForegroundColor Green
    Write-Host "  Type: $($s.Type)"  
    Write-Host "  Project: $($s.Proj)"
    Write-Host "  Label: $($s.Label)"
    Write-Host "  Version: $(if ($isV3) { 'v3.0 (3-Layer Context Model)' } else { 'v2 (Legacy)' })" -ForegroundColor $(if ($isV3) { 'Cyan' } else { 'Gray' })
    Write-Host ""
    
    # v3.0 snapshots: Show context layers or transfer prompt
    if ($isV3) {
      if ($Load) {
        Show-ContextLayers -SnapshotPath $s.Path
      }
      else {
        $prompt = Join-Path $s.Path "transfer-prompt.md"
        if (Test-Path $prompt) {
          Write-Host "═══ Transfer Prompt (v3.0) ═══" -ForegroundColor Green
          Get-Content $prompt
        }
        else {
          Write-Host "No transfer-prompt.md found. Use -Load to see context layer files." -ForegroundColor Yellow
        }
      }
    }
    # v2 snapshots: Show legacy snapshot
    else {
      $snapshotMd = Join-Path $s.Path "Snapshot.md"
      if (Test-Path $snapshotMd) {
        Write-Host "═══ Snapshot (v2 Legacy) ═══" -ForegroundColor Gray
        Get-Content $snapshotMd | Select-Object -First 50
        Write-Host "`n... (showing first 50 lines, see full file at $snapshotMd)" -ForegroundColor DarkGray
      }
    }
  }
}

Write-Host ""
