# LTF Context Transfer Prompt

* *Generated**: 2025-11-09_143707
* *Project**: Living Task Framework
* *Work Type**: Framework Development (Meta-Work)
* *For**: New AI session (ChatGPT/Claude/Gemini)

- --

## Instructions for New AI

You are resuming a Living Task Framework (LTF) collaboration session.

* *Primary Project**: Living Task Framework (framework)
* *Primary Repository**: https://github.com/cashmy/living-task-framework
* *Branch**: main

* *Test Case Project**: EHR Consent Platform
* *Test Case Repository**: https://github.com/cashmy/ehr-consent-platform (Git submodule at `projects/ehr-consent-platform/`)

* *Previous session**: 2025-11-09_143707

- --

## Work Context

* *Type**: Framework Development (Building LTF itself)
* *Primary Target**: LTF Tooling (Save-LTFContext-v2.ps1)
* *Dogfooding**: ✓ Yes - Using LTF to build LTF

### Current Task

* *Feature**: Implement auto-detect rules for influencer file discovery
* *Files to Modify**: `tools/context/Save-LTFContext-v2.ps1` (PowerShell)
* *What This Enables**: Project manifests can use glob patterns (e.g., `"contracts/**/*.sol"`) to automatically discover influencer files instead of manually listing each one

### What This Is NOT

This is **not** about building features for the EHR consent platform product. The EHR project is merely our **test case** to validate that the auto-detect feature works correctly.

### Previous Session Progress

* *Completed**:
- ✅ Phase 5: YAML manifest parsing + project mnemonics
- ✅ Enhanced naming convention for snapshots
- ✅ Resume-LTFContext.ps1 with smart filtering
- ✅ Cognitive extraction prompts
- ✅ Transfer prompt system (this file!)

* *Current Task** (not yet started):
- [ ] Read `auto_detect.rules` from `.ltf-influencers.yaml`
- [ ] Implement glob pattern matching in PowerShell
- [ ] Test with EHR manifest (should auto-discover *.sol files)
- [ ] Support priority levels (high/medium/low) and categories

- --

## Key Influencers (Cognitive Anchors)

* *Purpose**: These files help you understand the TASK (building LTF), not the test case (EHR product).

### Framework Files (What We're Modifying)

* *tools/context/Save-LTFContext-v2.ps1**
- Role: **Modification Target** - This is the file we need to edit
- GitHub: https://github.com/cashmy/living-task-framework/blob/main/tools/context/Save-LTFContext-v2.ps1
- What it does: Creates context snapshots using influencer manifests
- What we're adding: Auto-detect rules parser + glob pattern matching
- Last Modified: 2025-11-09

* *core/.ltf-influencers.yaml.template**
- Role: **Specification** - Defines the manifest schema
- GitHub: https://github.com/cashmy/living-task-framework/blob/main/core/.ltf-influencers.yaml.template
- Shows: Structure of `auto_detect.rules` section
- Last Modified: 2025-11-08

* *core/manifest.yaml**
- Role: **Example** - LTF framework's own manifest with auto_detect rules
- GitHub: https://github.com/cashmy/living-task-framework/blob/main/core/manifest.yaml
- Shows: Example auto_detect rules with glob patterns
- Last Modified: 2025-11-09

* *core/PROJECT_MANIFESTS_STATUS.md**
- Role: **Requirements** - Feature status and requirements
- GitHub: https://github.com/cashmy/living-task-framework/blob/main/core/PROJECT_MANIFESTS_STATUS.md
- Shows: What auto-detect should do, acceptance criteria
- Last Modified: 2025-11-09

### Test Case Files (What We're Testing With)

* *projects/ehr-consent-platform/.ltf-influencers.yaml**
- Role: **Test Case** - Will use auto-detect to find *.sol files
- GitHub: https://github.com/cashmy/ehr-consent-platform/blob/main/.ltf-influencers.yaml
- Contains: Example auto_detect rule: `pattern: "contracts/**/*.sol"`
- Expected Result: Should auto-discover ConsentRegistry.sol, HospitalRegistry.sol, ProviderIdentity.sol
- Last Modified: 2025-11-09
- Note: EHR is a Git submodule within the LTF repo

* *projects/ehr-consent-platform/contracts/src/*.sol**
- Role: **Test Files** - Files that should be auto-discovered
- GitHub: https://github.com/cashmy/ehr-consent-platform/tree/main/contracts/src
- Pattern to match: `contracts/**/*.sol`
- Should be categorized as: `smart_contracts` with priority `high`

- --

## Implementation Guidance

### What You Need To Do

1. **Read the manifest** - Parse `auto_detect.rules` from YAML
2. **Match glob patterns** - PowerShell has `Get-ChildItem -Path -Filter` and `-Include/-Exclude`
3. **Apply rules** - For each pattern, find matching files and assign category/priority
4. **Merge with manual** - Auto-detected files supplement (don't replace) manually listed influencers
5. **Test** - Run against EHR manifest, verify *.sol files are discovered

### PowerShell Glob Pattern Matching

```powershell

# Example of glob matching in PowerShell

$files = Get-ChildItem -Path "projects/ehr-consent-platform" -Recurse -Include "*.sol"

# or using Filter:

$files = Get-ChildItem -Path "projects/ehr-consent-platform/contracts" -Recurse -Filter "*.sol"
```

## Expected Manifest Structure

```yaml
auto_detect:
  enabled: true
  rules:

    - pattern: "contracts/**/*.sol"

      category: "smart_contracts"
      priority: high

    - pattern: "docs/compliance/**/*.md"

      category: "compliance"
      priority: high
```

### Integration Point

Look for function `Build-InfluencerReferences` in Save-LTFContext-v2.ps1 - this is where you'll add auto-detect logic.

- --

## Framework Context

This project uses Living Task Framework methodologies:

* **CIP-E** (Contextual Intent Prompting Extended): Extract user intent beyond literal words
* **DMP** (Directive + Meta Prompting): Adaptive communication patterns (Template/Narrative/Hybrid)
* **VS Suite**:
  - VS (Verbalized Sampling): Mode collapse mitigation
  - VSyn (Variable Synchronicity): State alignment across contexts
  - VcS (Vector Co-Synthesis): Semantic thread tracking

* *Apply these frameworks** when understanding user requests and generating responses.

- --

## Session Continuity

* *Previous session timestamp**: 2025-11-09_143707

* *Session momentum**:
- Just completed cross-session transfer test (found gaps in transfer prompt)
- Identified that meta-work (framework development) needs explicit context
- Ready to implement auto-detect rules as next feature

* *Next immediate task**: Implement glob pattern matching in PowerShell for auto-detect rules

- --

## Next Steps

* *Ask the user**: "Ready to implement auto-detect rules for LTF manifests. Should I:
1. Start with the PowerShell glob pattern matching logic?
2. First review the manifest structure and discuss the approach?
3. Create tests first (TDD approach)?

"

* *When implementing**:
- Modify `tools/context/Save-LTFContext-v2.ps1`
- Add logic to `Build-InfluencerReferences` function
- Test with `projects/ehr-consent-platform/.ltf-influencers.yaml`
- Verify it discovers the 3 *.sol files automatically

- --

* *Ready to collaborate using LTF frameworks.**
