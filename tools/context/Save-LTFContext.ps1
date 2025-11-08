<#
.SYNOPSIS
  Create a timestamped LTF context snapshot (ZIP + Snapshot.md + CIP preamble).

.DESCRIPTION
  Gathers essential context (framework docs, glossary, manifest, reflections,
  current focus artifact) into /context-snapshots/<timestamp> and a ZIP.
  Also generates a paste-ready CIP bootstrapping preamble for new chats.

.PARAMETER Tier
  Scope of snapshot: Micro | Meso | Macro. Default: Macro
   - Micro:   FocusPath + core essentials + latest reflections
   - Meso:    Project-level: includes essentials + project readmes/docs for submodules
   - Macro:   Whole LTF context (no heavy binaries), excludes node_modules, dist, etc.

.PARAMETER FocusPath
  Optional path to a focal artifact (file or folder) for Micro/Meso tiers.

.PARAMETER OutDir
  Output directory (relative to repo root). Default: context-snapshots

.PARAMETER Notes
  Optional freeform notes to embed in Snapshot.md for later recall.

.PARAMETER RefLines
  How many lines to include from reflections/reflective_checkpoints.md (tail). Default: 120

.EXAMPLE
  pwsh tools/context/Save-LTFContext.ps1 -Tier Macro -Notes "End-of-week sync"

.EXAMPLE
  pwsh tools/context/Save-LTFContext.ps1 -Tier Micro -FocusPath projects/ai-thought-capture/README.md
#>

param(
  [ValidateSet("Micro","Meso","Macro")]
  [string]$Tier = "Macro",
  [string]$FocusPath,
  [string]$OutDir = "context-snapshots",
  [string]$Notes = "",
  [int]$RefLines = 120
)

$ErrorActionPreference = "Stop"

function Assert-RepoRoot {
  if (-not (Test-Path "core/manifest.yaml")) {
    throw "Run from LTF repo root (core/manifest.yaml not found)."
  }
}

function New-CleanDir($Path) {
  if (-not (Test-Path $Path)) { New-Item -ItemType Directory -Path $Path | Out-Null }
}

function Get-IfExists { param([string]$p) if (Test-Path $p) { $p } }

function Select-ReflectionsTail($Path, $Lines) {
  if (-not (Test-Path $Path)) { return "" }
  $content = Get-Content -Raw $Path
  $rows = $content -split "`r?`n"
  $tail = $rows | Select-Object -Last $Lines
  return ($tail -join "`n")
}

Assert-RepoRoot

$ts = Get-Date -Format "yyyy-MM-dd_HHmmss"
$base = Join-Path $OutDir $ts
$stage = Join-Path $base "stage"
$zipPath = Join-Path $OutDir ("LTF_Context_{0}_{1}.zip" -f $Tier.ToLower(), $ts)

# Create dirs
New-CleanDir $OutDir
New-CleanDir $base
New-CleanDir $stage

# Build include list
$include = New-Object System.Collections.Generic.List[string]

# Always-include essentials
$essentials = @(
  "README.md",
  "CONTRIBUTING.md",
  "core/manifest.yaml",
  "core/taxonomy/Glossary.md",
  "core/architecture/LTF_Concept_Map_v0.91.md",
  "reflections/reflective_checkpoints.md",
  ".gitattributes",
  ".gitignore"
) | Where-Object { Test-Path $_ }

$include.AddRange($essentials)

# Tier-specific
switch ($Tier) {
  "Micro" {
    if ($FocusPath) {
      if (-not (Test-Path $FocusPath)) { throw "FocusPath not found: $FocusPath" }
      $include.Add($FocusPath)
    }
    # keep it lean
  }
  "Meso" {
    if ($FocusPath -and (Test-Path $FocusPath)) { $include.Add($FocusPath) }
    # include submodule docs/readmes if present
    foreach ($p in @("projects/ai-thought-capture","projects/ehr-consent-platform","projects/reflective-dashboard")) {
      if (Test-Path $p) {
        foreach ($f in @("README.md","docs","DOCUMENTATION.md")) {
          $fp = Join-Path $p $f
          if (Test-Path $fp) { $include.Add($fp) }
        }
      }
    }
    foreach ($d in @("education","research","analytics")) {
      if (Test-Path $d) { $include.Add($d) }
    }
  }
  "Macro" {
    foreach ($d in @("core","education","research","analytics","reflections","tools")) {
      if (Test-Path $d) { $include.Add($d) }
    }
    # light touch on projects: include readmes to avoid heavy deps
    foreach ($p in @("projects/ai-thought-capture","projects/ehr-consent-platform","projects/reflective-dashboard","projects/examples")) {
      if (Test-Path $p) {
        foreach ($f in @("README.md","docs","DOCUMENTATION.md")) {
          $fp = Join-Path $p $f
          if (Test-Path $fp) { $include.Add($fp) }
        }
      }
    }
  }
}

