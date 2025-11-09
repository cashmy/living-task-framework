# Generate enhanced transfer prompt from populated session state
param(
  [string]$SessionStatePath = "context-snapshots\2025-11-09_125942\session-state.yaml",
  [string]$OutputPath = "context-snapshots\2025-11-09_125942\transfer-prompt-ENHANCED.md"
)

# Load PowershellYaml module
if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
  Install-Module -Name powershell-yaml -Force -Scope CurrentUser
}
Import-Module powershell-yaml

# Read session state
$state = Get-Content $SessionStatePath -Raw | ConvertFrom-Yaml

# Build enhanced transfer prompt
$prompt = @"
# LTF Context Transfer Prompt (ENHANCED with Cognitive State)
**Generated**: $($state.session_metadata.timestamp)
**Project**: $($state.session_metadata.project)  
**Repository**: $($state.session_metadata.repository)

---

## META

You are entering a new AI session but continuing a deep cognitive exploration from a previous session.

**Project**: $($state.session_metadata.project) ($($state.session_metadata.type))
**Current Focus**: Testing real cognitive extraction and Phase 4 enhanced transfer prompts

---

## KEY INFLUENCERS (Cognitive Anchors)

The following files shape understanding of this project:

"@

# Add influencers
$categories = @('architecture', 'concept', 'taxonomy')
foreach ($category in $categories) {
  if ($state.influencers.$category) {
    $prompt += "`n### $($category.ToUpper())`n`n"
    foreach ($ref in $state.influencers.$category) {
      $prompt += "**$($ref.path)**`n"
      $prompt += "- GitHub: $($ref.github_url)`n"
      $prompt += "- Last Modified: $($ref.last_modified)`n`n"
    }
  }
}

$prompt += @"

---

## EMOTIONAL STATE

**Baseline**: $($state.emotional_state.baseline)
**Energy Level**: $($state.emotional_state.energy_level) (0.0-1.0 scale)

**Regulation Applied**:
"@

foreach ($reg in $state.emotional_state.regulation) {
  $prompt += "`n- **State**: $($reg.state)`n"
  $prompt += "  **Strategy**: $($reg.strategy)`n"
  $prompt += "  **Trigger**: $($reg.trigger)`n"
}

$prompt += @"


**Momentum**:
- Breakthroughs: $($state.emotional_state.momentum.breakthroughs -join ', ')
- Friction Points: $($state.emotional_state.momentum.friction_points -join ', ')
- Flow State: $($state.emotional_state.momentum.flow_state)

**Next Session Guidance**:
- Recommended Energy: $($state.emotional_state.next_session_context.recommended_energy)
- Carry Forward: $($state.emotional_state.next_session_context.carry_forward)

---

## ACTIVE DMP PATTERNS

"@

foreach ($pattern in $state.dmp_patterns) {
  $prompt += "`n### $($pattern.name) ($($pattern.form))`n"
  $prompt += "- **Instance**: $($pattern.instance)`n"
  $prompt += "- **Impact**: $($pattern.impact)`n"
  $prompt += "- **Detected At**: $($pattern.detected_at)`n"
}

$prompt += @"


---

## VCS SEMANTIC THREADS

**Persistent Concepts**: $($state.vcs_threads.persistent -join ', ')

**Evolved Threads**:
"@

foreach ($evolved in $state.vcs_threads.evolved) {
  $prompt += "`n- **From**: $($evolved.from) → **To**: $($evolved.to)`n"
  $prompt += "  **Reason**: $($evolved.reason)`n"
  $prompt += "  **When**: $($evolved.session_point)`n"
}

$prompt += "`n`n**Emergent Concepts**:`n"

foreach ($emergent in $state.vcs_threads.emergent) {
  $prompt += "`n- **$($emergent.concept)**`n"
  $prompt += "  **Introduced**: $($emergent.introduced)`n"
  $prompt += "  **Context**: $($emergent.context)`n"
  $prompt += "  **Related To**: $($emergent.related_to -join ', ')`n"
}

$prompt += "`n`n**Deprecated Concepts**:`n"

foreach ($deprecated in $state.vcs_threads.deprecated) {
  $prompt += "`n- **$($deprecated.concept)**: $($deprecated.reason) (deprecated at: $($deprecated.deprecated_at))`n"
}

$prompt += @"


---

## VSYN STATE (Process Synchronization)

``````yaml
"@

$prompt += ($state.vsyn_state | ConvertTo-Yaml)

$prompt += @"
``````

---

## PERMISSIONS GRANTED

"@

foreach ($perm in $state.vsyn_state.permissions) {
  $prompt += "`n- **Scope**: $($perm.scope)`n"
  $prompt += "  **Type**: $($perm.type)`n"
  $prompt += "  **Condition**: $($perm.condition)`n"
  $prompt += "  **Requires Justification**: $($perm.requires_justification)`n"
}

$prompt += @"


---

## PROCESS STATE

- **Phase**: $($state.vsyn_state.process_state.phase)
- **Focus**: $($state.vsyn_state.process_state.focus)
- **Momentum**: $($state.vsyn_state.process_state.momentum)
- **Blockers**: $($state.vsyn_state.process_state.blockers -join ', ')

---

## TEMPORAL SYNCHRONIZATION

**Last Checkpoint**:
- **Timestamp**: $($state.vsyn_state.last_checkpoint.timestamp)
- **Location**: $($state.vsyn_state.last_checkpoint.location)
- **Summary**: $($state.vsyn_state.last_checkpoint.summary)

**Recent Context**:
"@

foreach ($event in $state.vsyn_state.recent_context) {
  $prompt += "`n- **Event**: $($event.event)`n"
  $prompt += "  **Impact**: $($event.impact)`n"
}

$prompt += @"


---

## DIRECTIVE

Continue as **reflective co-thinker** (not summarizer). 

Preserve the momentum and collaborative patterns established above:
- Maintain autonomous action over asking permission
- Use Context Anchoring (file paths, line numbers, function names)
- Apply Emotional Co-Regulation when friction appears
- Honor Permission to Break Directive when priorities shift

---

## REFLECTIVE

Before proceeding with new work:

1. **Confirm**: Have you reconstructed the emotional baseline, active DMP patterns, and permission boundaries?
2. **Anchor**: Reference 2-3 specific VcS threads or influencer files to demonstrate context
3. **Resume**: Identify which aspect of Phase 4 testing to continue (extraction validation? manifest creation?)

---

**Ready to collaborate using full LTF cognitive state restoration.**

"@

# Save
$prompt | Set-Content -Path $OutputPath -Encoding UTF8
Write-Host "✓ Enhanced transfer prompt generated: $OutputPath" -ForegroundColor Green
Write-Host "`nFirst 20 lines:" -ForegroundColor Cyan
Get-Content $OutputPath | Select-Object -First 20
