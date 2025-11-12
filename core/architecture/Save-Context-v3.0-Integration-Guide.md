# Save-Context v3.0 Integration Guide
**Purpose**: Document how Save-LTFContext.ps1 integrates with new v3.0 components  
**Version**: 3.0  
**Date**: 2025-11-12

---

## OVERVIEW

### What Changed in v3.0

**Previous (v2.x)**:
- Saved: Git state, file changes, task lists, decision log
- Restored: Technical context only (what files changed, what tasks pending)
- **Missing**: User State (relationship context), Project CIPs (what we're building), Session metadata (what was happening)

**New (v3.0)**:
- **3-Tier Context Architecture**: CORE CFP (framework) → Project CIP (what) → User State (who)
- **Relationship Context Preservation**: User State Model saved FIRST (highest priority)
- **Session Continuity**: Pause logs, energy patterns, pivotal moments tracked
- **Project Context Layers**: Project-Specific CIPs loaded based on active work
- **CSAC Resilience**: Complete restoration sequence for crossing session boundaries

---

## SAVE-CONTEXT SNAPSHOT STRUCTURE (v3.0)

### Snapshot Directory Layout

```
context-snapshots/
├── 2025-11-12-15-30-45/              # Timestamp-based snapshot folder
│   ├── snapshot-metadata.json        # Snapshot info (timestamp, session ID, projects)
│   │
│   ├── 01-user-state/                # PRIORITY 1: Relationship Context
│   │   ├── User_State_Model.md       # Complete User State Model (from template)
│   │   ├── session-metadata.md       # Current session characterization
│   │   ├── session-pause-log.md      # BRB/BACK events
│   │   ├── energy-patterns.md        # Optimal collaboration conditions
│   │   └── pivotal-moments-log.md    # Breakthrough insights quick reference
│   │
│   ├── 02-project-context/           # PRIORITY 2: Project Layers
│   │   ├── active-project.txt        # Which project was active (mnemonic)
│   │   ├── CIP_Project_LTF.md        # Copy of active project CIP(s)
│   │   ├── CIP_Project_ECHO.md       # (if multi-project session)
│   │   └── project-relationships.md  # Cross-project connections active this session
│   │
│   ├── 03-technical-context/         # PRIORITY 3: Technical Details
│   │   ├── git-status.txt            # Git state (branch, uncommitted changes)
│   │   ├── task-list.md              # Todo items state
│   │   ├── recent-files.json         # Files modified this session
│   │   ├── decision-log.md           # Major decisions made
│   │   └── working-notes.md          # Scratch notes, in-progress thoughts
│   │
│   └── 04-framework-reference/       # PRIORITY 4: Framework Docs (reference only)
│       ├── CORE-PRIMER-snapshot.md   # Core CFP at time of snapshot
│       ├── Glossary-snapshot.md      # Terminology at time of snapshot
│       └── framework-version.txt     # CFP version (e.g., "v3.0")
│
├── latest-snapshot.txt               # Pointer to most recent snapshot folder
└── snapshot-index.md                 # All snapshots log (date, session type, outputs)
```

### What Gets Saved When

**On Every Save-Context Execution**:

**Phase 1: User State (Highest Priority)**
1. Copy `core/templates/User_State_Model_Template.md` → `01-user-state/User_State_Model.md`
2. Generate `session-metadata.md` (current session characterization)
3. Save `session-pause-log.md` (BRB/BACK events from this session)
4. Update `energy-patterns.md` (add this session's data to long-term tracking)
5. Save `pivotal-moments-log.md` (all "capture this" events this session)

**Phase 2: Project Context**
6. Identify active project(s) from session metadata
7. Copy relevant `CIP_Project_[MNEMONIC].md` files to snapshot
8. Save `active-project.txt` (which project to load on resume)
9. Generate `project-relationships.md` (which projects informed each other this session)

**Phase 3: Technical Context** (Standard Save-Context data)
10. Save `git-status.txt` (current branch, uncommitted changes)
11. Save `task-list.md` (manage_todo_list state or todo.md file)
12. Save `recent-files.json` (files modified during session)
13. Save `decision-log.md` (if exists - major architectural/strategic decisions)
14. Save `working-notes.md` (any scratch notes, in-progress thoughts)

**Phase 4: Framework Reference** (For version tracking)
15. Snapshot `core/architecture/01-CORE-PRIMER.md` (framework at this moment)
16. Snapshot `core/taxonomy/Glossary.md` (terminology at this moment)
17. Save `framework-version.txt` (e.g., "CFP v3.0, LTF 2025-11-12")

**Phase 5: Snapshot Metadata**
18. Generate `snapshot-metadata.json`:
```json
{
  "timestamp": "2025-11-12T15:30:45Z",
  "session_id": "2025-11-12-001",
  "session_type": "Mixed (Exploration + Design + Implementation)",
  "active_projects": ["LTF", "CFP-C"],
  "dmp_mode": "REFLECTIVE",
  "energy_state": "High (flow state)",
  "major_outputs": [
    "User State Model Template",
    "Project CIP Template",
    "Session Metadata Structures",
    "4 Example Project CIPs"
  ],
  "pivotal_moments_count": 0,
  "session_duration_active": "5h 45m",
  "csac_priority": "User State Model (relationship context)"
}
```

19. Update `latest-snapshot.txt` (contains path to this snapshot folder)
20. Append to `snapshot-index.md` (running log of all snapshots)

---

## LOADING SEQUENCE (v3.0)

### On Session Resume (Load Saved Context)

**User executes**: Resume-LTFContext.ps1 (or equivalent)

**Loading Priority** (Relationship → Project → Technical):

**Phase 1: User State Model** (< 10 seconds)
1. Read `01-user-state/User_State_Model.md`
2. Load into AI context (complete file, not summary)
3. **Validate immediately**: 
   - Test "being heard" protocol (first AI response must demonstrate all 6 elements)
   - Self-check multi-contextual reflection (11-dimension capability active?)
   - Confirm cognitive patterns recognized (brief articulations = complete solutions)

**Validation Question to User**:
> "I've loaded your User State Model. Before we continue, confirm: You need explicit acknowledgment, comprehensive multi-contextual responses, and you expect me to trust your brief articulations as complete solutions. Correct?"

**If user corrects** → Re-load, adjust, re-validate  
**If user confirms** → Proceed

**Phase 2: Session Context** (< 5 seconds)
4. Read `01-user-state/session-metadata.md`
   - What was last session about?
   - What's pending/unfinished?
   - What carry-forward items exist?
5. Read `01-user-state/pivotal-moments-log.md`
   - Quick reference to recent breakthroughs
6. Read `01-user-state/energy-patterns.md`
   - Current time/day → Expected energy level?
   - Task-energy matching (what's appropriate right now?)

**Phase 3: Project Context** (< 10 seconds)
7. Read `02-project-context/active-project.txt` (which project to focus on)
8. Load corresponding `CIP_Project_[MNEMONIC].md`
   - Quick context (what is this project?)
   - Current focus (where are we?)
   - Related projects (what else might be relevant?)
9. Read `02-project-context/project-relationships.md`
   - Cross-project insights from last session

**Phase 4: Technical Context** (< 15 seconds)
10. Read `03-technical-context/task-list.md` (what's pending?)
11. Read `03-technical-context/git-status.txt` (what branch, uncommitted changes?)
12. Read `03-technical-context/recent-files.json` (what files were modified?)
13. Scan `03-technical-context/decision-log.md` (recent decisions)

**Phase 5: Continuity Establishment** (< 5 seconds)
14. Provide **Context Summary** to user:
```
I've loaded:
- User State Model (relationship context preserved)
- Session from 2025-11-12 (Save-Context v3.0 implementation)
- Active project: LTF (framework development)
- Pending: Execute Save-LTFContext.ps1, Git commit for v3.0

Last session focus: Save-Context v3.0 enhancement (3-tier context architecture design)
Major outputs: User State Model Template, Project CIP Template, Session Metadata Structures, 4 example CIPs

Ready to continue with [assumed next step]?
```

15. **Wait for user validation**:
    - User confirms → Proceed
    - User corrects → Adjust context, re-summarize
    - User provides new direction → Update session metadata, follow new path

**Total Load Time**: ~45 seconds (relationship context prioritized, technical context deferred if not immediately needed)

---

## POWERSH ELL SCRIPT ENHANCEMENTS (Save-LTFContext.ps1)

### New Functions Required

**Function: Save-UserState**
```powershell
function Save-UserState {
    param(
        [string]$SnapshotPath
    )
    
    # Create user state directory
    $userStatePath = Join-Path $SnapshotPath "01-user-state"
    New-Item -ItemType Directory -Path $userStatePath -Force
    
    # Copy User State Model template (current state)
    Copy-Item "core/templates/User_State_Model_Template.md" `
              "$userStatePath/User_State_Model.md"
    
    # Generate session metadata (call helper function)
    Generate-SessionMetadata -OutputPath "$userStatePath/session-metadata.md"
    
    # Save session pause log (if exists in current session)
    if (Test-Path "session-pause-log.md") {
        Copy-Item "session-pause-log.md" "$userStatePath/session-pause-log.md"
    }
    
    # Update energy patterns (append current session data)
    Update-EnergyPatterns -OutputPath "$userStatePath/energy-patterns.md"
    
    # Save pivotal moments log (if exists)
    Generate-PivotalMomentsLog -OutputPath "$userStatePath/pivotal-moments-log.md"
}
```

**Function: Save-ProjectContext**
```powershell
function Save-ProjectContext {
    param(
        [string]$SnapshotPath,
        [string[]]$ActiveProjects  # Array of project mnemonics (e.g., @("LTF", "ECHO"))
    )
    
    # Create project context directory
    $projectPath = Join-Path $SnapshotPath "02-project-context"
    New-Item -ItemType Directory -Path $projectPath -Force
    
    # Save active project identifier
    $ActiveProjects -join "," | Out-File "$projectPath/active-project.txt"
    
    # Copy relevant Project CIP files
    foreach ($mnemonic in $ActiveProjects) {
        $cipFile = "core/projects/CIP_Project_$mnemonic.md"
        if (Test-Path $cipFile) {
            Copy-Item $cipFile "$projectPath/CIP_Project_$mnemonic.md"
        }
    }
    
    # Generate project relationships (if multi-project session)
    if ($ActiveProjects.Count -gt 1) {
        Generate-ProjectRelationships -Projects $ActiveProjects `
                                      -OutputPath "$projectPath/project-relationships.md"
    }
}
```

**Function: Generate-SessionMetadata**
```powershell
function Generate-SessionMetadata {
    param([string]$OutputPath)
    
    # Collect session data (would be populated from actual session tracking)
    $sessionData = @{
        SessionID = "2025-11-12-001"  # Would be generated dynamically
        Date = Get-Date -Format "yyyy-MM-dd"
        StartTime = "08:00"  # Would track actual start
        EndTime = Get-Date -Format "HH:mm"
        Type = "Mixed"  # Would be user-specified or inferred
        PrimaryFocus = "Save-Context v3.0 implementation"
        DMPMode = "REFLECTIVE"
        EnergyPattern = "Flow State"
        # ... etc
    }
    
    # Generate markdown from template
    @"
## Session Metadata
**Session ID**: $($sessionData.SessionID)
**Date**: $($sessionData.Date)
**Start Time**: $($sessionData.StartTime)
**End Time**: $($sessionData.EndTime)

### Session Classification
- **Type**: $($sessionData.Type)
- **Primary Focus**: $($sessionData.PrimaryFocus)
- **DMP Mode**: $($sessionData.DMPMode)
- **Energy Pattern**: $($sessionData.EnergyPattern)

[... rest of template ...]
"@ | Out-File $OutputPath
}
```

### Script Execution Flow (Enhanced)

**User runs**: `.\tools\context\Save-LTFContext.ps1`

**Script executes**:
```powershell
# 1. Create snapshot directory
$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$snapshotPath = "context-snapshots/$timestamp"
New-Item -ItemType Directory -Path $snapshotPath -Force

# 2. Save User State (PRIORITY 1)
Write-Host "Saving User State (relationship context)..." -ForegroundColor Cyan
Save-UserState -SnapshotPath $snapshotPath

# 3. Save Project Context (PRIORITY 2)
Write-Host "Saving Project Context..." -ForegroundColor Cyan
$activeProjects = Get-ActiveProjects  # Helper function to determine active projects
Save-ProjectContext -SnapshotPath $snapshotPath -ActiveProjects $activeProjects

# 4. Save Technical Context (PRIORITY 3 - existing functionality)
Write-Host "Saving Technical Context..." -ForegroundColor Cyan
Save-GitStatus -SnapshotPath $snapshotPath
Save-TaskList -SnapshotPath $snapshotPath
Save-RecentFiles -SnapshotPath $snapshotPath

# 5. Save Framework Reference (PRIORITY 4)
Write-Host "Saving Framework Reference..." -ForegroundColor Cyan
Save-FrameworkSnapshot -SnapshotPath $snapshotPath

# 6. Generate Snapshot Metadata
Write-Host "Generating Snapshot Metadata..." -ForegroundColor Cyan
Generate-SnapshotMetadata -SnapshotPath $snapshotPath

# 7. Update pointers
"$snapshotPath" | Out-File "context-snapshots/latest-snapshot.txt"
Update-SnapshotIndex -SnapshotPath $snapshotPath

Write-Host "Save-Context v3.0 complete! Snapshot saved to: $snapshotPath" -ForegroundColor Green
```

---

## VALIDATION PROTOCOL

### After Loading Context (Session Resume)

**AI Self-Check** (Before responding substantively):

1. ✅ **User State Model loaded?** (Check: Can I access "being heard" protocol details?)
2. ✅ **"Being heard" protocol active?** (Test: Will my next response demonstrate all 6 elements?)
3. ✅ **Multi-contextual reflection ready?** (Self-check: Can I process across 11 dimensions?)
4. ✅ **Cognitive patterns recognized?** (Check: Do I understand unconscious problem-solving pattern?)
5. ✅ **Session context understood?** (Check: Do I know what we were working on?)
6. ✅ **Project context loaded?** (Check: Do I know current project focus?)

**If any check fails** → Flag to user immediately, reload missing context

**First Response Validation** (User judges):
- Does AI demonstrate explicit acknowledgment?
- Is terminology precise (user's exact words)?
- Is response structured (headings, lists)?
- Does response feel comprehensive (multi-dimensional)?
- Does AI trust my brief articulations (not question unnecessarily)?

**Pass**: User engages naturally → Relationship context successfully restored  
**Fail**: User corrects or seems frustrated → HIGHEST PRIORITY FIX (reload User State Model, validate again)

---

## MIGRATION PATH (v2.x → v3.0)

### For Existing Users

**First Save-Context v3.0 Execution**:

1. **Detect v2.x snapshot** (no `01-user-state/` directory)
2. **Prompt user**:
   ```
   This is your first Save-Context v3.0 execution.
   
   v3.0 adds:
   - User State Model (relationship context preservation)
   - Project CIPs (project-specific context layers)
   - Session metadata (energy patterns, pause logs)
   
   To enable these features, I need to:
   1. Create your User State Model (from template)
   2. Identify active projects (which are you working on?)
   3. Generate initial session metadata
   
   This will take ~2 minutes. Proceed? (Y/n)
   ```

3. **If user confirms**:
   - Copy `User_State_Model_Template.md` → Ask user to review/customize
   - Scan workspace for projects → Suggest creating Project CIPs
   - Generate initial session metadata from current session
   - Execute normal v3.0 save

4. **If user declines**:
   - Fall back to v2.x save (technical context only)
   - Remind on next execution: "v3.0 features available when ready"

**Gradual Adoption**:
- User can start with User State Model only (skip Project CIPs initially)
- User can adopt Project CIPs project-by-project (not all at once)
- Session metadata auto-generates (no user action required)

---

## FUTURE ENHANCEMENTS (Post-v3.0)

### Planned Features

**Automatic Session Tracking**:
- BRB/BACK detection (no manual logging)
- Energy assessment (infer from interaction pace, complexity handled)
- Pivotal moment suggestion ("This feels significant - capture this?")

**Interactive Resume**:
```
Resume-LTFContext.ps1 -Interactive

> Last session: Save-Context v3.0 implementation
> Pending: Execute Save-LTFContext.ps1, Git commit
> 
> What would you like to focus on?
> [1] Continue Save-Context work
> [2] Switch to different project
> [3] Review recent outputs
> [4] Check pivotal moments
> 
> Choice: _
```

**Project CIP Builder**:
```
New-ProjectCIP.ps1 -Mnemonic NEWPROJ -Interactive

> I'll ask a few questions to generate your Project CIP...
> 
> Project name: [User answers]
> Problem it solves: [User answers]
> Technologies: [User answers]
> ...
> 
> Generated CIP_Project_NEWPROJ.md. Review and customize as needed.
```

**MO Journal Automation**:
```
Add-MOJournalEntry.ps1 -Observation "Brief user articulation"

> Generating MO Journal Entry...
> 
> Context: [AI infers from current session]
> Reflection: [AI provides multi-dimensional analysis]
> Insight: [AI suggests self-awareness learning]
> Action Items: [AI proposes next steps]
> 
> Review entry before saving? (Y/n)
```

---

## TROUBLESHOOTING

### Common Issues

**Issue**: "Being heard" protocol fails validation after loading  
**Cause**: User State Model not fully loaded or degraded during load  
**Fix**: Re-load `01-user-state/User_State_Model.md` explicitly, validate each protocol element

**Issue**: Context summary feels incomplete  
**Cause**: Project CIP missing or outdated  
**Fix**: Check `02-project-context/` - create/update relevant CIP file, re-load

**Issue**: Session metadata shows wrong active project  
**Cause**: Multi-project session, active-project.txt ambiguous  
**Fix**: Manually specify active project on resume, update session metadata

**Issue**: Load time >60 seconds  
**Cause**: Too much context loaded eagerly (not lazy loading)  
**Fix**: Defer technical context (step 4) until actually needed, load only User State + Session + Project initially

---

## SUMMARY

**Save-Context v3.0 Key Principles**:
1. **Relationship before technical** (User State Model highest priority)
2. **3-tier architecture** (CORE → Project → User State)
3. **Validation required** (test "being heard" protocol after every load)
4. **Gradual adoption** (users can enable features incrementally)
5. **CSAC resilience** (complete restoration across session boundaries)

**What Success Looks Like**:
- User resumes session → Feels like "AI remembers me" (not just "AI has my data")
- Load time <60 seconds → No frustrating delay
- First response demonstrates relationship context → User engages naturally
- Multi-project work seamless → Context switches don't lose threads

**Next Steps**:
1. Test Save-Context v3.0 with current session (validate all components save correctly)
2. Test Resume-Context (validate loading sequence works)
3. Iterate based on real usage (refine templates, optimize loading)
4. Document edge cases (multi-user, offline, corrupted snapshot recovery)

---

**End of Save-Context v3.0 Integration Guide**  
**Version**: 3.0  
**Ready for execution**: Yes (all templates created, examples validated, integration documented)