# Exclusions (globally)
$excludePatterns = @("node_modules","dist","coverage",".git",".githooks","*.log","assets/media")

# Helper function to check if path should be excluded
function Test-ShouldExclude($Path) {
  foreach ($pattern in $excludePatterns) {
    if ($Path -like "*$pattern*") { return $true }
  }
  return $false
}

# Copy preserving structure, deduplicate first
$uniqueIncludes = $include | Select-Object -Unique
foreach ($item in $uniqueIncludes) {
  if (-not (Test-Path $item)) { continue }
  if (Test-ShouldExclude $item) { continue }
  
  $dest = Join-Path $stage $item
  if (Test-Path $item -PathType Container) {
    # Recursively copy directory, manually filtering exclusions
    Get-ChildItem $item -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
      $relPath = $_.FullName.Substring((Resolve-Path $item).Path.Length).TrimStart('\','/')
      if (-not (Test-ShouldExclude $relPath)) {
        $targetPath = Join-Path $dest $relPath
        if ($_.PSIsContainer) {
          New-Item -ItemType Directory -Path $targetPath -Force -ErrorAction SilentlyContinue | Out-Null
        } else {
          New-Item -ItemType Directory -Path (Split-Path $targetPath) -Force -ErrorAction SilentlyContinue | Out-Null
          Copy-Item $_.FullName $targetPath -Force -ErrorAction SilentlyContinue
        }
      }
    }
  } else {
    New-Item -ItemType Directory -Path (Split-Path $dest) -Force -ErrorAction SilentlyContinue | Out-Null
    Copy-Item $item $dest -Force -ErrorAction SilentlyContinue
  }
}

# Create Snapshot.md
$snap = @()
$snap += "# LTF Context Snapshot"
$snap += ""
$snap += "- **Timestamp:** $ts"
$snap += "- **Tier:** $Tier"
if ($FocusPath) { $snap += "- **FocusPath:** $FocusPath" }
if ($Notes) { $snap += "- **Notes:** $Notes" }
$snap += ""
$snap += "## Included Paths (unique)"
$snap += ""
$relPaths = (Get-ChildItem -Recurse $stage -File | ForEach-Object { 
  $_.FullName.Substring($stage.Length).TrimStart('\','/') 
} | Sort-Object -Unique)
$snap += ($relPaths | ForEach-Object { "* $_" })
$snap += ""
$snap += "## Recent Reflections (tail)"
$snap += ""
$snap += "```md"
$snap += (Select-ReflectionsTail "reflections/reflective_checkpoints.md" $RefLines)
$snap += "```"
$snap += ""
$snap += "## CIP Bootstrapping Preamble"
$snap += ""
$snap += "Copy the block below into a new chat to rehydrate context."
$snap += ""
$snap += "```text"
$snap += "You are resuming a Living Task Framework (LTF) collaboration."
$snap += "Use the snapshot below as background, not as a conversation replay."
$snap += ""
$snap += "Objectives:"
$snap += "1) Restore CIP-E (Contextual Intent Prompting—Extended) alignment"
$snap += "2) Preserve DMP (Directive + Meta Prompting) structure and tone"
$snap += "3) Maintain VS family semantics: VS, VSyn, VcS"
$snap += ""
$snap += "Snapshot metadata:"
$snap += "  - Timestamp: $ts"
$snap += "  - Tier: $Tier"
if ($FocusPath) { $snap += "  - FocusPath: $FocusPath" }
$snap += ""
$snap += "Key files included (relative):"
foreach ($p in $relPaths | Sort-Object | Select-Object -First 60) {
  $snap += "  - $p"
}
$snap += ""
$snap += "Recent reflections (tail):"
$snap += "(See the fenced md block in Snapshot.md for last entries.)"
$snap += "``````"

$SnapshotPath = Join-Path $base "Snapshot.md"
$snap -join "`n" | Set-Content -Path $SnapshotPath -Encoding UTF8

# Extract and write the preamble alone for easy copy
$PreamblePath = Join-Path $base "CIP_Preamble.txt"
$preambleStart = $snap.IndexOf('``````text')
$preambleEnd = $snap.LastIndexOf('``````')
if ($preambleStart -ge 0 -and $preambleEnd -gt $preambleStart) {
  $preambleLines = $snap[($preambleStart + 1)..($preambleEnd - 1)]
  $preambleLines -join "`n" | Set-Content -Path $PreamblePath -Encoding UTF8
}

# Zip - compress only the stage contents directly (not the wrapper folder)
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Compress-Archive -Path "$stage\*" -DestinationPath $zipPath

Write-Host "[✓] Snapshot created:" -ForegroundColor Green
Write-Host "    $base"
Write-Host "    ZIP: $zipPath"
Write-Host "    Snapshot.md + CIP_Preamble.txt are inside the folder."
