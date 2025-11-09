# Work Context Metadata Design

* *Purpose**: Prevent AI scope creep by clearly defining what work is being done
* *Problem**: AIs confuse framework development with project development, leading to wrong implementations
* *Solution**: Explicit work_context metadata in session-state.yaml and transfer prompts

- --

## Design Requirements

### 1. Work Type Classification

* *Distinguish between:**
* **framework-development**: Building/modifying LTF tooling itself
* **project-development**: Building features in a project using LTF
* **documentation**: Writing docs, guides, architecture
* **research**: Exploration, testing, validation

* *Why**: Prevents "build the tool" vs "use the tool" confusion

### 2. Target System Identification

* *Specify what's being modified:**
- `ltf-tooling`: Save-LTFContext, Resume-LTF, core framework scripts
- `ehr-consent-platform`: The EHR product itself
- `reflective-dashboard`: Another project
- `core-documentation`: LTF docs and architecture

* *Why**: AI knows which files to edit vs. which to reference

### 3. Dogfooding Flag

* *Boolean to indicate recursive work:**
- `true`: Using LTF to build LTF itself (meta-work)
- `false`: Using LTF to build a project

* *Why**: Meta-work requires special handling (test case vs. actual work distinction)

### 4. Implementation Status Tracking

* *Track what exists vs. what's needed:**

```yaml
implementation_status:
  auto_detect_parsing: "✅ Complete (lines 604-844 in Save-LTFContext-v2.ps1)"
  auto_detect_testing: "⏳ In Progress"
  resume_snapshot_type: "❌ Not Started"
```

* *Why**: Prevents AI from re-implementing existing features

- --

## Proposed YAML Structure

### In session-state.yaml

```yaml

# =============================================================================

# WORK CONTEXT (Prevents AI Scope Creep)

# =============================================================================

work_context:
  # What kind of work is being done
  work_type: "framework-development"  # or: project-development, documentation, research

  # What system/component is being modified (primary target)
  primary_target: "ltf-tooling"  # or: ehr-consent-platform, reflective-dashboard, core-documentation

  # Secondary targets (dependencies, test cases)
  secondary_targets:

    - name: "ehr-consent-platform"

      role: "test-case"  # Used to validate framework features

    - name: "core-documentation"

      role: "reference"  # Used for context

  # Meta-work indicator
  dogfooding: true  # Using LTF to build LTF itself

  # Current task focus
  current_task:
    description: "Implement RESUME snapshot type for cross-session handoff"
    files_to_modify:

      - path: "tools/context/Save-LTFContext-v2.ps1"

        lines: "50-60 (ValidateSet), 900-1000 (New-SessionState)"
        action: "Add 'resume' type, preserve manifest copy"
    files_for_reference:

      - path: "projects/ehr-consent-platform/.ltf-influencers.yaml"

        purpose: "Example manifest structure"

  # What NOT to do (explicit boundaries)
  out_of_scope:

    - "Do not modify EHR product code (smart contracts, services)"
    - "Do not implement EHR features (consent management, compliance automation)"
    - "Focus is on framework tooling, not project functionality"

  # Implementation status (what exists, what's needed)
  implementation_status:
    auto_detect_parsing: "✅ Complete (lines 604-844)"
    auto_detect_manifest: "✅ Complete (EHR manifest has rules)"
    auto_detect_validation: "✅ Complete (tested 2025-11-09)"
    resume_snapshot_type: "⏳ In Progress"
    work_context_metadata: "🚧 Designing"
    influencer_role_categorization: "❌ Not Started"
```

## In .ltf-influencers.yaml

```yaml

# Optional: Project-level work context defaults

work_context_defaults:
  work_type: "project-development"
  primary_target: "ehr-consent-platform"
  dogfooding: false
```

- --

## Influencer Role Categorization

### Purpose

Prevent AI from modifying reference files or test cases

### Role Types

1. **modification-target** 🎯
   - Files AI should edit/implement in
   - Example: `Save-LTFContext-v2.ps1` during framework work

2. **reference** 📖
   - Files AI should read for context only
   - Example: Existing architecture docs, glossaries

3. **test-case** 🧪
   - Files used to validate changes
   - Example: EHR manifest when testing auto-detect

4. **example** 💡
   - Files showing patterns to follow
   - Example: core/.ltf-influencers.yaml.template

### Enhanced Influencer Structure

