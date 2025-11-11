# [UX] Users Don't Know Where Files Are Created

- *Issue Type**: User Experience / Documentation
- *Priority**: Medium
- *Labels**: `ux`, `documentation`, `enhancement`

- --

## The Problem

- **What happened?**

User ran `Save-LTFContext-v2.ps1 -Type pivotal` and couldn't find the generated pivotal moment `.md` file. They were looking in the `context-snapshots/` directory (where the snapshot package was created), but the pivotal moment document itself is created in `reflections/pivotal-moments/`.

- **User's exact experience:**

> "I still don't see the .md file you created (e.g. 2025-11-10-cfp-validated-need-and-expansion.md)"

- **What did they expect?**

Expected all generated files to be in one location, or at least clear indication of where each file type goes.

- **Friction point**

Users must manually navigate folder structure to find different file types. No visual cue in terminal output showing where specific files were created.

- --

## Context

- *Scenario:** User creates pivotal snapshot to capture important moment

- **Steps:**
1. Run: `pwsh tools/context/Save-LTFContext-v2.ps1 -Type pivotal -Label "cfp-validated-need-expansion"`
2. Terminal shows: "Snapshot location: context-snapshots\2025-11-10_151216-pivotal-ltf-cfp-validated-need-expansion"
3. User navigates to `context-snapshots/` folder
4. **File not found** - pivotal moment `.md` is actually in `reflections/pivotal-moments/`

- **Environment:**
- OS: Windows
- Shell: PowerShell
- LTF Version: v2.2 (Save-LTFContext-v2.ps1)

- --

## Current File Location Logic

| File Type | Location | User Expectation |
|-----------|----------|------------------|
| **Context Snapshots** | `context-snapshots/YYYY-MM-DD_HHMMSS-*/` | ✅ Clear from terminal output |
| **Pivotal Moments** | `reflections/pivotal-moments/` | ❌ **Not shown in terminal** |
| **Session Buffers** | `temp/session-buffers/` | ❌ **Not mentioned** |

- **Why this design?**
- Snapshots are references (small, portable)
- Pivotal moments are detailed documents (large, archival)
- Separation makes sense architecturally, but **isn't communicated to users**

- --

## User Impact

- *Impact Level:** ⚠️ Major friction (workaround exists but painful)

- **Consequences:**
- User thinks tool failed or file wasn't created
- Wasted time searching filesystem
- Reduced trust in tooling
- Support burden (repeated questions)

