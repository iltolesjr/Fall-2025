# Scripts Directory

Automation scripts for managing the Fall 2025 course repository.

## Available Scripts

### 1. `create-assignments-project.ps1` (Enhanced)

**Purpose**: Creates and populates a GitHub Project Board with assignments from tracker files.

**Features**:
- Reads assignments from `ENGL-1110-tracker.md` and `ITEC-1475-tracker.md`
- Creates GitHub Issues for each assignment
- Adds issues to a Project Board
- Sets status based on tracker: **Not Started** → Todo, **In Progress** → In Progress, **Completed** → Done
- Labels issues by course for easy filtering
- Avoids duplicates - only creates missing issues

**Requirements**:
- PowerShell 7+ (`pwsh`)
- GitHub CLI (`gh`) authenticated with project scope
- Repository access

**Usage**:

```powershell
# Basic usage (from repository root)
pwsh -File scripts/create-assignments-project.ps1 -User YOUR_GITHUB_USERNAME

# Dry run (show what would happen without making changes)
pwsh -File scripts/create-assignments-project.ps1 -User YOUR_GITHUB_USERNAME -DryRun

# Verbose output (see all files processed)
pwsh -File scripts/create-assignments-project.ps1 -User YOUR_GITHUB_USERNAME -VerboseScan

# Custom project title
pwsh -File scripts/create-assignments-project.ps1 -User YOUR_GITHUB_USERNAME -ProjectTitle "My Custom Board"
```

**Parameters**:
- `-User` (required): Your GitHub username
- `-Repo`: Repository name (defaults to current folder name)
- `-ProjectTitle`: Project board title (default: "Fall 2025 Assignments")
- `-AssignmentsPath`: Path to assignments folder (default: "assignments")
- `-DryRun`: Preview mode - shows what would be created without making changes
- `-VerboseScan`: Show detailed processing information

### 2. `create-project-board.sh` (Bash Wrapper)

**Purpose**: Simplified wrapper script for running the PowerShell script on Unix-like systems.

**Features**:
- Checks for required tools (pwsh, gh)
- Verifies authentication
- Automatically detects GitHub username
- Interactive confirmation

**Usage**:

```bash
# From repository root
./scripts/create-project-board.sh
```

The script will:
1. Verify prerequisites
2. Show what it will do
3. Ask for confirmation
4. Run the PowerShell script

### 3. `gh-setup.ps1`

GitHub CLI setup and configuration script.

## How the Project Board Works

### Assignment Status Flow

```
Not Started → In Progress → Completed
     ↓             ↓            ↓
   Todo      In Progress      Done
```

### Project Board Columns

1. **Todo** (Not Started assignments)
   - New assignments
   - Assignments not yet begun
   
2. **In Progress** (Work in progress)
   - Assignments currently being worked on
   - Partially completed work

3. **Done** (Completed assignments)
   - Finished assignments
   - Submitted work

### Course Organization

Issues are labeled by course:
- `ENGL-1110`: English Composition assignments
- `ITEC-1475`: Computer Technology assignments

You can filter the project board by label to see assignments for a specific course.

## Workflow

### Initial Setup

1. **Authenticate with GitHub**:
   ```bash
   gh auth login
   # Select: GitHub.com
   # Select: HTTPS
   # Authenticate in browser
   # Select: Yes, enable project scope
   ```

2. **Run the script**:
   ```bash
   ./scripts/create-project-board.sh
   ```
   
   Or directly with PowerShell:
   ```powershell
   pwsh -File scripts/create-assignments-project.ps1 -User YOUR_USERNAME
   ```

3. **View your project board**:
   - Go to your GitHub profile
   - Click "Projects" tab
   - Open "Fall 2025 Assignments"

### Updating Assignments

When you update tracker files:

1. **Update the tracker** (`assignments/ENGL-1110-tracker.md` or `assignments/ITEC-1475-tracker.md`):
   - Change status from "Not Started" to "In Progress" when you start work
   - Change status from "In Progress" to "Completed" when finished

2. **Re-run the script**:
   ```bash
   ./scripts/create-project-board.sh
   ```

3. **The script will**:
   - Skip existing issues (no duplicates)
   - Update issue status on the project board
   - Add any new assignments found in trackers

### Adding New Assignments

1. Add the assignment to the appropriate tracker file
2. Run the script to create an issue and add it to the board

## Tracker File Format

The script parses markdown tables in tracker files. Format:

```markdown
| Assignment | Due Date | Status | ... |
|------------|----------|--------|-----|
| Assignment Name | 2025-01-01 | Not Started | ... |
| Another Assignment | 2025-01-15 | In Progress | ... |
```

**Required**:
- Assignment name in first column
- Status in any column (must be: "Not Started", "In Progress", or "Completed")

**Supported Status Values**:
- `Not Started` → Sets project status to "Todo"
- `In Progress` → Sets project status to "In Progress"  
- `Completed` → Sets project status to "Done"

## Troubleshooting

### "gh not authenticated"
```bash
gh auth login
# Follow prompts and enable project scope
```

### "PowerShell not found"
Install PowerShell:
- **Windows**: Included by default (use `pwsh` for PowerShell 7+)
- **macOS**: `brew install --cask powershell`
- **Linux**: See [PowerShell installation docs](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell)

### "No assignments found"
- Verify tracker files exist in `assignments/` directory
- Check tracker files have properly formatted tables
- Run with `-VerboseScan` to see what's being processed

### Project board doesn't show status columns
GitHub Projects automatically creates status columns. If they're missing:
1. Go to your project board
2. Click "⋯" menu
3. Select "Settings"
4. Ensure "Status" field is enabled

## Tips

- **Dry Run First**: Always test with `-DryRun` before making real changes
- **Regular Updates**: Run the script weekly to keep your project board in sync
- **Manual Adjustments**: You can manually move items on the board - just remember to update trackers too
- **Course Filtering**: Use labels to view assignments for one course at a time

## Advanced Usage

### Custom Project Title
```powershell
pwsh -File scripts/create-assignments-project.ps1 -User USERNAME -ProjectTitle "Spring 2026 Assignments"
```

### Process Only ENGL Assignments
Edit the tracker file or temporarily move the ITEC tracker, then run the script.

### Batch Operations
The script processes all assignments in one run, making it efficient for large course loads.

## See Also

- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)

---

**Last Updated**: October 2025  
**Maintained by**: Course Repository Automation
