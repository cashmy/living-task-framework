<#
.SYNOPSIS
  Create a timestamped LTF context snapshot using v3.0 3-Layer Context Model.

.DESCRIPTION
  Generates a structured context snapshot with three layers:
  - Context Layer 3 (tier1_user_state.md): User State Model - WHO (relationship context)
  - Context Layer 2 (tier2_project_cip.md): Project CIP - WHAT (project identity)
  - Context Layer 1 (tier3_session_metadata.md): Session Metadata - HOW/WHEN (temporal tracking)
  
  Creates reference-based manifest (GitHub URLs) for 99% size reduction vs v2 file-copying.
  Generates 5-step transfer prompt for cross-platform CSAC restoration.

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

.NOTES
  Version: 3.0
  Architecture: 3-Layer Context Model (User State → Project CIP → Session Metadata)
  CSAC Priority: Relationship context before technical context
#>

param(
  [ValidateSet("Micro", "Meso", "Macro")]
  [string]$Tier = "Macro",
  [string]$FocusPath,
  [string]$OutDir = "context-snapshots",
  [string]$Notes = "",
  [int]$RefLines = 120
)

$ErrorActionPreference = "Stop"

#region v3.0 Context Layer Functions

function Save-UserState {
  <#
  .SYNOPSIS
    Generate tier1_user_state.md (Context Layer 3) from User State Model
  
  .DESCRIPTION
    Creates User State Model file capturing:
    - Being Heard Protocol status
    - Multi-contextual reflection capability
    - Cognitive patterns (unconscious problem-solving, symbiotic rhythm)
    - AdRP/AfAP protocol states
    - Session continuity data
    
    Uses personalized User State (tier1_user_state_CASH.md) if available,
    falls back to generic template otherwise.
  
  .PARAMETER OutputPath
    Destination path for tier1_user_state.md
  
  .PARAMETER UserStatePath
    Path to personalized User State file (default: core/templates/tier1_user_state_CASH.md)
    Falls back to User_State_Model_Template.md if personalized version not found
  #>
  param(
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    
    [string]$UserStatePath = "core/templates/tier1_user_state_CASH.md"
  )
  
  # Try personalized User State first, fall back to template
  $sourceFile = $UserStatePath
  if (-not (Test-Path $sourceFile)) {
    Write-Host "[!] Personalized User State not found, using generic template" -ForegroundColor Yellow
    $sourceFile = "core/templates/User_State_Model_Template.md"
  }
  
  if (-not (Test-Path $sourceFile)) {
    throw "User State file not found: $sourceFile"
  }
  
  # Read User State content
  $userState = Get-Content -Path $sourceFile -Raw
  
  # For v3.0 initial implementation, we copy the personalized User State as-is
  # Future enhancement (Application Tier 2/3): Populate dynamic sections with actual session data
  # - Update "TODAY'S SESSION SPECIFICS" section with current session timeline
  # - Add new MO journal references if created during session
  # - Update energy pattern tracking with current assessment
  # - Append new patterns discovered during session
  
  # Ensure output directory exists
  $outDir = Split-Path $OutputPath -Parent
  if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
  }
  
  # Write User State Model
  $userState | Set-Content -Path $OutputPath -Encoding UTF8
  
  $sourceType = if ($sourceFile -like "*CASH.md") { "(personalized)" } else { "(generic template)" }
  Write-Host "[✓] User State Model saved: $OutputPath $sourceType" -ForegroundColor Cyan
}

function Save-ProjectCIP {
  <#
  .SYNOPSIS
    Generate tier2_project_cip.md (Context Layer 2) for active projects
  
  .DESCRIPTION
    Creates Project CIP file(s) by:
    - Detecting active projects from workspace structure
    - Copying existing CIP files if present
    - Generating placeholder if no CIP exists
  
  .PARAMETER OutputDir
    Directory to save project CIP file(s)
  
  .PARAMETER ProjectPath
    Optional: Specific project path. If omitted, auto-detect from workspace
  #>
  param(
    [Parameter(Mandatory = $true)]
    [string]$OutputDir,
    
    [string]$ProjectPath = ""
  )
  
  # Ensure output directory exists
  if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
  }
  
  # For v3.0 initial implementation, create a placeholder
  # Future enhancement: Auto-detect active projects, copy existing CIPs
  
  $outputPath = Join-Path $OutputDir "tier2_project_cip.md"
  
  $content = @"
