# GitHub Project Board Setup Guide

This guide will help you set up an automated GitHub Project Board for tracking your Fall 2025 assignments.

## What You'll Get

An automated project board that:
- 📚 **Lists all assignments** from both ENGL-1110 and ITEC-1475 courses
- 🏷️ **Organizes by course** using labels for easy filtering
- 📊 **Tracks status** with three columns: Todo, In Progress, Done
- 🔄 **Syncs automatically** from your tracker files
- ✅ **Updates easily** - just run the script after updating trackers

## Visual Overview

```
┌─────────────────────────────────────────────────────────────┐
│          Fall 2025 Assignments Project Board                │
├─────────────────────┬─────────────────────┬─────────────────┤
│      📝 Todo        │   🔄 In Progress    │   ✅ Done       │
│  (Not Started)      │   (Working on)      │  (Completed)    │
├─────────────────────┼─────────────────────┼─────────────────┤
│ ENGL-1110:          │ ENGL-1110:          │ ENGL-1110:      │
│ • Essay 1           │ • Week 2 Discussion │ • Week 1 Disc   │
│ • Reading Resp 1    │ • Class Part.       │                 │
│ • Week 3 Disc       │                     │                 │
│                     │ ITEC-1475:          │                 │
│ ITEC-1475:          │ • vCenter Lab       │                 │
│ • Assignment 1      │                     │                 │
│ • Project 1         │                     │                 │
│ • Midterm Exam      │                     │                 │
└─────────────────────┴─────────────────────┴─────────────────┘
```

## Prerequisites

Before you start, make sure you have:

