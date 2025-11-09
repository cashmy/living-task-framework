# Living Task Framework (LTF)

> **Naming note:** Locally this folder is named `@living-task-framework/` for sort priority.
> The remote GitHub repository slug should be `living-task-framework` (no `@`) for compatibility.

A modular, evidence-driven system for human–AI co-creation:

* **CIP-E**, **DMP**
* **VS Family:** VS (Verbalized Sampling), VSyn (Variable Synchronicity), VcS (Vector Co-Synthesis)

- --

## Quick Start

### Create a Context Snapshot

* *PowerShell (Windows, Mac, Linux)**:

```pwsh
pwsh tools/context/Save-LTFContext-v2.ps1 -Type resume -Label "my-checkpoint"
```

* *Bash (Mac, Linux, WSL)**:

```bash
bash tools/context/save-ltf-context.sh -type resume -label "my-checkpoint"
```

### Resume from a Snapshot

* *PowerShell**:

```pwsh
pwsh tools/context/Resume-LTF.ps1 -Project my-project -Type resume -Latest
```

* *Bash**:

```bash
bash tools/context/resume-ltf.sh -project my-project -type resume -latest
```

📖 **See**: `tools/context/CLI_GUIDE.md` for comprehensive usage instructions

- --
