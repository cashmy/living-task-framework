<!-- markdownlint-disable MD036 -->

# .ltf-influencers.yaml Schema Specification

* *Version**: 1.0
* *Purpose**: Define cognitive influencers for project context capture - the mental models, decisions, and artifacts that shape thinking, not just code.

- --

## Core Principle

* *Influencers ≠ All Files**

Influencers are the **cognitive anchors** that provide context for understanding current work:

- Concept documents (mental models)
- Architecture diagrams (decision rationale)
- Recent reflections (momentum and insights)
- Milestone trackers (where we are in the journey)

* *NOT influencers**:
- Source code (Git is the source of truth)
- Dependencies (reproducible from package files)
- Build artifacts (generated, not cognitive)

- --

## Schema Structure

```yaml

# Project metadata

project:
  name: "project-name"
  type: "software|whitepaper|research|education"
  repo: "https://github.com/owner/repo"  # Primary Git repository
  branch: "main"  # Default branch for file references

# Optional: Additional repositories if project spans multiple

repos:

  - name: "contracts-repo"

    url: "https://github.com/owner/contracts"
    branch: "develop"

# Influencer categories (all optional - include only what exists)

influencers:

  # Core concept documents - mental models shaping the project
  concept:

    - "Current_CIP.md"
    - "docs/architecture/consent-model.md"

  # Architecture artifacts - decision rationale and system design
  architecture:

    - "docs/architecture/consent-flow-diagram.md"
    - "contracts/interfaces/IConsentRegistry.sol"  # Interfaces as contracts

  # Milestone tracking - project lifecycle context (optional for burst projects)
  milestones:

    - "docs/milestone-tracker.md"

  # Recent reflections - momentum, insights, decisions
  recent_reflections:
    max_age_days: 7  # How far back to look
    path_pattern: "../../reflections/logs/*{project-name}*.md"

  # Cross-project bridges - insights from other domains
  bridges:

    - "../../reflections/bridges/*-to-{project-name}-*.md"
    - "../../reflections/bridges/*-from-{project-name}-*.md"

  # Project-specific additions (custom categories)
  compliance:  # Example: For regulated projects

    - "docs/compliance/HIPAA-mapping.md"

  research:  # Example: For research projects

    - "research/hypothesis.md"
    - "research/experiment-log.md"

# Auto-detection rules (optional - augment manual declarations)

auto_detect:
  enabled: true

  patterns:
    # Standard concept file patterns
    concept:

      - "**/*Concept*.md"
      - "**/Current_CIP*.md"
      - "**/*Mental_Model*.md"

    # Architecture documentation
    architecture:

      - "**/architecture/**/*.md"
      - "**/design/**/*.md"
      - "**/*_diagram.md"

    # Milestone tracking
    milestones:

      - "**/*milestone*.md"
      - "**/*roadmap*.md"
      - "**/CHANGELOG.md"

  # Exclusions - never auto-detect these
  exclude:

    - "**/node_modules/**"
    - "**/dist/**"
    - "**/build/**"
    - "**/.git/**"
    - "**/test/**"
    - "**/tests/**"

# Lifecycle context (optional - helps determine which influencers matter)

lifecycle:
  phase: "active|maintenance|archived|burst"

  # For burst projects (e.g., whitepapers written in 1-2 sessions)
  burst_config:
    skip_milestones: true
    reflection_window_hours: 48  # Only very recent reflections

  # For long-running projects
  active_config:
    include_milestones: true
    reflection_window_days: 14

# Cross-AI file access hints

file_access:
  # How to construct URLs for browser-based AIs
  github_blob_template: "{repo}/blob/{branch}/{path}"
  github_raw_template: "{repo}/raw/{branch}/{path}"

  # Local path for VS Code / file-system AIs
  local_root: "."  # Relative to this manifest file

# VcS semantic continuity (optional - track project-specific terminology)

vcs_seeds:
  persistent_concepts:

    - "consent"
    - "HIPAA"
    - "blockchain"

  terminology_guide:
    "privacy": "We evolved this to 'zero-knowledge proofs' for technical precision"
    "revocation": "Now part of 'consent lifecycle management'"

# Metadata

manifest:
  version: "1.0"
  created: "2025-11-09"
  last_updated: "2025-11-09"
  auto_generated: false  # True if created by tooling
```

- --

## Field Specifications

### Project Section

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Project identifier (folder name convention) |
| `type` | enum | Yes | Project category: software, whitepaper, research, education |
| `repo` | URL | Yes | Primary Git repository URL (for cross-AI file access) |
| `branch` | string | No | Default branch (defaults to "main") |

### Repos Section (Multi-Repo Projects)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Repository identifier |
| `url` | URL | Yes | Repository URL |
| `branch` | string | No | Default branch |

