# Living Task Framework (LTF) Command Line Guide

* *Last updated:** 2025-11-09

- --

## Introduction

This guide explains how to use the Living Task Framework (LTF) from the command line, supporting both PowerShell and Bash. It is designed for users on Windows, Mac, and Linux, and for those working with AI platforms that cannot execute commands or create files automatically.

- --

## Prerequisites

* **PowerShell 7+** (Windows, Mac, Linux)
- (Optional) **Bash** (Mac, Linux, Windows with WSL or Git Bash)
- Clone or download the LTF repository

- --

## Basic Usage

### 1. Save a Context Snapshot

#### PowerShell (Windows, Mac, Linux)

```pwsh
pwsh tools/context/Save-LTFContext-v2.ps1 -Type resume -Label "my-checkpoint"
```

#### Bash (Mac, Linux, WSL)

```bash
pwsh tools/context/Save-LTFContext-v2.ps1 -Type resume -Label "my-checkpoint"

# Or, if you have a Bash version:

bash tools/context/save-ltf-context.sh -type resume -label "my-checkpoint"
```

## 2. Resume from a Snapshot

### PowerShell

```pwsh
pwsh tools/context/Resume-LTF.ps1 -Project my-project -Type resume -Latest
```

#### Bash

```bash
pwsh tools/context/Resume-LTF.ps1 -Project my-project -Type resume -Latest

# Or, if you have a Bash version:

bash tools/context/resume-ltf.sh -project my-project -type resume -latest
```

- --

## Manual Mode (For Web AI Users)

If your AI platform cannot run commands or create files:

1. Ask the AI to generate the required command(s) and file content.
2. Copy the command(s) and run them in your local terminal.
3. If file content is provided, copy it into the correct file(s) and path(s) in your project.
4. Upload or share the results as needed.

- --

## Troubleshooting

* **PowerShell not found?**
  - Install PowerShell 7+ from https://github.com/PowerShell/PowerShell
* **Permission denied?**
  - On Mac/Linux, run `chmod +x` on Bash scripts if needed.
* **Script not working?**
  - Check you are in the project root directory.
  - Use `pwsh` instead of `powershell` for cross-platform compatibility.

- --

## Advanced Examples

- Save a pivotal snapshot:

  ```pwsh
  pwsh tools/context/Save-LTFContext-v2.ps1 -Type pivotal -Label "feature-x"
  ```

- Resume a specific snapshot by label:

  ```pwsh
  pwsh tools/context/Resume-LTF.ps1 -Project my-project -Type resume -Label "feature-x"
  ```

- --

## Cross-Platform Notes

* **Windows**: Use `pwsh` in PowerShell 7+ terminal
* **Mac/Linux**: Use `pwsh` or Bash scripts
* **Web AI**: Use Manual Mode (see above)

- --

## See Also

- `tools/context/How_to_use.md`
- `core/CROSS_PLATFORM_AI_STRATEGY.md`
- LTF README.md
