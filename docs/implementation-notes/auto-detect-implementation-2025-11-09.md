# Auto-Detect Implementation - Phase 6

* *Date**: 2025-11-09
* *Feature**: Automatic influencer file discovery using glob patterns
* *Status**: ✅ Implemented and Tested

- --

## Overview

Implemented auto-detect rules for the LTF influencer manifest system, allowing projects to use glob patterns to automatically discover relevant files instead of manually listing each one.

## Implementation Details

### 1. New Function: `Resolve-GlobPattern`

* *Purpose**: Converts glob patterns (e.g., `contracts/**/*.sol`) to PowerShell file searches.

* *Features**:
- Supports `**` for recursive directory matching
- Supports `*` wildcards in filenames
- Handles nested path patterns (e.g., `src/**/*.ts`)
- Returns `FileInfo` objects for matching files

* *Example**:

```powershell
Resolve-GlobPattern -Pattern "contracts/**/*.sol" -BasePath "projects/ehr-consent-platform"

# Returns: All .sol files under contracts/ recursively

```

## 2. New Function: `Invoke-AutoDetectRules`

* *Purpose**: Reads `auto_detect.rules` from manifest and applies pattern matching.

* *Features**:
- Checks if auto-detect is enabled
- Iterates through all rules
- Matches glob patterns against filesystem
- Assigns category and priority from rules
- Provides console feedback on discovery progress

* *Example**:

```powershell
$discovered = Invoke-AutoDetectRules -Manifest $manifest -ProjectRoot "projects/ehr-consent-platform"

# Returns: Array of discovered files with metadata

```

## 3. Enhanced Function: `Build-InfluencerReferences`

* *Changes**:
- Now runs in **two phases**:
  1. **Phase 1**: Process manually specified influencers
  2. **Phase 2**: Apply auto-detect rules
- Tracks added files to **prevent duplicates**
- Manual files take precedence (auto-detect supplements, not replaces)
- Adds metadata to each reference:
  - `source`: "manual" or "auto-detect"
  - `priority`: from auto-detect rule (high/medium/low)
  - `rule_pattern`: which glob pattern matched

### 4. Enhanced Console Output

* *Added**:
- Auto-detect scan progress per rule
- File count for each rule match
- Source breakdown (manual vs auto-detected)
- Duplicate detection messages

* *Example Output**:

```text
[2/6] Resolving influencer references...
  [✓] Auto-detect enabled: 3 rule(s)
    Scanning: contracts/src/**/*.sol -> smart_contracts (high)
      [✓] Found 3 file(s)
    Scanning: docs/compliance/**/*.md -> compliance (high)
      [✓] Found 1 file(s)
  [✓] Auto-detected 7 file(s)
    [i] Skipping contracts/src/ConsentRegistry.sol (already in manual list)
  ✓ Influencers identified: 8

    - smart_contracts: 3 files
    - compliance: 1 files

  [i] Sources: 4 manual, 4 auto-detected
```

### 5. Enhanced YAML Output

* *session-state.yaml** now includes:

```yaml
influencers:
  smart_contracts:

    - path: "contracts/src/ConsentRegistry.sol"

      github_url: "..."
      source: "auto-detect"
      priority: "high"
      rule_pattern: "contracts/**/*.sol"
```

- --

## Test Results

### Test Case: EHR Consent Platform

* *Manifest Rules**:

```yaml
auto_detect:
  enabled: true
  rules:

    - pattern: "contracts/src/**/*.sol"

      category: "smart_contracts"
      priority: high

    - pattern: "docs/compliance/**/*.md"

      category: "compliance"
      priority: high

    - pattern: "services/**/README.md"

      category: "service_docs"
      priority: medium
```

* *Results**:
- ✅ Discovered 3 `.sol` files (ConsentRegistry, HospitalRegistry, ProviderIdentity)
- ✅ Discovered 1 compliance doc (README.md)
- ✅ Discovered 3 service READMEs (auth-service, consent-indexer, services root)
- ✅ Correctly skipped duplicates (smart contracts were manually listed)
- ✅ Total: 4 manual + 4 auto-detected = 8 influencers

