# Project Manifests Created

* *Date**: 2025-11-09
* *Status**: Structure complete, awaiting YAML parsing implementation

- --

## Manifests Created (5)

### 1. Framework Root - `ltf`

* *Location**: `.ltf-influencers.yaml`
* *Mnemonic**: `ltf`
* *Type**: research
* *Lifecycle**: active

* *Influencers**:
- Concept: LTF Concept Map, DMP Guide, Prompt Collection, README, CONTRIBUTING
- Taxonomy: DMP Patterns, VS Family Guide, Glossary
- Architecture: Concept Map, Pivotal Moment Design
- Documentation: Project Mnemonics, How to Use
- Recent reflections: 14 days
- Pivotal moments: All YAML files

* *Auto-detect**: Enabled (prompts, tooling, documentation)

- --

### 2. EHR Consent Platform - `ehrc`

* *Location**: `projects/ehr-consent-platform/.ltf-influencers.yaml`
* *Mnemonic**: `ehrc`
* *Type**: app
* *Lifecycle**: active

* *Influencers**:
- Architecture: System architecture, blockchain integration
- Concept: README, vision
- Smart contracts: ConsentRegistry, HospitalRegistry, ProviderIdentity
- Specifications: API specs
- Recent reflections: 14 days

* *Auto-detect**: Enabled (smart contracts, compliance docs, service docs)

- --

### 3. AI Thought Capture - `atc`

* *Location**: `projects/ai-thought-capture/.ltf-influencers.yaml`
* *Mnemonic**: `atc`
* *Type**: app
* *Lifecycle**: active

* *Influencers**:
- Concept: Concept, Problem description, Brand analysis
- Architecture: Architecture diagram
- Planning: High level tasks, Actual steps, Current CIP
- Technical: Watcher README, Purpose doc
- Core modules: watcher.py, watcher_core.py, stt_stub.py

* *Auto-detect**: Enabled (watcher code, documentation, tests)

- --

### 4. AI Collaboration Whitepaper - `accr`

* *Location**: `research/whitepapers/.ltf-influencers.yaml`
* *Mnemonic**: `accr` (AI Collaboration & Cognitive Rise)
* *Type**: whitepaper
* *Lifecycle**: archived

* *Influencers**:
- Manuscript: Cleaned MD, Final DOCX
- Planning: Outline, Citation map
- Drafts: Working versions (historical)

* *Auto-detect**: Disabled (archived project)

- --

### 5. LTF Examples - `ltfex`

* *Location**: `projects/examples/.ltf-influencers.yaml`
* *Mnemonic**: `ltfex`
* *Type**: documentation
* *Lifecycle**: maintenance

* *Influencers**:
- Documentation: README
- Examples: All markdown files (future)

* *Auto-detect**: Enabled (example files, tutorials)

- --

## Lifecycle Distribution

| Lifecycle | Projects | Behavior |
|-----------|----------|----------|
| **Active** | ltf, ehrc, atc (3) | Medium snapshots, deep cognitive |
| **Maintenance** | ltfex (1) | Low snapshots, minimal cognitive |
| **Archived** | accr (1) | No snapshots, reference only |

- --

## Mnemonic Comparison

| Full Name | Mnemonic | Savings |
|-----------|----------|---------|
| living-task-framework | ltf | 80% |
| ehr-consent-platform | ehrc | 77% |
| ai-thought-capture | atc | 83% |
| ai-collaboration-whitepaper | accr | 84% |
| ltf-examples | ltfex | 50% |

* *Average**: 75% shorter project identifiers

- --

## Example Snapshot Names

### Before (auto-derived)

```text
2025-11-09_120000-session-ehr-consent-platform-smart-contract-fix
2025-11-09_130000-burst-ai-collaboration-whitepaper-final-edits
2025-11-09_140000-test-ai-thought-capture-watcher-refactor
```

### After (with mnemonics)

```text
2025-11-09_120000-session-ehrc-smart-contract-fix
2025-11-09_130000-burst-accr-final-edits
2025-11-09_140000-test-atc-watcher-refactor
```

* *Result**: ~30 characters shorter, fits in narrow IDE panels

- --

## Next Steps

### Phase 5: YAML Parsing Implementation

* *Current state**: Manifests created but not read
* *Blocker**: ConvertFrom-InfluencerManifest uses hardcoded defaults
* *Solution options**:

1. **powershell-yaml module** (recommended)

   ```powershell
   Install-Module -Name powershell-yaml
   Import-Module powershell-yaml
   $manifest = Get-Content .ltf-influencers.yaml -Raw | ConvertFrom-Yaml
   ```

2. **Manual regex parsing** (lightweight)
   - Parse simple key-value pairs
   - Handle arrays with `- item` syntax
   - Skip nested hashtables (use defaults)

3. **External tool** (yq, python)
   - Convert YAML → JSON
   - Parse JSON in PowerShell
   - Adds dependency

* *Recommended**: Option 1 (powershell-yaml module) - robust, maintainable

- --

## Testing Plan

Once YAML parsing is implemented:

### Test 1: Framework root

```powershell
.\tools\context\Save-LTFContext-v2.ps1 -Type test -Label "yaml-parse-test"
```

* *Expected**: Reads `.ltf-influencers.yaml`, uses `ltf` mnemonic, includes pivotal_moments influencers

### Test 2: EHR project

```powershell
.\tools\context\Save-LTFContext-v2.ps1 -Project ehr-consent-platform -Type test
```

* *Expected**: Uses `ehrc` mnemonic, includes smart contract influencers

### Test 3: CLI override

```powershell
.\tools\context\Save-LTFContext-v2.ps1 -Project ai-thought-capture -Mnemonic "xyz"
```

* *Expected**: Overrides `atc` with `xyz`, still reads other manifest fields

### Test 4: Archived project

```powershell
.\tools\context\Save-LTFContext-v2.ps1 -Project ../research/whitepapers
```

* *Expected**: Uses `accr`, notes archived lifecycle, minimal snapshot

- --

## Files Created This Session

1. `core/.ltf-influencers.yaml.template` - Full template with comments
2. `.ltf-influencers.yaml` - Framework root manifest
3. `projects/ehr-consent-platform/.ltf-influencers.yaml` - EHR app
4. `projects/ai-thought-capture/.ltf-influencers.yaml` - Watcher app
5. `research/whitepapers/.ltf-influencers.yaml` - Whitepaper (archived)
6. `projects/examples/.ltf-influencers.yaml` - Examples (maintenance)
7. `core/PROJECT_MNEMONICS.md` - Mnemonic documentation

* *Total**: 7 files, ~400 lines of YAML/markdown

- --

## Session Achievements

✅ Enhanced naming convention (type-project-label)
✅ Project mnemonics (3-6 char codes)
✅ Manifest structure defined
✅ 5 real-world manifests created
✅ Lifecycle awareness (burst/active/maintenance/archived)
✅ Auto-detect rules framework
✅ Resume script with filtering
✅ Documentation complete

* *Remaining**: YAML parsing implementation (Phase 5)

- --

* *See also**:
- `core/PROJECT_MNEMONICS.md` - Mnemonic usage guide
- `core/.ltf-influencers.yaml.template` - Blank template
- `tools/context/Save-LTFContext-v2.ps1` - Implementation (TODO: YAML parsing)
