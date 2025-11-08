To create a snapshot of the current state of the repository, follow these steps:

```pwsh
pwsh tools/context/Save-LTFContext.ps1 -Tier Macro -Notes "Stability snapshot before switching chats"

# or

pwsh tools/context/Save-LTFContext.ps1 -Tier Micro -FocusPath projects/ai-thought-capture/README.md
```

To resume in a new chat:

```pwsh
pwsh tools/context/Resume-LTFContext.ps1 -SnapshotZip context-snapshots/LTF_Context_macro_<timestamp>.zip

# outputs CIP_Resume_<timestamp>.md — paste its contents into the fresh chat

```