### Influencers Section

* *All categories optional** - include only what exists for your project

* *Standard Categories**:
- `concept`: Core mental models and conceptual frameworks
- `architecture`: Design decisions, diagrams, system models
- `milestones`: Project lifecycle tracking (skip for burst projects)
- `recent_reflections`: Insights, decisions, momentum context
- `bridges`: Cross-project connections

* *Custom Categories**: Add any project-specific categories (e.g., `compliance`, `research`, `educational`)

* *Path Patterns**:
- Relative to manifest file location
- Support glob patterns: `**/*.md`, `docs/**/*.pdf`
- Support placeholders: `{project-name}` replaced at runtime

### Auto-Detect Section

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `enabled` | boolean | No | Enable auto-detection (default: true) |
| `patterns` | object | No | Category-specific glob patterns |
| `exclude` | array | No | Paths to never auto-detect |

* *Precedence**: Manual `influencers` declarations override auto-detected files

### Lifecycle Section

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `phase` | enum | No | active, maintenance, archived, burst |
| `burst_config` | object | No | Settings for burst-activity projects |
| `active_config` | object | No | Settings for long-running projects |

* *Burst Projects** (e.g., whitepaper in 1-2 sessions):
- Skip milestone tracking
- Very short reflection window (hours, not days)
- Minimal influencer set

* *Active Projects** (e.g., ongoing development):
- Include milestone trackers
- Longer reflection window (days/weeks)
- Full influencer categories

### File Access Section

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `github_blob_template` | string | No | URL template for browsable files |
| `github_raw_template` | string | No | URL template for raw file content |
| `local_root` | path | No | Root path for file-system access |

* *Templates use placeholders**:
- `{repo}`: Repository URL
- `{branch}`: Branch name
- `{path}`: File path within repo

### VcS Seeds Section

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `persistent_concepts` | array | No | Core terminology for this project |
| `terminology_guide` | object | No | Key term definitions/evolutions |

* *Purpose**: Seed VcS semantic tracking with project-specific context

- --

## Example Manifests

### Example 1: Software Project (Full-Featured)

```yaml

# projects/ehr-consent-platform/.ltf-influencers.yaml

project:
  name: "ehr-consent-platform"
  type: "software"
  repo: "https://github.com/cashmy/ehr-consent-platform"
  branch: "main"

influencers:
  concept:

    - "Current_CIP.md"
    - "docs/architecture/consent-model.md"

  architecture:

    - "docs/architecture/consent-flow-diagram.md"
    - "contracts/interfaces/IConsentRegistry.sol"

  milestones:

    - "docs/milestone-tracker.md"

  recent_reflections:
    max_age_days: 7
    path_pattern: "../../reflections/logs/*ehr-consent*.md"

  bridges:

    - "../../reflections/bridges/*-to-ehr-consent-*.md"

  compliance:

    - "docs/compliance/HIPAA-mapping.md"

auto_detect:
  enabled: true
  patterns:
    concept:

      - "**/*Concept*.md"
      - "**/Current_CIP*.md"

  exclude:

    - "**/node_modules/**"
    - "**/dist/**"

lifecycle:
  phase: "active"
  active_config:
    include_milestones: true
    reflection_window_days: 14

file_access:
  github_blob_template: "{repo}/blob/{branch}/{path}"
  local_root: "."

vcs_seeds:
  persistent_concepts:

    - "consent"
    - "HIPAA"
    - "blockchain"

  terminology_guide:
    "privacy": "Evolved to 'zero-knowledge proofs' for technical precision (2025-11-08)"

manifest:
  version: "1.0"
  created: "2025-11-09"
  last_updated: "2025-11-09"
  auto_generated: false
```

## Example 2: Burst Whitepaper Project (Minimal)

```yaml

# projects/consent-privacy-whitepaper/.ltf-influencers.yaml

project:
  name: "consent-privacy-whitepaper"
  type: "whitepaper"
  repo: "https://github.com/cashmy/living-task-framework"
  branch: "main"

influencers:
  concept:

    - "whitepaper-outline.md"

  # No milestones - single burst session

  recent_reflections:
    max_age_days: 1  # Only current session
    path_pattern: "../../reflections/logs/*whitepaper*.md"

auto_detect:
  enabled: false  # Manual only for focused work

lifecycle:
  phase: "burst"
  burst_config:
    skip_milestones: true
    reflection_window_hours: 48

file_access:
  github_blob_template: "{repo}/blob/{branch}/projects/whitepapers/{path}"
  local_root: "."

vcs_seeds:
  persistent_concepts:

    - "consent"
    - "privacy"
    - "blockchain audit"

manifest:
  version: "1.0"
  created: "2025-11-09"
  last_updated: "2025-11-09"
  auto_generated: false
```