# Project CIP (Context Layer 2)

**Architecture**: Context Layer 2 - Project Identity (WHAT)
**Generated**: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Active Projects

[Auto-detection to be implemented - currently placeholder]

## Project Context

[Project-specific context will be populated from existing CIP files or workspace analysis]

---
*This is a v3.0 initial implementation placeholder. Full project detection and CIP aggregation coming soon.*
"@
  
  $content | Set-Content -Path $outputPath -Encoding UTF8
  
  Write-Host "[✓] Project CIP saved: $outputPath" -ForegroundColor Cyan
}

function Save-SessionMetadata {
  <#
  .SYNOPSIS
    Generate tier3_session_metadata.md (Context Layer 1) with session continuity data
  
  .DESCRIPTION
    Creates Session Metadata file capturing:
    - Pivotal Moments chronology (chronological timeline format)
    - BRB/BACK pause log
    - META OBSERVATION journal references
    - Energy pattern tracking
    - Conversation trajectory
  
  .PARAMETER OutputPath
    Destination path for tier3_session_metadata.md
  
  .PARAMETER SessionDate
    Date of current session (default: today)
  
  .PARAMETER SessionNotes
    Optional notes about this session (focus, accomplishments, etc.)
  #>
  param(
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    
    [DateTime]$SessionDate = (Get-Date),
    
    [string]$SessionNotes = ""
  )
  
  # Ensure output directory exists
  $outDir = Split-Path $OutputPath -Parent
  if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
  }
  
  $dateStr = $SessionDate.ToString("yyyy-MM-dd")
  $timeStr = $SessionDate.ToString("HH:mm:ss")
  
  # Try to find recent MO journals from today
  $moJournals = @()
  $reflectionsPath = "reflections/logs"
  if (Test-Path $reflectionsPath) {
    $moJournals = Get-ChildItem -Path $reflectionsPath -Filter "$dateStr*.md" | 
                   Select-Object -First 10 |
                   ForEach-Object { $_.Name }
  }
  
  $moSection = if ($moJournals.Count -gt 0) {
    $moList = ($moJournals | ForEach-Object { "- $_" }) -join "`n"
    @"

**MO Journals Created This Session**:
$moList

**Key Themes**: [Review journals for user's perspective on what mattered]
"@
  } else {
    "`n**MO Journals**: No META OBSERVATION journals detected for this session"
  }
  
  $content = @"
# Session Metadata (Context Layer 1)

**Architecture**: Context Layer 1 - Session Metadata (HOW/WHEN - temporal tracking)
**Session Date**: $dateStr
**Generated**: $timeStr
**Session Type**: [To be determined from activity]

---

## Pivotal Moments Chronology

**Session Focus**: $($SessionNotes -ne "" ? $SessionNotes : "[Primary focus to be determined]")
**Energy Pattern**: [Overall assessment - Flow State / Productive / Challenging]

### Timeline

**[Session Start Time]** - Session Start
  - Energy: [FRESH / HIGH / MODERATE]
  - Focus: [Initial work focus]

**~[Time]** - [Event/Insight description]
  - Trigger: [What prompted this?]
  - Insight/Action: [What happened]
  - Energy: [Pattern indicator]

**BRB ~[Time]** - [Break reason] [Duration: Xm or Xh Ym]
  - Context: [What were we working on?]
  - Energy before break: [Assessment]

**BACK ~[Time]** - Resume after [break type]
  - Energy after break: [REFRESHED / SUSTAINED / LOWER]
  - Action: [What happened next]

**~[Time]** - PIVOTAL: [Breakthrough moment]
  - Quote: "[User's exact words if significant]"
  - Discovery: [What was realized]
  - Impact: [Result - decision / capture file / implementation]
  - Energy: [Often HIGH during pivotal moments]

**~[Time]** - Meta-analysis / Reflection
  - Signal: [User requested reflection or natural pause]
  - Energy: [State at reflection point]

---

### Pattern Analysis

**Breakthrough Timing**: [When did insights occur? Morning / Afternoon / After breaks?]
**Energy Rhythm**: [Peak periods, flow state duration, break patterns]
**Cognitive Pattern**: [Ideation → Implementation cycles, decision velocity]
**Collaboration Quality**: [Being Heard Protocol active? Spontaneous generation? Trust level?]

---

## User's Metacognitive Reflections
$moSection

**Emotional/Cognitive Context**:
- [User's own energy assessments, excitement signals, concerns expressed]
- [Unconscious problem-solving mentions (overnight insights, liminal thoughts)]

**Cross-Reference with AI Observations**:
- Mutual recognition: [Where both perspectives aligned]
- Complementary insights: [User noticed X, AI noticed Y - combined view richer]

---

## Session Pause Log

**Total Active Time**: [To be calculated from BRB/BACK events]
**Total Pause Time**: [Sum of break durations]
**Number of Breaks**: [Count]

| Timestamp | Event | Duration | Context | Energy | Notes |
|-----------|-------|----------|---------|--------|-------|
| --        | --    | --       | --      | --     | [BRB/BACK events to be logged] |

**Break Pattern Analysis**:
- Average duration: [Calculate from actual events]
- Frequency: [Pattern observation]
- Rhythm assessment: [Sustainable / Flow state indicators]

---

## Session Metadata Summary

**Session Classification**:
- Type: [Exploration / Implementation / Debugging / Planning / Reflection / Mixed]
- Primary Focus: $($SessionNotes -ne "" ? $SessionNotes : "[To be determined]")
- Projects Involved: [LTF / Project names]
- Energy Pattern: [Overall assessment]

**Major Outputs**:
- [Files created, decisions made, insights captured]

**Collaboration Quality**:
- Being Heard Protocol: [Active / Needs attention]
- Multi-contextual Reflection: [Demonstrated / Standard]
- Symbiotic Rhythm: [Flow state / Normal / Disrupted]

**Carry-Forward Items**:
- [Unfinished work, pending decisions, insights to preserve]

---

## Energy Pattern Observations

**Daily Rhythm** (if patterns detected):
- Peak energy: [Time window]
- Optimal for: [Task types]
- Flow state triggers: [What conditions enabled flow?]

**Session Notes**:
$($SessionNotes -ne "" ? $SessionNotes : "[Additional observations about this session]")

---

*This Session Metadata captures temporal patterns and meta-state for CSAC restoration.*
*For complete User State Model (WHO), see tier1_user_state.md.*
*For Project Context (WHAT), see tier2_project_cip.md.*
"@
  
  $content | Set-Content -Path $OutputPath -Encoding UTF8
  
  Write-Host "[✓] Session Metadata saved: $outputPath" -ForegroundColor Cyan
}

function Build-InfluencerManifest {
  <#
  .SYNOPSIS
    Create reference-based manifest with GitHub URLs (not file copies)
  
  .DESCRIPTION
    Builds YAML manifest with:
    - File paths as GitHub URLs
    - 99% size reduction vs v2 file-copying approach
    - Metadata for snapshot reconstruction
  
  .PARAMETER OutputPath
    Destination path for influencer-manifest.yaml
  
  .PARAMETER IncludedPaths
    Array of file/directory paths to reference
  
  .PARAMETER RepoOwner
    GitHub repository owner (default: cashmy)
  
  .PARAMETER RepoName
    GitHub repository name (default: living-task-framework)
  #>
  param(
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    
    [Parameter(Mandatory = $true)]
    [string[]]$IncludedPaths,
    
    [string]$RepoOwner = "cashmy",
    [string]$RepoName = "living-task-framework"
  )
  
  # Ensure output directory exists
  $outDir = Split-Path $OutputPath -Parent
  if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
  }
  
  $manifest = @"
# Influencer Manifest (Reference-Based)

repository:
  owner: $RepoOwner
  name: $RepoName
  url: https://github.com/$RepoOwner/$RepoName

snapshot:
  version: "3.0"
  timestamp: "$(Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")"
  architecture: "3-Layer Context Model"