```yaml
influencers:
  framework_files:

    - path: "tools/context/Save-LTFContext-v2.ps1"

      role: "modification-target"
      purpose: "Implement RESUME snapshot type here"

  reference_files:

    - path: "core/architecture/LTF_Concept_Map_v0.91.md"

      role: "reference"
      purpose: "Framework concepts and terminology"

  test_cases:

    - path: "projects/ehr-consent-platform/.ltf-influencers.yaml"

      role: "test-case"
      purpose: "Use to validate auto-detect feature"

  examples:

    - path: "core/.ltf-influencers.yaml.template"

      role: "example"
      purpose: "Follow this structure for new manifests"
```

- --

## Transfer Prompt Enhancements

### Section: Work Context

```markdown

## Work Context

* *Type of Work**: Framework Development (building LTF tooling itself)
* *Primary Target**: LTF Tooling (Save-LTFContext-v2.ps1, Resume-LTF.ps1)
* *Dogfooding**: Yes (using LTF to build LTF)

* *Current Task**: Implement RESUME snapshot type for cross-session handoff

* *Files to Modify**:
- 🎯 `tools/context/Save-LTFContext-v2.ps1` (lines 50-60, 900-1000)

* *Files for Reference Only**:
- 📖 `core/architecture/LTF_Concept_Map_v0.91.md`
- 📖 `core/taxonomy/Glossary.md`

* *Test Cases** (do not modify):
- 🧪 `projects/ehr-consent-platform/.ltf-influencers.yaml`

* *What This Is NOT**:
- ❌ Not EHR product development
- ❌ Not implementing consent management features
- ❌ Not modifying smart contracts or services
- ✅ This is meta-work: building the framework itself

```

### Section: Implementation Status

```markdown

## Implementation Status

Before starting, know what already exists:

| Feature | Status | Location |
|---------|--------|----------|
| Auto-detect parsing | ✅ Complete | lines 604-844 |
| Auto-detect manifest | ✅ Complete | EHR .ltf-influencers.yaml |
| Auto-detect testing | ✅ Validated | 2025-11-09 test run |
| RESUME snapshot type | ⏳ **Your task** | Need to implement |
| Work context metadata | 🚧 Designing | This document |

* *Don't re-implement completed features. Focus on the task marked "Your task".**

```

- --

## Implementation Strategy

### Phase 1: RESUME Type (Immediate)

1. Add `resume` to ValidateSet
2. Copy `.ltf-influencers.yaml` if Type == "resume"
3. Generate `RESUME_README.md` with usage instructions
4. Test with framework work

### Phase 2: Work Context Metadata (Next)

5. Add `work_context` section to New-SessionState
6. Add role categorization to Build-InfluencerReferences
7. Update New-TransferPrompt to use work_context
8. Test with both framework and project work

### Phase 3: Validation (Final)

9. A/B test with ChatGPT-5 and Claude
10. Verify scope creep prevention
11. Document in TEST_RESULTS.md

- --

## Success Criteria

### For RESUME Type

- ✅ Type validation accepts "resume"
- ✅ Manifest copied into snapshot directory
- ✅ README generated with handoff instructions
- ✅ Snapshot naming: `YYYY-MM-DD_HHMMSS-resume-ltf-feature-name`

### For Scope Creep Prevention

- ✅ AI correctly identifies framework vs project work
- ✅ AI edits modification-targets, not reference/test files
- ✅ AI doesn't re-implement existing features
- ✅ 0 incidents of wrong-layer implementation in tests

- --

## Open Questions

1. **Where to store work_context defaults?**
   - Option A: In .ltf-influencers.yaml (project-level)
   - Option B: In session-state.yaml only (snapshot-level)
   * **Recommendation**: Both (manifest provides defaults, session-state can override)

2. **How granular should implementation_status be?**
   - Option A: Feature-level (auto-detect: complete)
   - Option B: Function-level (Resolve-GlobPattern: complete, Invoke-AutoDetectRules: complete)
   * **Recommendation**: Feature-level for readability, function-level in code comments

3. **Should influencer roles be required or optional?**
   - Option A: Required (fail if missing)
   - Option B: Optional (default to "reference")
   * **Recommendation**: Optional with smart defaults based on work_type

4. **How to handle multi-target scenarios?**
   - Example: Modifying both framework AND project
   * **Recommendation**: Use primary_target + secondary_targets array

- --

* *Status**: Design complete, ready for implementation
* *Next**: Implement Phase 1 (RESUME type)
* *Reviewer**: User validation before full implementation