* *Snapshot Created**: `context-snapshots/2025-11-09_152519-test-ehrc-auto-detect-validation/`

- --

## Design Decisions

### 1. Manual Takes Precedence

* *Why**: If a file is manually listed, it's intentional. Auto-detect supplements but doesn't override.

* *Implementation**: Track added paths in hashtable, skip auto-detected duplicates.

### 2. Glob Pattern Support

* *Supported**:
- `**` - Recursive directory matching
- `*` - Single-level wildcard
- Nested patterns like `src/**/*.ts`

* *Not Supported** (future enhancement):
- Character classes `[a-z]`
- Negation `!exclude.md`
- OR patterns `{*.ts,*.js}`

### 3. Category and Priority

* *Category**: Defines the semantic grouping (e.g., "smart_contracts", "compliance")
* *Priority**: Hints at importance (high/medium/low) - could be used for:
- Prioritizing which files to load first
- Highlighting critical influencers in transfer prompts
- Limiting snapshot size by priority threshold

- --

## Usage Example

### Project Manifest

```yaml
project:
  name: "my-project"
  mnemonic: "myp"

influencers:
  # Manual influencers (always included)
  concept:

    - "README.md"
    - "docs/vision.md"

auto_detect:
  enabled: true
  rules:
    # Auto-discover all TypeScript interfaces

    - pattern: "src/**/*.interface.ts"

      category: "interfaces"
      priority: high

    # Auto-discover API specs

    - pattern: "docs/api/**/*.yaml"

      category: "api_specs"
      priority: medium
```

### Running Context Save

```powershell
pwsh tools/context/Save-LTFContext-v2.ps1 -Project my-project -Type session -Label "api-refactor"
```

### Expected Result

Console shows:

```text
  [✓] Auto-detect enabled: 2 rule(s)
    Scanning: src/**/*.interface.ts -> interfaces (high)
      [✓] Found 12 file(s)
    Scanning: docs/api/**/*.yaml -> api_specs (medium)
      [✓] Found 5 file(s)
  [✓] Auto-detected 17 file(s)
```

session-state.yaml contains:

- 2 manual influencers (concept)
- 17 auto-detected influencers (12 interfaces + 5 API specs)

- --

## Future Enhancements

### Phase 6.1: Advanced Glob Patterns

- Support `{*.ts,*.js}` (OR patterns)
- Support `!exclude` (negation)
- Support `[a-z]` (character classes)

### Phase 6.2: Performance Optimization

- Cache file system scans
- Parallel rule processing
- Incremental updates (only scan changed files)

### Phase 6.3: Smart Prioritization

- Use priority to limit snapshot size
- Auto-filter low-priority files for large projects
- Suggest priority adjustments based on file age/size

### Phase 6.4: Rule Validation

- Warn if rule matches no files
- Suggest better patterns
- Detect overlapping rules

- --

## Files Modified

1. **tools/context/Save-LTFContext-v2.ps1**
   - Added `Resolve-GlobPattern` function (75 lines)
   - Added `Invoke-AutoDetectRules` function (65 lines)
   - Enhanced `Build-InfluencerReferences` function (+80 lines)
   - Enhanced console output (+15 lines)
   - Enhanced YAML generation (+10 lines)

2. **Test Files Created**:
   - `context-snapshots/2025-11-09_152519-test-ehrc-auto-detect-validation/`

- --

## Compatibility

- ✅ PowerShell 5.1+
- ✅ PowerShell Core 7.x
- ✅ Windows, Linux, macOS
- ✅ Backward compatible (projects without auto_detect still work)

- --

## Conclusion

Auto-detect rules are now fully functional and tested. Projects can use glob patterns to automatically discover influencer files, reducing manual maintenance and ensuring all relevant files are captured in context snapshots.

* *Next Steps**:
1. Update documentation (README, manifest template)
2. Add to PROJECT_MANIFESTS_STATUS.md as completed
3. Consider implementing Phase 6.1 enhancements