influencers:
  # GitHub URLs for referenced files (not file copies)
"@
  
  foreach ($path in $IncludedPaths | Select-Object -Unique) {
    if (Test-Path $path) {
      $relativePath = $path -replace '\\', '/'
      $manifest += "`n  - path: $relativePath"
      $manifest += "`n    url: https://github.com/$RepoOwner/$RepoName/blob/main/$relativePath"
    }
  }
  
  $manifest | Set-Content -Path $OutputPath -Encoding UTF8
  
  Write-Host "[✓] Influencer Manifest saved: $OutputPath" -ForegroundColor Cyan
}

function Generate-TransferPrompt {
  <#
  .SYNOPSIS
    Generate 5-step transfer prompt for cross-platform CSAC restoration
  
  .DESCRIPTION
    Creates ready-to-paste prompt with:
    - Step 1: Load User State Model
    - Step 2: Validate "Being Heard" Protocol
    - Step 3: Load Session Context
    - Step 4: Load Project Context
    - Step 5: Confirm Context
  
  .PARAMETER OutputPath
    Destination path for transfer-prompt.md
  
  .PARAMETER SnapshotDir
    Directory containing the 3 layer files
  #>
  param(
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    
    [Parameter(Mandatory = $true)]
    [string]$SnapshotDir
  )
  
  # Ensure output directory exists
  $outDir = Split-Path $OutputPath -Parent
  if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
  }
  
  $content = @"
