# LTF Extraction Prompt Templates

* *Purpose**: Reusable prompt templates for extracting cognitive state from AI sessions for context transfer and session continuity.

- --

## Template Inventory

| Template File | Purpose | Output Format | Used By |
|---------------|---------|---------------|---------|
| `session-summary.txt` | Extract session overview using VS (Verbalized Sampling) | Multiple perspectives with probabilities | Save-LTFContext, manual handoff |
| `dmp-patterns.txt` | Identify active DMP patterns from conversation | YAML structured pattern list | Save-LTFContext, pattern analysis |
| `vcs-threads.txt` | Track semantic thread evolution | YAML VcS thread schema | Save-LTFContext, semantic tracking |
| `emotional-state.txt` | Capture emotional/energy baseline | YAML emotional state | Save-LTFContext, VSyn state |
| `vsyn-state.txt` | Generate complete VSyn synchronization state | YAML VSyn schema | Save-LTFContext, cross-AI handoff |
| `context-transfer-full.txt` | Complete DMP-based transfer prompt | Narrative DMP + embedded YAML | Manual cross-AI/cross-session transfer |
| `divergent-threads.txt` | Capture creative tangents and spinoffs | Structured thread list | Manual or automated capture |

- --

## Usage Patterns

### Pattern 1: Automated Extraction (PowerShell Integration)

```powershell

# Save-LTFContext.ps1 uses these templates automatically

ltf save-context -ExtractState

# Behind the scenes:

# 1. Reads core/prompts/session-summary.txt

# 2. Sends to AI (if in VS Code Copilot Chat)

# 3. Captures response

# 4. Integrates into session-state.yaml

```

## Pattern 2: Manual Copy-Paste (Browser AI)

```text

1. Open ChatGPT/Claude/Gemini
2. Copy content from core/prompts/context-transfer-full.txt
3. Paste into chat
4. AI generates transfer prompt
5. Copy result to new AI session

```

### Pattern 3: VS Code Copilot Chat

```text

1. Open Copilot Chat panel
2. Reference template: @workspace /core/prompts/session-summary.txt
3. AI extracts state inline
4. Copy to session-state.md

```

- --

## Template Design Principles

1. **VS Integration**: Templates use Verbalized Sampling for diverse extraction
2. **DMP Structure**: Follow Template/Narrative/Hybrid DMP forms
3. **YAML Output**: Structured for machine parsing and human readability
4. **Cross-AI Portable**: Work on GPT, Claude, Gemini
5. **Composable**: Can be combined for comprehensive extraction

- --

## Customization

Templates are plain text files. Modify them to:

- Adjust number of VS responses (default: 5)
- Change probability threshold (default: τ=0.10)
- Add project-specific extraction criteria
- Customize YAML schema structure

- --

## Integration Points

* **DMP Pattern Library**: `core/taxonomy/DMP_Patterns.md` - Pattern definitions
* **VS Family Guide**: `core/taxonomy/VS_Family_Guide.md` - VS/VSyn/VcS techniques
* **Prompt Collection**: `core/LTF_Prompt_Collection.md` - Context Transfer foundation
* **Save-LTFContext**: `tools/context/Save-LTFContext.ps1` - Automated caller

- --

* *Version**: 1.0 - November 09, 2025
* *Status**: Foundation templates, expand as patterns emerge
