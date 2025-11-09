# Project Mnemonics - Quick Reference

## Overview

Project mnemonics are 3-6 character codes that make snapshot directory names shorter and more readable, especially in IDE side panels.

## Examples

- `ltf` - Living Task Framework
- `ehrc` - EHR Consent Platform
- `epe` - Evolution of Prompt Engineering (book)
- `atc` - AI Thought Capture
- `rdash` - Reflective Dashboard

## Priority Order

Save-LTFContext-v2.ps1 uses mnemonics in this order:

1. **CLI Parameter** (highest priority)

   ```powershell
   .\tools\context\Save-LTFContext-v2.ps1 -Mnemonic "xyz"
   ```
   Result: `2025-11-09_133804-test-xyz-label`

2. **Project Manifest** (`.ltf-influencers.yaml`)

   ```yaml
   project:
     name: "ehr-consent-platform"
     mnemonic: "ehrc"
   ```
   Result: `2025-11-09_120000-session-ehrc-label`

3. **Auto-derived from Project Name**
   - Framework root: `ltf` (hardcoded)
   - Other projects: kebab-case conversion

   `ehr-consent-platform` → `ehr-consent-platform`

## Benefits

### Before (no mnemonic)

```text
2025-11-09_130844-session-ehr-consent-platform-test-project-naming
```

- 70+ characters
- Truncated in narrow panels
- Hard to scan quickly

### After (with mnemonic)

```text
2025-11-09_130844-session-ehrc-test-project-naming
```

- 50 characters (30% shorter)
- Fully visible in side panels
- Easy to identify project at a glance

## Setting Up Mnemonics

### For New Projects

1. Copy template:

   ```powershell
   cp core\.ltf-influencers.yaml.template projects\your-project\.ltf-influencers.yaml
   ```

2. Edit manifest:

   ```yaml
   project:
     name: "your-project-name"
     mnemonic: "xyz"  # 3-6 chars
   ```

3. Save context:

   ```powershell
   .\tools\context\Save-LTFContext-v2.ps1 -Project your-project
   ```
   Result: `2025-11-09_HHMMSS-session-xyz-label`

### For Existing Projects

Add mnemonic to existing `.ltf-influencers.yaml`:

```yaml
project:
  name: "existing-project"
  mnemonic: "exp"  # ADD THIS LINE
  type: "app"
  ...
```

### One-Time Override

Use `-Mnemonic` CLI param without creating manifest:

```powershell
.\tools\context\Save-LTFContext-v2.ps1 -Project whitepaper -Mnemonic "wp" -Type burst
```

Result: `2025-11-09_HHMMSS-burst-wp-label`

## Naming Guidelines

### Good Mnemonics

- ✅ `ltf` - Lowercase, memorable
- ✅ `ehrc` - Pronounceable acronym
- ✅ `atc` - Clear abbreviation
- ✅ `rdash` - Shortened word

### Avoid

- ❌ `e-h-r-c` - Hyphens (use `ehrc`)
- ❌ `LTF` - Uppercase (use `ltf`)
- ❌ `x` - Too short, unclear
- ❌ `verylongmnemonic` - Defeats purpose

## Examples by Project Type

| Project Type | Name | Mnemonic | Rationale |
|--------------|------|----------|-----------|
| Framework | living-task-framework | `ltf` | Well-known acronym |
| App | ehr-consent-platform | `ehrc` | EHR + Consent |
| Book | evolution-prompt-engineering | `epe` | Title acronym |
| Article | ai-thought-capture | `atc` | Clear abbrev |
| Course | advanced-typescript | `adts` | Subject code style |
| Research | cognitive-architecture-study | `cas` | Lab notation style |

## Resume Script Integration

The Resume-LTF.ps1 script parses mnemonics automatically:

```powershell

# Filter by mnemonic

.\tools\context\Resume-LTF.ps1 -Project "ehrc"

# List all with mnemonics

.\tools\context\Resume-LTF.ps1 -List
```

Output:

```text
[SESSION] 2025-11-09_120000 | ehrc | smart-contract-optimization
[TEST]    2025-11-09_130000 | xyz | mnemonic-test
[PIVOTAL] 2025-11-09_114451 | ltf | first-self-validation
```

## Migration Notes

Existing snapshots without mnemonics still work:

- Old format: `2025-11-09_125644`
- New format: `2025-11-09_133804-test-xyz-label`
- Mixed naming is supported

You can manually rename old snapshots in File Explorer using F2.

- --

* *See also:**
- `core/.ltf-influencers.yaml.template` - Full manifest template
- `projects/ehr-consent-platform/.ltf-influencers.yaml` - Real example
- `tools/context/Save-LTFContext-v2.ps1` - Implementation