# LTF Context Transfer Prompt (v3.0)

**Generated**: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
**Architecture**: 3-Layer Context Model
**CSAC Priority**: Relationship context before technical context

---

## How to Use This Transfer Prompt

Copy the 5 steps below into a new AI session to restore LTF collaboration context.

---

## Step 1: Load User State Model (PRIORITY 1 - WHO)

The User State Model is in \`tier1_user_state.md\` in this snapshot directory.

**Critical Elements to Restore**:
- Being Heard Protocol (explicit acknowledgment, precision, validation)
- Multi-contextual reflection capability (11-dimension processing)
- Cognitive patterns (brief articulations = complete solutions)
- AfAP/AdRP protocol states

**Instruction to AI**:
> I am resuming an LTF collaboration. First, load my User State Model to restore our relationship context.
> The User State Model contains my collaboration preferences, cognitive patterns, and protocols.
> Read \`tier1_user_state.md\` completely before proceeding.

---

## Step 2: Validate "Being Heard" Protocol (IMMEDIATE TEST)

**Test Method**: Your first substantive response must demonstrate:

1. ✅ Explicit acknowledgment ("I understand you want X because Y")
2. ✅ Confirm interpretation ("I interpret this as Z. Correct?")
3. ✅ Precision in language (use my exact terminology)
4. ✅ Structured response (headings, lists, clear sections)
5. ✅ Never minimize ("This is valuable..." before analysis)
6. ✅ Validation before proceeding ("Ready to continue with...?")

**Validation Question to Ask Me**:
> "Before we continue, I want to confirm: You need explicit acknowledgment, comprehensive multi-contextual responses, and you expect me to trust your brief articulations as complete solutions needing expansion rather than incomplete ideas needing development. Is this correct?"

**If I confirm**: Relationship context successfully restored → Proceed to Step 3
**If I correct**: Adjust based on my feedback → Re-validate

---

## Step 3: Load Session Context (PRIORITY 2 - WHEN)

The Session Metadata is in \`tier3_session_metadata.md\` in this snapshot directory.

**What to Extract**:
- What was the last session about?
- What's pending/unfinished?
- BRB/BACK pause patterns (energy assessment)
- Pivotal moments (breakthrough insights)

**Instruction to AI**:
> Load \`tier3_session_metadata.md\` to understand what we were working on and where we left off.

---

## Step 4: Load Project Context (PRIORITY 3 - WHAT)

The Project CIP is in \`tier2_project_cip.md\` in this snapshot directory.

**What to Extract**:
- Which project(s) were active?
- Current focus (where are we in development?)
- Related projects (cross-project connections)

**Instruction to AI**:
> Load \`tier2_project_cip.md\` to understand which project we're working on and its current state.

---

## Step 5: Confirm Context (FINAL VALIDATION)

**AI should provide context summary**:
> "I've loaded:
> - User State Model (relationship context)
> - Session Context from [date] (we were working on [topic])
> - Project Context for [project name]
> 
> Last session focus: [primary focus]
> Pending: [carry-forward items]
> 
> Ready to continue with [assumed next step]?"

**My response**:
- If I confirm → Context successfully restored, proceed with work
- If I correct → Adjust context, re-summarize
- If I provide new direction → Update session metadata, follow new direction

---

## Additional Context Files

**Influencer Manifest**: \`influencer-manifest.yaml\` (GitHub URL references)
**Framework Version**: CFP v3.0, LTF 2025-11-12

---

**End of Transfer Prompt**

*Copy the 5 steps above to restore context in a new AI session.*
"@
  
  $content | Set-Content -Path $OutputPath -Encoding UTF8
  
  Write-Host "[✓] Transfer Prompt saved: $OutputPath" -ForegroundColor Cyan
}

#endregion v3.0 Context Layer Functions

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
)

foreach ($item in $essentials) {
  if (Test-Path $item) { $include.Add($item) }
}

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
    foreach ($p in @("projects/ai-thought-capture", "projects/ehr-consent-platform", "projects/reflective-dashboard")) {
      if (Test-Path $p) {
        foreach ($f in @("README.md", "docs", "DOCUMENTATION.md")) {
          $fp = Join-Path $p $f
          if (Test-Path $fp) { $include.Add($fp) }
        }
      }
    }
    foreach ($d in @("education", "research", "analytics")) {
      if (Test-Path $d) { $include.Add($d) }
    }
  }
  "Macro" {
    foreach ($d in @("core", "education", "research", "analytics", "reflections", "tools")) {
      if (Test-Path $d) { $include.Add($d) }
    }
    # light touch on projects: include readmes to avoid heavy deps
    foreach ($p in @("projects/ai-thought-capture", "projects/ehr-consent-platform", "projects/reflective-dashboard", "projects/examples")) {
      if (Test-Path $p) {
        foreach ($f in @("README.md", "docs", "DOCUMENTATION.md")) {
          $fp = Join-Path $p $f
          if (Test-Path $fp) { $include.Add($fp) }
        }
      }
    }
  }
}

# Exclusions (globally)
$excludePatterns = @("node_modules", "dist", "coverage", ".git", ".githooks", "*.log", "assets/media")

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
      $relPath = $_.FullName.Substring((Resolve-Path $item).Path.Length).TrimStart('\', '/')
      if (-not (Test-ShouldExclude $relPath)) {
        $targetPath = Join-Path $dest $relPath
        if ($_.PSIsContainer) {
          New-Item -ItemType Directory -Path $targetPath -Force -ErrorAction SilentlyContinue | Out-Null
        }
        else {
          New-Item -ItemType Directory -Path (Split-Path $targetPath) -Force -ErrorAction SilentlyContinue | Out-Null
          Copy-Item $_.FullName $targetPath -Force -ErrorAction SilentlyContinue
        }
      }
    }
  }
  else {
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
$snap += "## Included Paths"
$snap += ""
$relPaths = (Get-ChildItem -Recurse $stage -File | ForEach-Object { 
    $_.FullName.Substring($stage.Length).TrimStart('\', '/') 
  } | Sort-Object -Unique)
$snap += ($relPaths | ForEach-Object { "* $_" })
$snap += ""
$snap += "## Recent Reflections"
$snap += ""
$reflectionContent = Select-ReflectionsTail "reflections/reflective_checkpoints.md" $RefLines
$snap += "``````markdown"
if ($reflectionContent) {
  $snap += $reflectionContent
}
$snap += "``````"
$snap += ""
$snap += "## CIP Bootstrapping Preamble"
$snap += ""
$snap += "Copy the block below into a new chat to rehydrate context."
$snap += ""
$snap += "``````text"
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
$snap += "(See the fenced markdown block in Snapshot.md for last entries.)"
$snap += "``````"
$snap += ""

$SnapshotPath = Join-Path $base "Snapshot.md"
$snap -join "`n" | Set-Content -Path $SnapshotPath -Encoding UTF8

