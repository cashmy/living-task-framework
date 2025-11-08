# Fix-MarkdownLint.ps1

PowerShell script to automatically fix common markdown linting errors in LLM-generated files.

## Fixed Linting Rules

- **MD001**: Heading levels increment by one (no jumping from h1 to h4)
- **MD010**: Hard tabs replaced with spaces
- **MD022**: Headings surrounded by blank lines
- **MD031**: Fenced code blocks surrounded by blank lines
- **MD032**: Lists surrounded by blank lines
- **MD040**: Fenced code blocks have language specified

## Usage

### Basic Usage (Creates .fixed.md file)

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath README.md
```

### Fix In-Place

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath README.md -InPlace
```

### Fix In-Place with Backup

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath README.md -InPlace -Backup
```

### Multiple Files

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath "docs/*.md"
```

### Custom Tab Width

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath file.md -TabWidth 4
```

### Custom Default Language for Code Blocks

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath file.md -DefaultLanguage python
```

## Parameters

- **FilePath** (required): Path to markdown file or glob pattern
- **TabWidth** (optional): Spaces to replace tabs with (default: 2)
- **DefaultLanguage** (optional): Language for unlabeled code blocks (default: text)
- **InPlace** (switch): Modify file directly instead of creating .fixed.md
- **Backup** (switch): Create .bak file before modifying (only with -InPlace)

## Examples

### Fix a Single File

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath myfile.md

# Creates: myfile.fixed.md

```

## Fix and Replace

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath myfile.md -InPlace -Backup

# Creates: myfile.md.bak (backup)

# Modifies: myfile.md (fixed version)

```

## Fix Documentation with Custom Settings

```powershell
pwsh tools/scripts/Fix-MarkdownLint.ps1 `

  - FilePath "docs/api/*.md" `
  - TabWidth 4 `
  - DefaultLanguage javascript `
  - InPlace

```

## What Gets Fixed

### Before

```markdown

# Title

No blank line after heading

## Skipped heading level

  Hard tab indented line
```

No language on code block

```text

- List item

No blank before/after list
```

### After

```markdown

# Title

No blank line after heading

## Skipped heading level

  Hard tab indented line

```text

No language on code block

```text

- List item

No blank before/after list
```

## Notes

- The script preserves original file encoding (UTF-8)
- Code blocks without languages get `text` by default (customizable)
- Multiple consecutive blank lines are reduced to single blank lines
- Heading level jumps are corrected progressively (h1 → h4 becomes h1 → h2)

## Integration

Use this script as part of your documentation workflow:

1. Generate markdown with LLM
2. Run Fix-MarkdownLint.ps1
3. Review and commit

Or add to pre-commit hooks for automatic fixing.
