<#
.SYNOPSIS
  Emit a paste-ready CIP bootstrapping prompt from an existing snapshot (ZIP or folder).

.PARAMETER SnapshotZip
  Path to a snapshot ZIP (created by Save-LTFContext.ps1).

.PARAMETER SnapshotDir
  Path to an extracted snapshot folder (the one containing Snapshot.md).

.PARAMETER OutFile
  Where to write the bootstrapping prompt. Default: CIP_Resume_<timestamp>.md in CWD.

.EXAMPLE
  pwsh tools/context/Resume-LTFContext.ps1 -SnapshotZip context-snapshots/LTF_Context_macro_2025-11-08_120233.zip

.EXAMPLE
  pwsh tools/context/Resume-LTFContext.ps1 -SnapshotDir context-snapshots/2025-11-08_120233
#>

param(
  [string]$SnapshotZip,
  [string]$SnapshotDir,
  [string]$OutFile
)

$ErrorActionPreference = "Stop"

# Validate parameters
if ([string]::IsNullOrWhiteSpace($SnapshotZip) -and [string]::IsNullOrWhiteSpace($SnapshotDir)) {
  throw "Provide either -SnapshotZip or -SnapshotDir parameter."
}

# Prepare extraction if ZIP
$workDir = $SnapshotDir
$cleanup = $false

if (-not [string]::IsNullOrWhiteSpace($SnapshotZip)) {
  if (-not (Test-Path $SnapshotZip)) { 
    throw "Snapshot ZIP not found: $SnapshotZip" 
  }
  $ts = Get-Date -Format "yyyy-MM-dd_HHmmss"
  $workDir = Join-Path $env:TEMP "ltf_snapshot_$ts"
  New-Item -ItemType Directory -Path $workDir -Force | Out-Null
  Write-Host "Extracting snapshot to: $workDir" -ForegroundColor Cyan
  Expand-Archive -Path $SnapshotZip -DestinationPath $workDir -Force
  $cleanup = $true
}

# Resolve Snapshot.md
$snapPath = Join-Path $workDir "Snapshot.md"
if (-not (Test-Path $snapPath)) {
  throw "Snapshot.md not found in $workDir. Did you pass the correct folder?"
}
$content = Get-Content -Raw $snapPath

# Extract the CIP block from Snapshot.md
$preamble = $null
$lines = $content -split "``r?``n"
$inBlock = $false
$buff = New-Object System.Collections.Generic.List[string]
foreach ($ln in $lines) {
  if ($ln -match '^``````text') {
    if (-not $inBlock) { 
      $inBlock = $true
      continue 
    } else { 
      break 
    }
  }
  if ($inBlock) { $buff.Add($ln) }
}
$preamble = $buff -join "`n"

if ([string]::IsNullOrWhiteSpace($preamble)) {
  throw "Could not extract CIP preamble from Snapshot.md. The file may not contain a ```text block."
}

# Build the final resume prompt, appending a short instruction
$final = @()
$final += "## LTF CIP Resume Preamble"
$final += ""
$final += "Paste this into a new chat to rehydrate context:"
$final += ""
$final += "``````text"
$final += $preamble.Trim()
$final += ""
$final += "---"
$final += "Please confirm receipt by: (1) restating the active focus, (2) listing any ambiguous terms, and (3) proposing the next best small step."
$final += "``````"

if ([string]::IsNullOrWhiteSpace($OutFile)) {
  $OutFile = "CIP_Resume_{0}.md" -f (Get-Date -Format "yyyy-MM-dd_HHmmss")
}

$final -join "`n" | Set-Content -Path $OutFile -Encoding UTF8

Write-Host "[✓] Generated resume prompt:" -ForegroundColor Green
Write-Host "    $OutFile"

if ($cleanup) {
  Remove-Item -Recurse -Force $workDir
}