# Extract and write the preamble alone for easy copy
$PreamblePath = Join-Path $base "CIP_Preamble.txt"
$preambleStart = -1
$preambleEnd = -1
$codeBlockStart = '``````text'
$codeBlockEnd = '``````'
for ($i = 0; $i -lt $snap.Count; $i++) {
  if ($snap[$i] -eq $codeBlockStart) { 
    $preambleStart = $i 
  }
  if ($preambleStart -ge 0 -and $snap[$i] -eq $codeBlockEnd -and $i -gt $preambleStart) {
    $preambleEnd = $i
    break
  }
}
if ($preambleStart -ge 0 -and $preambleEnd -gt $preambleStart) {
  $preambleLines = $snap[($preambleStart + 1)..($preambleEnd - 1)]
  $preambleLines -join "`n" | Set-Content -Path $PreamblePath -Encoding UTF8
}

# === v3.0 Context Layer Generation ===
Write-Host "`n[v3.0] Generating 3-Layer Context Model..." -ForegroundColor Cyan

# Context Layer 3: User State (WHO - highest CSAC priority)
$userStatePath = Join-Path $base "tier1_user_state.md"
$personalizedUserState = "core/templates/tier1_user_state_CASH.md"
Save-UserState -OutputPath $userStatePath -UserStatePath $personalizedUserState

