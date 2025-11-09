# Transfer Prompt v2.1 Improvements

## What Changed

### 1. Added Work Context Section

* *Before**: Only showed "Project: ehr-consent-platform"
* *After**:

```markdown

* *Work Type**: Framework Development (Building LTF itself)
* *Primary Target**: LTF Tooling (Save-LTFContext-v2.ps1)
* *Dogfooding**: ✓ Yes - Using LTF to build LTF

```

### 2. Added Current Task Summary

* *Before**: No task context
* *After**:

```markdown

* *Feature**: Implement auto-detect rules for influencer file discovery
* *Files to Modify**: tools/context/Save-LTFContext-v2.ps1 (PowerShell)
* *What This Enables**: Project manifests can use glob patterns...

* *What This Is NOT**: Building EHR product features

```

### 3. Categorized Influencers by Role

* *Before**: Flat list of files
* *After**:

```markdown

### Framework Files (What We're Modifying)

- Role: **Modification Target**
- Role: **Specification**
- Role: **Example**

### Test Case Files (What We're Testing With)

- Role: **Test Case**
- Expected Result: Should auto-discover *.sol files

```

### 4. Added Previous Session Progress

* *Before**: "TODO: Phase 2 will include..."
* *After**:

```markdown

* *Completed**:
- ✅ Phase 5: YAML manifest parsing
- ✅ Resume-LTFContext.ps1 with smart filtering

* *Current Task** (not yet started):
- [ ] Read auto_detect.rules from manifest
- [ ] Implement glob pattern matching

```

### 5. Added Implementation Guidance

* *Before**: Generic "reference files as needed"
* *After**:

```markdown

## Implementation Guidance

### What You Need To Do

1. Read the manifest
2. Match glob patterns
3. Apply rules
4. Merge with manual
5. Test

### PowerShell Glob Pattern Matching

```powershell

$files = Get-ChildItem -Path "..." -Recurse -Include "*.sol"

```text

### Integration Point

Look for function `Build-InfluencerReferences`
```

- --

## Test Procedure

1. **Copy** the enhanced transfer prompt (in your clipboard now)
2. **Open** a new AI session (ChatGPT, Claude, Gemini)
3. **Paste** the enhanced prompt
4. **Ask** the same question: "Help me implement auto-detect rules for the EHR consent platform manifest"
5. **Observe**: Does the AI now understand it's framework development, not product work?

- --

## Expected Improvements

### AI Should Now:

- ✅ Understand this is meta-work (building LTF framework)
- ✅ Know to modify Save-LTFContext-v2.ps1 (PowerShell)
- ✅ Recognize EHR project is just a test case
- ✅ Propose PowerShell glob pattern matching
- ✅ Reference the right files (manifest template, not smart contracts)
- ✅ Ask about PowerShell implementation details

### AI Should NOT:

- ❌ Generate TypeScript code for EHR product
- ❌ Build a runtime consent manifest detector
- ❌ Focus on HIPAA/GDPR compliance features
- ❌ Suggest adding API endpoints or services

- --

## Success Criteria

* *Minimal Success** (50%):
- AI proposes PowerShell solution (not TypeScript)
- References Save-LTFContext-v2.ps1

* *Good Success** (75%):
- Understands it's framework work
- Proposes glob pattern approach
- Asks about manifest structure

* *Excellent Success** (95%):
- Immediately ready to modify the right file
- Proposes implementation for Build-InfluencerReferences
- Offers to test with EHR manifest
- Quality matches our current session standards

- --

## Additional Files to Include

* *Answer to your question**: With these improvements, the transfer prompt should be sufficient.

However, if the AI still struggles, you could **also upload**:

1. **Save-LTFContext-v2.ps1** (the actual file to modify)
   - Large file (~1400 lines)
   - But AI can read it to understand current implementation
   - Helpful for proposing specific code changes

2. **core/.ltf-influencers.yaml.template** (manifest schema)
   - Shows auto_detect structure
   - Small file, easy to include

3. **Previous session reflection** (optional)
   - Shows our recent work on Phase 5
   - Provides more context about development patterns

* *Recommendation**: Try with just the enhanced transfer prompt first. If AI still misunderstands, then add Save-LTFContext-v2.ps1.

- --

## Ready to Test!

The enhanced transfer prompt is in your clipboard. Give it a try!
