# Cross-Session Transfer Test Scenario

## Test Objective

Validate that the LTF transfer prompt enables a **new AI session** to:

1. Understand the project context
2. Continue work on a specific task
3. Maintain quality/consistency with previous session

## Test Setup

* *Previous Session Context**:
- Working on Living Task Framework improvements
- Completed Phase 5: YAML manifest parsing
- Next task: Implement auto-detect rules for influencer discovery

* *Transfer Scenario**:

User wants to switch to a new AI session and continue implementing the auto-detect rules feature.

## Test Procedure

1. **Copy** the contents of `transfer-prompt.md`
2. **Open** a new AI session (ChatGPT, Claude, or Gemini)
3. **Paste** the transfer prompt
4. **Ask**: "I need to implement the auto-detect rules feature for LTF. This allows project manifests to use glob patterns to automatically discover influencer files instead of manually listing them. Can you help me design and implement this?"

## Success Criteria

* *Context Restoration** (What should the AI understand?):
- [x] Project is EHR consent platform
- [x] It's part of Living Task Framework
- [x] Key files are smart contracts (*.sol)
- [ ] The broader LTF architecture context
- [ ] Current development state

* *Task Execution** (Can the AI deliver?):
- [ ] Understand what "auto-detect rules" means
- [ ] Propose implementation approach
- [ ] Ask relevant clarifying questions
- [ ] Generate working code/configuration

* *Quality Indicators**:
- [ ] AI references the influencer files appropriately
- [ ] AI asks about manifest structure/syntax
- [ ] AI considers edge cases (missing files, pattern conflicts)
- [ ] Code quality matches previous session

## Observations

* *What context transferred well**:
- TBD after test

* *What was lost/unclear**:
- TBD after test

* *Time comparison**:
- Time to get AI productive with transfer prompt: ___ min
- Estimated time without transfer prompt: ___ min
- Efficiency gain: ___%

* *Improvements needed**:
- TBD after test

- --

## Alternative Test: Framework Self-Development

Instead of EHR project, test transferring context for **LTF framework development itself**:

* *Task**: "Continue implementing the auto-detect rules feature in Save-LTFContext-v2.ps1. The manifest already has an auto_detect.rules section - we need to implement the glob pattern matching logic."

This tests whether the AI can:

- Understand the meta-context (building LTF using LTF)
- Reference the correct framework files
- Continue PowerShell development
- Maintain the architecture decisions from previous sessions

* *Influencers for this scenario would be**:
- core/manifest.yaml (framework manifest with auto_detect example)
- tools/context/Save-LTFContext-v2.ps1 (script to modify)
- core/.ltf-influencers.yaml.template (manifest template)
- PROJECT_MANIFESTS_STATUS.md (feature requirements)