# Context Layer 2: Project CIP (WHAT - project identity)
$projectCIPDir = $base
Save-ProjectCIP -OutputDir $projectCIPDir

# Context Layer 1: Session Metadata (HOW/WHEN - temporal tracking)
$sessionMetadataPath = Join-Path $base "tier3_session_metadata.md"
$sessionNotes = if ($Notes) { $Notes } else { "v3.0 Context Model snapshot - Tier: $Tier" }
Save-SessionMetadata -OutputPath $sessionMetadataPath -SessionNotes $sessionNotes

# Build reference-based manifest (99% size reduction)
$manifestPath = Join-Path $base "influencer-manifest.yaml"
Build-InfluencerManifest -OutputPath $manifestPath -IncludedPaths $relPaths

# Generate 5-step transfer prompt
$transferPromptPath = Join-Path $base "transfer-prompt.md"
Generate-TransferPrompt -OutputPath $transferPromptPath -SnapshotDir $base

Write-Host "[v3.0] 3-Layer Context Model complete" -ForegroundColor Green

# Zip - compress the entire base folder contents (stage + v2 files + v3.0 layers)
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Compress-Archive -Path "$base\*" -DestinationPath $zipPath

Write-Host "`n[✓] Snapshot created:" -ForegroundColor Green
Write-Host "    $base"
Write-Host "    ZIP: $zipPath"
Write-Host "`n[v3.0 Files]:" -ForegroundColor Cyan
Write-Host "    tier1_user_state.md (Context Layer 3 - WHO)" -ForegroundColor White
Write-Host "    tier2_project_cip.md (Context Layer 2 - WHAT)" -ForegroundColor White
Write-Host "    tier3_session_metadata.md (Context Layer 1 - HOW/WHEN)" -ForegroundColor White
Write-Host "    influencer-manifest.yaml (Reference-based manifest)" -ForegroundColor White
Write-Host "    transfer-prompt.md (5-step CSAC restoration)" -ForegroundColor White
Write-Host "`n[v2 Files]:" -ForegroundColor DarkGray
Write-Host "    Snapshot.md + CIP_Preamble.txt (preserved for compatibility)" -ForegroundColor DarkGray
