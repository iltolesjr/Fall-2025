# How the Assignment Project Board System Works

This document explains the complete workflow of the automated assignment tracking system.

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    Fall 2025 Assignment System                   │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 1: Tracker Files (Source of Truth)                        │
├─────────────────────────────────────────────────────────────────┤
│  📄 assignments/ENGL-1110-tracker.md                             │
│  📄 assignments/ITEC-1475-tracker.md                             │
│                                                                  │
│  Contains:                                                       │
│  • Assignment names                                              │
│  • Due dates                                                     │
│  • Status (Not Started, In Progress, Completed)                 │
│  • Priority, notes, etc.                                         │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 2: PowerShell Script (Parser & Automation)                │
├─────────────────────────────────────────────────────────────────┤
│  📜 scripts/create-assignments-project.ps1                       │
│  🐚 scripts/create-project-board.sh (wrapper)                    │
│                                                                  │
│  Does:                                                           │
│  1. Reads tracker files                                          │
│  2. Parses markdown tables                                       │
│  3. Extracts assignments + status                                │
│  4. Calls GitHub API                                             │
│  5. Creates issues                                               │
│  6. Adds to project board                                        │
│  7. Sets correct status                                          │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 3: GitHub Issues (Individual Assignments)                 │
├─────────────────────────────────────────────────────────────────┤
│  🎫 Issue #1: [ENGL-1110] Week 1 Discussion                     │
│  🎫 Issue #2: [ENGL-1110] Essay 1: Literary Analysis            │
│  🎫 Issue #3: [ITEC-1475] vCenter Lab: Change Hostname          │
│  ... (20 total issues)                                           │
│                                                                  │
│  Each issue has:                                                 │
│  • Title: [COURSE] Assignment Name                               │
│  • Label: Course name (ENGL-1110 or ITEC-1475)                  │
│  • Body: Course, status, tracker reference                       │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 4: GitHub Project Board (Visual Organization)             │
├─────────────────────────────────────────────────────────────────┤
│  🎯 Project: "Fall 2025 Assignments"                             │
│                                                                  │
│  ┌──────────────┬──────────────┬──────────────┐                 │
│  │  📝 Todo     │ 🔄 Progress  │  ✅ Done     │                 │
│  ├──────────────┼──────────────┼──────────────┤                 │
│  │ • Essay 1    │ • Week 2 Disc│ • Week 1 Disc│                 │
│  │ • Reading 1  │ • vCenter Lab│              │                 │
│  │ • Project 1  │ • Class Part │              │                 │
│  │ ...          │              │              │                 │
│  └──────────────┴──────────────┴──────────────┘                 │
│                                                                  │
│  Filter by: 🏷️ ENGL-1110  🏷️ ITEC-1475                         │
└─────────────────────────────────────────────────────────────────┘
```

## Status Mapping Flow

```
Tracker File Status    →    Project Board Column
─────────────────────────────────────────────────
"Not Started"          →    📝 Todo
"In Progress"          →    🔄 In Progress  
"Completed"            →    ✅ Done
```

## Data Flow Diagram

```
USER ACTION                SYSTEM RESPONSE
───────────                ────────────────

1. Edit Tracker File
   └─> Change status      
   └─> Save file
                          
2. Run Script
   ./create-project-      ─┐
   board.sh                │
                           │  Script reads trackers
                           │  Parses tables
                           │  Finds assignments
                           │  Maps status
                           │
                           ├─> Creates issues (if new)
                           ├─> Adds to project board
                           └─> Sets status columns

3. View Project Board
   on GitHub              ─┐
                           │  Shows organized view
                           │  Filtered by course
                           └─> Updated with new status
```

## Component Breakdown

### 1. Tracker Files (Data Source)

**Location**: `assignments/ENGL-1110-tracker.md`, `assignments/ITEC-1475-tracker.md`

**Format**:
```markdown
| Assignment | Due Date | Status | Notes |
|------------|----------|--------|-------|
| Essay 1    | Sept 28  | Not Started | ... |
```

**Purpose**: Single source of truth for all assignments

### 2. PowerShell Script (Automation Engine)

**Location**: `scripts/create-assignments-project.ps1`

**Key Functions**:
- `Parse-TrackerFile()`: Extracts assignments from markdown tables
- `Create-Issue()`: Creates GitHub issues via API
- `Add-ToProject()`: Adds issues to project board
- `Set-Status()`: Maps tracker status to board columns

**Dependencies**:
- GitHub CLI (`gh`) for API access
- PowerShell 7+ for cross-platform support

### 3. Bash Wrapper (User Interface)

**Location**: `scripts/create-project-board.sh`

**Purpose**: 
- Simplifies execution
- Checks prerequisites
- Auto-detects username
- Provides friendly output

### 4. GitHub Issues (Assignment Records)

**Format**:
```
Title: [ENGL-1110] Essay 1: Literary Analysis
Labels: ENGL-1110
Body:
  Course: ENGL-1110
  Status: Not Started
  Tracker: ENGL-1110-tracker.md
```

**Purpose**: Individual trackable items

### 5. GitHub Project Board (Visualization)

**Columns**:
- **Todo**: Default state for new assignments
- **In Progress**: Active work
- **Done**: Completed assignments

**Features**:
- Drag-and-drop between columns
- Filter by course label
- Sort by due date (via issue fields)

## Workflow Examples

### Example 1: Starting an Assignment

```
1. USER EDITS: assignments/ENGL-1110-tracker.md
   Change: | Essay 1 | ... | Not Started | ...
   To:     | Essay 1 | ... | In Progress | ...