- **Who's affected:**
- New LTF users (don't know folder structure)
- Infrequent users (forget between sessions)
- Users switching between snapshot types

- --

## Proposed Solutions

### **Option 1: Enhanced Terminal Output** (Quick Win)

- *Change:** Modify Save-LTFContext-v2.ps1 to explicitly show ALL file locations

- **Before:**

```powershell
Snapshot location: context-snapshots\2025-11-10_151216-pivotal-ltf-cfp-validated-need-expansion
Files created:

  - session-state.yaml              (influencer references + metadata)
  - transfer-prompt.md              (ready for new AI session)

```

- **After:**

```powershell
✓ Context Saved Successfully
═══════════════════════════════════════════════════════════════

📦 Snapshot Package: context-snapshots\2025-11-10_151216-pivotal-ltf-cfp-validated-need-expansion\

  - transfer-prompt.md
  - session-state.yaml
  - SNAPSHOT_SUMMARY.md

📝 Pivotal Moment Document: reflections\pivotal-moments\2025-11-10-cfp-validated-need-and-expansion.md

  - 743 lines, 53 KB
  - Contains: CFP project architecture, YAML schemas, AAP framework proposal

💡 TIP: Upload transfer-prompt.md to new AI session
```

- **Pros:**
- Immediate visibility
- No code changes to core logic
- Helps all users

- **Cons:**
- Users may still miss terminal output
- Doesn't persist (scrolls away)

- --

### **Option 2: Update Documentation** ✅ (IMPLEMENTED)

- *Change:** Add "Where Files Are Created" section to `tools/context/How_to_use.md`

- *Status:** ✅ **Completed** (2025-11-10)

- **Added:**
- Table mapping file types to locations
- Visual folder structure diagram
- Explanation of what goes where

- **Pros:**
- Durable reference documentation
- Searchable (users can Ctrl+F "where")
- Low maintenance

- **Cons:**
- Users must remember to check docs
- Doesn't help in-the-moment confusion

- --

### **Option 3: VS Code Workspace Notifications** (Future Enhancement)

- *Change:** If running in VS Code, show clickable notification

- **Example:**

```text
[VS Code Notification]
✓ Pivotal moment created
📝 2025-11-10-cfp-validated-need-and-expansion.md
[Open File] [Show in Explorer]
```

- **Implementation:**
- Detect if running in VS Code integrated terminal
- Use VS Code API to show notification with file links
- Optional (doesn't break command-line usage)

- **Pros:**
- Best UX (clickable, actionable)
- Fits VS Code workflow
- Doesn't clutter terminal

- **Cons:**
- Requires VS Code extension or workspace task
- Only helps VS Code users
- More complex implementation

- --

### **Option 4: Post-Save Summary File** (Alternative)

- *Change:** Generate `WHERE_FILES_WENT.txt` in workspace root after each save

- **Example:**

```text
LTF Context Save - 2025-11-10_151216

Files Created:

1. Snapshot Package

   Location: context-snapshots\2025-11-10_151216-pivotal-ltf-cfp-validated-need-expansion\
   Files:

     - transfer-prompt.md (ready to upload to new AI)
     - session-state.yaml (influencer references)
     - SNAPSHOT_SUMMARY.md (what's included)

2. Pivotal Moment Document

   Location: reflections\pivotal-moments\2025-11-10-cfp-validated-need-and-expansion.md
   Size: 53 KB, 743 lines
   Contains: CFP architecture, YAML schemas, AAP framework proposal

Next Steps:

- Review pivotal moment: code reflections\pivotal-moments\2025-11-10-cfp-validated-need-and-expansion.md
- Upload to new AI: code context-snapshots\2025-11-10_151216-pivotal-ltf-cfp-validated-need-expansion\transfer-prompt.md

```

- **Pros:**
- Persistent record (doesn't scroll away)
- Can be `.gitignore`d (ephemeral)
- Contains clickable paths (some editors)

- **Cons:**
- Another file to manage
- May clutter workspace root
- Users still need to know to check it

- --

## Recommended Approach

- **Immediate (This Release):**
1. ✅ **Option 2 - Documentation Update** (DONE)
2. 🔄 **Option 1 - Enhanced Terminal Output** (Easy win, improves UX)

- **Future (v2.3+):**
3. ⏳ **Option 3 - VS Code Integration** (if LTF gets VS Code extension)

- **Rationale:**
- Option 2 provides durable documentation (already implemented)
- Option 1 provides immediate in-context feedback (low effort, high value)
- Option 3 is best UX but requires more infrastructure

- --

## Acceptance Criteria

- **For Option 1 (Enhanced Terminal Output):**

- [ ] Terminal output explicitly lists pivotal moment file location
- [ ] Location uses relative path from workspace root
- [ ] Visual separator between snapshot package and pivotal document
- [ ] File size shown for pivotal moment (helps verify creation)
- [ ] "TIP" or "Next Steps" section guides user on what to do next

- **For Option 2 (Documentation - COMPLETED):**

- [x] `How_to_use.md` has "Where Files Are Created" section
- [x] Table mapping file types to locations
- [x] Visual folder structure diagram
- [x] Explanation of architectural rationale

- --

## Additional Context

- **User Quote:**

> "This is a point and requirement for documentation of the LTF Production itself."

- *Root Cause:** Architectural separation (snapshots vs. artifacts) not communicated to users

- **Related Files:**
- `tools/context/Save-LTFContext-v2.ps1` (terminal output logic)
- `tools/context/How_to_use.md` (updated with file locations)
- `.gitignore` (excludes `context-snapshots/` and `temp/`)

- *Discovery Context:** User creating CFP (Cognitive Foundation Primer) pivotal moment snapshot

- --

- *Issue Created:** 2025-11-10
- *Reported By:** @cashmy (project owner)
- *Assigned To:** TBD
- *Milestone:** v2.3 (UX Improvements)