1. **GitHub CLI (gh)** - [Download here](https://cli.github.com/)
   ```bash
   # Verify installation
   gh --version
   ```

2. **PowerShell 7+** (for cross-platform support)
   - **Windows**: Already installed or `winget install Microsoft.PowerShell`
   - **macOS**: `brew install --cask powershell`
   - **Linux**: See [PowerShell docs](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell)

3. **Git** (already installed with GitHub)

## Quick Start (5 minutes)

### Step 1: Authenticate GitHub CLI

```bash
gh auth login
```

Follow the prompts:
1. Select: **GitHub.com**
2. Select: **HTTPS**
3. Select: **Login with a web browser**
4. Copy the code and paste in browser
5. **Important**: When asked about additional permissions, enable **project scope**

### Step 2: Run the Setup Script

Choose one of these methods:

**Option A: Using the Bash wrapper (easiest)**
```bash
./scripts/create-project-board.sh
```

**Option B: Using PowerShell directly**
```powershell
pwsh -File scripts/create-assignments-project.ps1 -User YOUR_GITHUB_USERNAME
```

Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username.

### Step 3: View Your Project Board

1. Go to your GitHub profile: `https://github.com/YOUR_USERNAME`
2. Click the **"Projects"** tab
3. Open **"Fall 2025 Assignments"**

You should see all 20 assignments organized by status!

## How It Works

### The Magic Behind the Scenes

1. **Script reads tracker files**:
   - `assignments/ENGL-1110-tracker.md`
   - `assignments/ITEC-1475-tracker.md`

2. **Extracts assignment information**:
   - Assignment name
   - Current status (Not Started, In Progress, Completed)
   - Course name

3. **Creates GitHub Issues**:
   - One issue per assignment
   - Labeled by course (ENGL-1110 or ITEC-1475)
   - Title format: `[COURSE] Assignment Name`

4. **Adds to Project Board**:
   - Todo column: "Not Started" assignments
   - In Progress column: "In Progress" assignments
   - Done column: "Completed" assignments

### Status Mapping

| Tracker Status | Project Board Column |
|----------------|---------------------|
| Not Started    | 📝 Todo             |
| In Progress    | 🔄 In Progress      |
| Completed      | ✅ Done             |

## Daily Workflow

### When You Start an Assignment

1. **Update the tracker file**:
   ```markdown
   | Assignment | Due Date | Status | ... |
   | Essay 1    | Sept 28  | In Progress | ... |  ← Changed from "Not Started"
   ```

2. **Run the script**:
   ```bash
   ./scripts/create-project-board.sh
   ```

3. **Check your board** - The assignment moves to "In Progress"!

### When You Complete an Assignment

1. **Update the tracker file**:
   ```markdown
   | Assignment | Due Date | Status | ... |
   | Essay 1    | Sept 28  | Completed | ... |  ← Changed from "In Progress"
   ```

2. **Run the script** again

3. **Check your board** - The assignment moves to "Done"! 🎉

## Advanced Usage

### Testing Changes (Dry Run)

Want to see what will happen without making real changes?

```powershell
pwsh -File scripts/create-assignments-project.ps1 -User YOUR_USERNAME -DryRun -VerboseScan
```

This shows:
- Which assignments will be created
- What status each will have
- Which courses they belong to
- No actual changes are made!

### Filtering by Course

On your project board:
1. Click the **"Filter"** button
2. Select a label: **ENGL-1110** or **ITEC-1475**
3. See only assignments for that course

### Manual Adjustments

You can manually move items on the board, but remember:
- The script will reset them to match tracker files on next run
- **Best practice**: Always update tracker files first, then run script

## Troubleshooting

### "gh not authenticated"

**Solution**:
```bash
gh auth login
# Make sure to enable project scope during authentication
```

### "PowerShell not found"

**Solution**: Install PowerShell
- Windows: `winget install Microsoft.PowerShell`
- macOS: `brew install --cask powershell`
- Linux: See [installation guide](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell)

### "No assignments found"

**Solution**: Verify tracker files exist:
```bash
ls assignments/*-tracker.md
# Should show: ENGL-1110-tracker.md and ITEC-1475-tracker.md
```

### Script runs but no project visible

**Solutions**:
1. Check the project URL in script output
2. Verify you're logged into correct GitHub account
3. Try accessing directly: `https://github.com/users/YOUR_USERNAME/projects`

### Duplicate issues created

The script automatically checks for existing issues and skips them. If you see duplicates:
1. They might have slightly different titles
2. Close the duplicate issues manually
3. Run the script again - it will skip existing ones

## Tips & Best Practices

### 🎯 Keep It Simple
- Update tracker files regularly
- Run the script weekly
- Don't manually edit issue titles (breaks sync)

### 🔄 Regular Sync
```bash
# Sunday planning routine:
./scripts/create-project-board.sh
```

### 📊 Track Progress
Use the project board to:
- See what's due next
- Track your workload across courses
- Celebrate completed assignments (move to Done!)

### 🏷️ Use Labels
- Filter by course when overwhelmed
- Focus on one class at a time
- See balance between courses

### 💡 Copilot Integration
Ask Copilot:
- "Update the tracker to mark Essay 1 as completed"
- "What assignments are due this week?"
- "Show me all in-progress assignments"

## Example Session

Here's a complete workflow example:

```bash
# Monday morning: Start working on Essay 1
# 1. Update tracker
vim assignments/ENGL-1110-tracker.md
# Change Essay 1 status to "In Progress"

# 2. Sync to project board
./scripts/create-project-board.sh

# Friday: Finish Essay 1
# 1. Update tracker
vim assignments/ENGL-1110-tracker.md  
# Change Essay 1 status to "Completed"

# 2. Sync to project board
./scripts/create-project-board.sh

# Sunday: Planning for next week
# View project board to see what's in Todo
```

## Maintenance

### Adding New Assignments

When your instructor adds new assignments:

1. Add them to the appropriate tracker file
2. Run the script
3. New issues appear automatically!

### Removing Assignments

If an assignment is cancelled:

1. Remove from tracker file
2. Close the issue on GitHub manually
3. Remove from project board

### Updating Due Dates

Due dates are in the tracker files. Update them there and they'll be reflected in issue bodies.

## Get Help

- **Script documentation**: See `scripts/README.md`
- **GitHub Projects help**: [docs.github.com/projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- **PowerShell help**: Run `Get-Help scripts/create-assignments-project.ps1 -Full`

## What's Next?

Once your board is set up:
1. ⭐ **Pin it** - Star the project for quick access
2. 📱 **Bookmark it** - Add to browser favorites
3. 🔔 **Check daily** - Make it part of your routine
4. ✅ **Update regularly** - Keep trackers current

---

**Happy studying!** 🎓

*Last updated: October 2025*