## Example 3: LTF Framework Itself (Multi-Category)

```yaml

# .ltf-influencers.yaml (root of living-task-framework)

project:
  name: "living-task-framework"
  type: "research"
  repo: "https://github.com/cashmy/living-task-framework"
  branch: "main"

influencers:
  concept:

    - "core/architecture/LTF_Concept_Map_v0.9.md"
    - "core/DMP_Communication_Styles_Guide.md"
    - "core/LTF_Prompt_Collection.md"

  architecture:

    - "core/architecture/LTF_Concept_Map_v0.9.md"

  taxonomy:

    - "core/taxonomy/DMP_Patterns.md"
    - "core/taxonomy/VS_Family_Guide.md"
    - "core/taxonomy/Glossary.md"

  recent_reflections:
    max_age_days: 14
    path_pattern: "reflections/logs/*.md"

  operational:

    - "core/LTF_Operational_Plan_v1.md"

auto_detect:
  enabled: true
  patterns:
    concept:

      - "**/*Concept*.md"
      - "**/*Guide*.md"

    taxonomy:

      - "core/taxonomy/**/*.md"

  exclude:

    - "**/node_modules/**"
    - "**/.git/**"

lifecycle:
  phase: "active"
  active_config:
    include_milestones: false  # Framework evolution, not milestones
    reflection_window_days: 30  # Longer for research

file_access:
  github_blob_template: "{repo}/blob/{branch}/{path}"
  local_root: "."

vcs_seeds:
  persistent_concepts:

    - "CIP-E"
    - "DMP"
    - "VS"
    - "VSyn"
    - "VcS"

  terminology_guide:
    "VS": "Verbalized Sampling (Stanford research) - not Variable Systems"
    "Variable Systems": "DEPRECATED - use VSyn or VcS"

manifest:
  version: "1.0"
  created: "2025-11-09"
  last_updated: "2025-11-09"
  auto_generated: false
```

- --

## Auto-Detection Rules

When `auto_detect.enabled = true`, Save-LTFContext:

1. **Scans patterns** defined in `auto_detect.patterns`
2. **Excludes paths** matching `auto_detect.exclude`
3. **Merges with manual** declarations (manual takes precedence)
4. **Respects lifecycle** (skip milestones for burst projects)

* *Example**:

```yaml
auto_detect:
  patterns:
    concept:

      - "**/*Concept*.md"

```

Will find: `docs/architecture/DataModel_Concept.md`, `Current_CIP_Concept.md`

* *Precedence**:

```yaml

# Manual declaration

influencers:
  concept:

    - "MySpecificConcept.md"

# Auto-detect finds

# - GeneralConcept.md

# - AnotherConcept.md

# Result: All three included, manual listed first

```

- --

## File Reference Resolution

When Save-LTFContext processes influencers, it creates **references**, not copies:

### For Browser-Based AIs (ChatGPT, Claude, Gemini)

```yaml
influencers:
  concept:

    - "docs/consent-model.md"

```

Resolves to:

```text

* *Concept Influencer**: docs/consent-model.md

GitHub: https://github.com/cashmy/ehr-consent-platform/blob/main/docs/consent-model.md
```

AI can fetch via GitHub API if needed.

### For File-System AIs (VS Code Copilot)

```yaml
influencers:
  concept:

    - "docs/consent-model.md"

```

Resolves to:

```text

* *Concept Influencer**: docs/consent-model.md

Local: D:\@ehr-consent-platform\docs\consent-model.md
```

AI can read directly from file system.

### For Multi-Repo Projects

```yaml
repos:

  - name: "contracts"

    url: "https://github.com/cashmy/ehr-contracts"
    branch: "develop"

influencers:
  architecture:

    - "repo:contracts:interfaces/IConsent.sol"

```

Resolves to:

```text

* *Architecture Influencer**: interfaces/IConsent.sol (contracts repo)

GitHub: https://github.com/cashmy/ehr-contracts/blob/develop/interfaces/IConsent.sol
```

- --

## Integration with Session State

Influencers are referenced in session-state.yaml:

```yaml
session_state:
  project: "ehr-consent-platform"
  timestamp: "2025-11-09T15:30:00Z"

  influencers:
    concept:

      - path: "docs/architecture/consent-model.md"

        github_url: "https://github.com/cashmy/ehr-consent-platform/blob/main/docs/architecture/consent-model.md"
        local_path: "D:\\@ehr-consent-platform\\docs\\architecture\\consent-model.md"
        last_modified: "2025-11-08"

    architecture:

      - path: "docs/architecture/consent-flow-diagram.md"

        github_url: "https://github.com/cashmy/ehr-consent-platform/blob/main/docs/architecture/consent-flow-diagram.md"
        local_path: "D:\\@ehr-consent-platform\\docs\\architecture\\consent-flow-diagram.md"
        last_modified: "2025-11-09"

    recent_reflections:

      - path: "../../reflections/logs/2025-11-09-provider-identity.md"

        github_url: "https://github.com/cashmy/living-task-framework/blob/main/reflections/logs/2025-11-09-provider-identity.md"
        local_path: "D:\\@living-task-framework\\reflections\\logs\\2025-11-09-provider-identity.md"
        last_modified: "2025-11-09"
```

