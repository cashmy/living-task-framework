1. Configurable Project Manifests

Create .ltf-influencers.yaml with optional sections:

```yaml

# projects/ehr-consent-platform/context/.ltf-influencers.yaml

project:
  name: ehr-consent-platform
  repo: https://github.com/cashmy/ehr-consent-platform
  type: software  # software | whitepaper | research | education

# Optional: Only include sections relevant to this project

influencers:
  concept:

    - docs/architecture/consent-model.md
    - Current_CIP.md

  milestones:  # Omit this section for burst-activity projects

    - docs/milestone-tracker.md

  architecture:

    - docs/architecture/consent-flow-diagram.md
    - contracts/interfaces/IConsentRegistry.sol  # Interface as mental model

  recent_reflections:
    max_age_days: 7
    path_pattern: "../../reflections/logs/*ehr-consent*.md"

  bridges:

    - "../../reflections/bridges/*-to-ehr-consent-*.md"

# Git-aware file references for AI access

git:
  repo_url: https://github.com/cashmy/ehr-consent-platform
  branch: main  # or feature branch if in active development
```

For burst projects (like whitepaper):

``` yaml

# projects/whitepapers/context/.ltf-influencers.yaml

project:
  name: consent-privacy-whitepaper
  type: whitepaper

influencers:
  concept:

    - whitepaper-outline.md

  # No milestones - single session burst

  recent_reflections:
    max_age_days: 1  # Only current session
```

2. DMP Patterns Library (Critical Documentation Gap)

Since users won't naturally recognize these patterns, we need:

Action: Should I create this file now as foundation documentation?

3. Variable Systems Family Guide

Action: Create this alongside DMP patterns?

4. Creative Spinoff Tracking (Meta-Observation Capture)

You've identified 3 spinoffs just in this conversation:

Treatise on DMP patterns (how they impact AI responses)
VS family comprehensive guide
Extraction prompt templates library
Quick-capture mechanism:

Then during planning sessions, review creative-spinoffs.md to decide which to activate.

Lightweight alternative: Just add -Spinoff "Description" to save-context

5. Git Repo Configuration (Critical for Cross-Interface)

When AI loads context in browser (ChatGPT) after working in VS Code:

Browser-based AI can fetch via GitHub API, VS Code Copilot can use local paths. Same reference, different resolution strategy.

6. Extraction/Summary Prompt Templates

Three implementation options you suggested - let's evaluate:

Option A: Text Snippets (Simplest)

Option B: Markdown Template Files (Structured)

Option C: Script-Invoked (Automated)

Hybrid Approach (My recommendation):

Text snippets for quick manual paste into AI
Script-invoked for automated extraction during save-context
Script can inject the text snippet as prompt automatically
Challenge: How do we invoke AI from PowerShell script in VS Code vs. Browser?

VS Code: Could use Copilot Chat API (if accessible)
Browser: Manual - script outputs prompt, user pastes, copies response
Compromise: Script generates prompt, copies to clipboard, waits for user to paste response
Immediate Action Items
Before implementing code, we need foundation documentation:

Starting (1/8) Document DMP pattern library with definitions