2. USER RUNS: ./scripts/create-project-board.sh
   
3. SCRIPT DOES:
   ├─ Reads ENGL-1110-tracker.md
   ├─ Finds "Essay 1" with status "In Progress"
   ├─ Locates issue "[ENGL-1110] Essay 1: Literary Analysis"
   ├─ Gets project item ID
   └─ Updates status to "In Progress" column

4. RESULT: Essay 1 moves from Todo → In Progress on board
```

### Example 2: Completing an Assignment

```
1. USER EDITS: assignments/ITEC-1475-tracker.md
   Change: | vCenter Lab | ... | In Progress | ...
   To:     | vCenter Lab | ... | Completed   | ...

2. USER RUNS: ./scripts/create-project-board.sh
   
3. SCRIPT DOES:
   ├─ Reads ITEC-1475-tracker.md
   ├─ Finds "vCenter Lab" with status "Completed"
   ├─ Locates issue "[ITEC-1475] vCenter Lab: Change Hostname"
   ├─ Gets project item ID
   └─ Updates status to "Done" column

4. RESULT: vCenter Lab moves from In Progress → Done! 🎉
```

### Example 3: Adding New Assignment

```
1. INSTRUCTOR announces new assignment

2. USER EDITS: assignments/ENGL-1110-tracker.md
   Adds: | Essay 4 | Dec 10 | Not Started | Final essay |

3. USER RUNS: ./scripts/create-project-board.sh

4. SCRIPT DOES:
   ├─ Reads ENGL-1110-tracker.md
   ├─ Finds new assignment "Essay 4"
   ├─ Creates issue "[ENGL-1110] Essay 4"
   ├─ Adds label "ENGL-1110"
   ├─ Adds to project board
   └─ Sets status to "Todo"

5. RESULT: New card appears in Todo column
```

## Technical Details

### GitHub API Calls

The script uses GitHub's GraphQL API:

1. **Get User ID**: `query { user(login:...) { id } }`
2. **Find/Create Project**: `mutation { createProjectV2(...) }`
3. **Get Status Field**: `query { node(id:...) { ... fields } }`
4. **Create Issue**: `gh issue create --title ... --label ...`
5. **Add to Project**: `mutation { addProjectV2ItemById(...) }`
6. **Set Status**: `mutation { updateProjectV2ItemFieldValue(...) }`

### Status Field Options

GitHub Projects uses a single-select field called "Status" with options:
- Todo (or "To Do")
- In Progress (or "In-Progress")
- Done (or "Completed")

The script auto-detects these variations.

### Duplicate Prevention

The script:
1. Lists existing issues
2. Checks issue titles before creating
3. Skips if issue already exists
4. Updates status only (no duplicate creation)

## Error Handling

### Authentication Errors
```
Error: gh not authenticated
Solution: Run `gh auth login` with project scope
```

### Missing Trackers
```
Error: No assignments found
Solution: Verify tracker files exist and have correct format
```

### API Rate Limits
```
Error: API rate limit exceeded
Solution: Wait 1 hour or use authenticated requests
```

### Invalid Status Values
```
Warning: Unknown status "WIP"
Result: Defaults to "Not Started" → Todo
```

## Performance

**For 20 assignments**:
- Parse time: < 1 second
- API calls: ~45 total
  - 3 setup calls
  - 20 issue creates (first run only)
  - 20 project additions
  - 20 status updates (if needed)
- Total runtime: ~30-60 seconds (first run)
- Subsequent runs: ~10-20 seconds (only updates)

## Security

### Credentials
- Uses GitHub CLI authentication
- No credentials stored in repository
- OAuth tokens managed by `gh`

### Permissions Required
- `repo` scope: Create issues
- `project` scope: Manage project boards
- `write` access to repository

### Data Privacy
- All data stays on GitHub
- No external services used
- No telemetry or analytics

## Maintenance

### Regular Tasks
1. Keep tracker files updated
2. Run script weekly
3. Archive completed semester data

### Updating the Script
- Pull latest changes from repo
- Review `scripts/README.md` for changes
- Test with `-DryRun` first

### Troubleshooting
1. Try dry-run mode: `-DryRun -VerboseScan`
2. Check script output for errors
3. Verify tracker file format
4. Test GitHub authentication

## Future Enhancements

Potential improvements:
- [ ] Auto-detect due dates from tracker
- [ ] Email notifications for deadlines
- [ ] Weekly summary reports
- [ ] Integration with calendar apps
- [ ] Mobile app support
- [ ] Bulk status updates
- [ ] Assignment priority sorting
- [ ] Time tracking features

## Summary

The system provides:
- ✅ **Automated** assignment tracking
- ✅ **Visual** project board organization  
- ✅ **Synced** status across tracker and board
- ✅ **Labeled** by course for filtering
- ✅ **Simple** one-command updates

**Key Principle**: Edit tracker files, run script, see results!

---

**For Users**: See QUICK-START-PROJECT-BOARD.md  
**For Details**: See PROJECT-BOARD-SETUP.md  
**For Scripts**: See scripts/README.md