- --

## Lifecycle-Aware Influencer Selection

Different project phases need different influencers:

### Burst Project (e.g., Whitepaper in 2 Sessions)

```yaml
lifecycle:
  phase: "burst"
  burst_config:
    skip_milestones: true
    reflection_window_hours: 48
```

* *Captures**:
- ✅ Concept outline
- ✅ Very recent reflections (last 48 hours)
- ❌ Milestones (don't exist)
- ❌ Old reflections (not relevant)

### Active Development (e.g., Ongoing Software Project)

```yaml
lifecycle:
  phase: "active"
  active_config:
    include_milestones: true
    reflection_window_days: 14
```

* *Captures**:
- ✅ Concept documents
- ✅ Architecture diagrams
- ✅ Milestone tracker (critical for understanding progress)
- ✅ Recent reflections (last 2 weeks)
- ✅ Cross-project bridges

### Maintenance Phase

```yaml
lifecycle:
  phase: "maintenance"
```

* *Captures**:
- ✅ Core concept (for context)
- ✅ Architecture (for understanding)
- ⚠️ Milestones (less critical)
- ⚠️ Reflections (shorter window)

- --

## Validation Rules

* *Required**:
- `project.name`
- `project.type`
- `project.repo`

* *Optional but Recommended**:
- At least one influencer category
- `lifecycle.phase` (helps auto-tune capture)
- `vcs_seeds.persistent_concepts` (for semantic tracking)

* *Invalid Configurations**:

❌ Influencer paths outside project scope:

```yaml
influencers:
  concept:

    - "/etc/passwd"  # Absolute paths not allowed

```

❌ Conflicting lifecycle settings:

```yaml
lifecycle:
  phase: "burst"
  active_config:  # Can't have active config for burst project
    include_milestones: true
```

- --

## Usage in Save-LTFContext

```powershell

# Auto-detect manifest in current project

ltf save-context -Project ehr-consent

# Script:

# 1. Looks for projects/ehr-consent/.ltf-influencers.yaml

# 2. Loads influencer declarations

# 3. Runs auto-detection if enabled

# 4. Resolves file paths (local + GitHub URLs)

# 5. Creates references in session-state.yaml

# 6. Does NOT copy files (DRY-compliant)

```

- --

## Migration from Current Save-LTFContext

* *Current behavior** (copies everything):

```powershell
ltf save-context -Tier Macro

# Result: Copies 500 files, creates 50MB ZIP

```

* *New behavior** (references influencers):

```powershell
ltf save-context -Project ehr-consent

# Result: References 5-10 influencer files, creates ~5KB session-state.yaml

```

* *Size comparison**:
- Current: 50MB (bloated, DRY violation)
- New: 5KB (lean, references only)

- --

## Best Practices

1. **Keep influencer lists short** (5-15 files typical)
   - Quality over quantity
   - Only include files that shape understanding

2. **Use auto-detection for discovery**
   - Enable during initial setup
   - Review what it finds
   - Add meaningful files to manual declarations
   - Disable or refine patterns once stable

3. **Update when mental models change**
   - New concept document created? Add to manifest.
   - Architecture decision made? Update influencers.
   - Old reflection no longer relevant? Let time window filter it.

4. **Leverage lifecycle phases**
   - Burst: Minimal influencers, short reflection window
   - Active: Full influencers, balanced reflection window
   - Maintenance: Core influencers only

5. **Document VcS seeds**
   - Seed with 3-7 core concepts
   - Update terminology guide when concepts evolve
   - Helps new AIs understand project vocabulary quickly

- --

## Schema Evolution

* *Version 1.0** (current):
- Basic influencer categories
- Auto-detection
- Git repo integration
- Lifecycle awareness

* *Planned Version 1.1**:
- Influencer importance weights (0.0-1.0)
- Conditional influencers (only include if X)
- Influencer dependency graphs
- Time-based influencer rotation

* *Planned Version 2.0**:
- AI-assisted influencer recommendations
- Automatic VcS seed extraction from project
- Cross-project influencer sharing
- Influencer effectiveness metrics

- --

* *Version**: 1.0
* *Status**: Schema complete, ready for implementation
* *Next**: Create template manifests for existing LTF projects
