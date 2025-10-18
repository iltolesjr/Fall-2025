# 🚀 Quick Start: Project Board Setup

**Get your assignment tracking board running in 5 minutes!**

## Step 1: Install Prerequisites (One-time)

```bash
# Install GitHub CLI
# Windows:
winget install --id GitHub.cli

# macOS:
brew install gh

# Linux:
# See https://github.com/cli/cli#installation
```

## Step 2: Authenticate

```bash
gh auth login
# Choose: GitHub.com → HTTPS → Browser
# ⚠️ IMPORTANT: Enable "project" scope when asked!
```

## Step 3: Run the Script

```bash
# From repository root:
./scripts/create-project-board.sh

# Or with PowerShell:
pwsh -File scripts/create-assignments-project.ps1 -User YOUR_USERNAME
```

## Step 4: View Your Board

Go to: `https://github.com/YOUR_USERNAME?tab=projects`

---

## 📊 What You Get

A project board with:
- ✅ **20 assignments** from both courses
- 📝 **3 columns**: Todo, In Progress, Done
- 🏷️ **Course labels**: ENGL-1110, ITEC-1475
- 🔄 **Auto-sync** from tracker files

## 🔄 Daily Use

### When Starting Work:
1. Edit tracker: Change status to "In Progress"
2. Run: `./scripts/create-project-board.sh`
3. Check board - item moved to "In Progress"!

### When Completing Work:
1. Edit tracker: Change status to "Completed"
2. Run: `./scripts/create-project-board.sh`
3. Check board - item moved to "Done"! 🎉

## 📋 Tracker Format

Your tracker files should have:

```markdown
| Assignment | Due Date | Status | ... |
|------------|----------|--------|-----|
| Essay 1    | Sept 28  | Not Started | ... |
| Lab 2      | Sept 30  | In Progress | ... |
| Quiz 1     | Sept 25  | Completed   | ... |
```

**Status values**: `Not Started`, `In Progress`, `Completed`

## 🆘 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| "gh not authenticated" | Run `gh auth login` with project scope |
| "pwsh not found" | Install PowerShell from microsoft.com |
| "No assignments found" | Check tracker files exist in `assignments/` |
| Script errors | Try dry-run: add `-DryRun` flag |

## 📚 More Help

- **Full guide**: See `PROJECT-BOARD-SETUP.md`
- **Script docs**: See `scripts/README.md`
- **Test first**: Use `-DryRun` flag to preview

---

**Next**: See PROJECT-BOARD-SETUP.md for complete documentation
