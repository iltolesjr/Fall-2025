# Setup Script Documentation

## Overview

The `setup.sh` (Linux/Mac) and `setup.bat` (Windows) scripts are **master automation scripts** that consolidate all required commands to set up your Fall 2025 course management system in one simple command.

## Purpose

Instead of running multiple separate scripts and commands, this single script:
- ✅ Checks all prerequisites
- ✅ Installs MCP server dependencies
- ✅ Verifies directory structure
- ✅ Optionally sets up GitHub Project Board
- ✅ Provides a complete setup summary

## Quick Start

### Linux/Mac
```bash
./setup.sh
```

### Windows
```batch
setup.bat
```

## What the Script Does

### Step 1: Prerequisites Check
The script verifies that you have all required tools installed:

- **Node.js** (required) - For MCP server functionality
- **npm** (required) - For installing dependencies
- **PowerShell** (optional) - For GitHub Project Board setup
- **GitHub CLI** (optional) - For GitHub Project Board setup

If any required tool is missing, the script will stop and provide installation instructions.

### Step 2: MCP Server Setup
The script:
1. Navigates to the `.mcp` directory
2. Runs `npm install` to install dependencies
3. Tests the MCP server to ensure it starts correctly
4. Returns to the repository root

**What is MCP?**
Model Context Protocol enables AI assistants to securely connect to your course data, providing intelligent assistance for:
- Assignment tracking
- Due date management
- Note organization
- Study schedule generation

### Step 3: Directory Structure Verification
The script checks for and creates (if missing) these essential directories:
- `assignments/` - Assignment trackers and materials
- `notes/` - Course notes and study materials
- `schedules/` - Class schedules and planning
- `discussions/` - Discussion preparation materials
- `screenshots/` - Visual documentation

### Step 4: GitHub Project Board Setup (Optional)
If GitHub CLI is installed and authenticated, the script offers to:
1. Read assignments from your tracker files
2. Create GitHub Issues for each assignment
3. Add issues to a Project Board
4. Organize by status: Todo, In Progress, Done
5. Label by course: ENGL-1110, ITEC-1475

You can skip this step and set it up later.

### Step 5: Summary & Next Steps
The script provides:
- Setup completion confirmation
- Quick reference commands
- Important file locations
- Daily workflow guide
- Help resources

## Prerequisites

### Required
- **Node.js 16+**: [Download](https://nodejs.org/)
- **npm**: Included with Node.js

### Optional (for full functionality)
- **PowerShell 7+**: [Installation Guide](https://docs.microsoft.com/powershell)
- **GitHub CLI**: [Installation Guide](https://cli.github.com/)

## Usage Examples

### First-Time Setup
```bash
# Clone the repository (if you haven't already)
git clone https://github.com/YOUR_USERNAME/Fall-2025.git
cd Fall-2025

# Run the setup script
./setup.sh

# Follow the prompts
```

### Re-running Setup
You can safely re-run the script anytime:
```bash
./setup.sh
```

The script is idempotent - it won't duplicate work or break existing configurations.

### Skipping GitHub Project Board
If you want to skip the project board setup:
1. When prompted "Continue? (y/n)", press `n`
2. The script will complete the rest of the setup
3. You can run `./scripts/create-project-board.sh` later

## Troubleshooting

### "Node.js not found"
**Solution**: Install Node.js from [nodejs.org](https://nodejs.org/)

### "npm install" fails
**Solution**: 
1. Check your internet connection
2. Try clearing npm cache: `npm cache clean --force`
3. Delete `.mcp/node_modules` and try again

### "GitHub CLI not authenticated"
**Solution**:
```bash
gh auth login
# Follow prompts
# Make sure to enable "project" scope when asked
```

### "PowerShell not found"
**Solution**: Install PowerShell 7+
- **Windows**: `winget install Microsoft.PowerShell`
- **macOS**: `brew install --cask powershell`
- **Linux**: See [Microsoft's guide](https://docs.microsoft.com/powershell)

### Script hangs or freezes
**Solution**:
1. Press `Ctrl+C` to cancel
2. Check which step it froze on
3. Try running that step manually
4. Re-run the script

### Permission denied (Linux/Mac)
**Solution**:
```bash
chmod +x setup.sh
./setup.sh
```

## What Happens After Setup?

### Daily Workflow
1. **Update assignment trackers**:
   ```bash
   vim assignments/ENGL-1110-tracker.md
   # Change status: Not Started → In Progress → Completed
   ```

2. **Sync to project board** (optional):
   ```bash
   ./scripts/create-project-board.sh
   ```

3. **View your progress**:
   - GitHub Project Board: `https://github.com/YOUR_USERNAME?tab=projects`
   - Tracker files: `cat assignments/ENGL-1110-tracker.md`

4. **Get AI assistance**:
   - Ask Copilot: "What's due this week?"
   - Start MCP server: `cd .mcp && npm start`

### Using MCP Server
After setup, you can start the MCP server anytime:
```bash
cd .mcp
npm start
```

The server provides AI tools for:
- Viewing assignment status
- Checking due dates
- Creating study schedules
- Organizing notes
- And more

### Using GitHub Project Board
If you set up the project board, you can:
- View all assignments visually
- Filter by course (ENGL-1110 or ITEC-1475)
- Drag assignments between columns
- Track progress over the semester

Update the board by running:
```bash
./scripts/create-project-board.sh
```

## Configuration Files

The setup script works with these configuration files:

### `.mcp/package.json`
Defines MCP server dependencies. Do not edit unless you know what you're doing.

### `mcp.json`
MCP server configuration for VS Code and other clients.

### `assignments/*-tracker.md`
Assignment tracking files. Edit these to update your assignment status.

### `.github/copilot-instructions.md`
Copilot configuration for academic assistance.

## Advanced Usage

### Running Individual Steps

If you want to run only specific setup steps:

#### Just install MCP dependencies:
```bash
cd .mcp && npm install && cd ..
```

#### Just verify directories:
```bash
for dir in assignments notes schedules discussions screenshots; do
    mkdir -p "$dir"
done
```

#### Just set up project board:
```bash
./scripts/create-project-board.sh
```

### Customizing the Script

The setup scripts are designed to be modified. Feel free to:
- Add additional directory checks
- Include custom installation steps
- Add your own prerequisite checks
- Customize the output messages

Just make sure to test thoroughly after changes.

## Comparison to Manual Setup

### Manual Setup (Old Way)
```bash
# Step 1: Install MCP dependencies
cd .mcp
npm install
cd ..

# Step 2: Create directories
mkdir -p assignments notes schedules discussions screenshots

# Step 3: Check prerequisites
node --version  # Check Node
npm --version   # Check npm
pwsh --version  # Check PowerShell
gh --version    # Check GitHub CLI

# Step 4: Authenticate GitHub
gh auth login

# Step 5: Set up project board
./scripts/create-project-board.sh

# Step 6: Read documentation
cat README.md
cat START-HERE.md
cat QUICK-START-PROJECT-BOARD.md
```

### New Way (One Command)
```bash
./setup.sh
```

**Time saved**: 10-15 minutes → 2-3 minutes! ⚡

## Related Documentation

- **README.md** - Repository overview
- **START-HERE.md** - Detailed step-by-step guide
- **QUICK-START-PROJECT-BOARD.md** - Quick project board setup
- **PROJECT-BOARD-SETUP.md** - Complete project board documentation
- **scripts/README.md** - Individual script documentation
- **.mcp/README.md** - MCP server documentation

## Support

### Getting Help
1. Check this documentation
2. Read README.md for overview
3. Ask GitHub Copilot: "How do I [your question]?"
4. Check the relevant tracker file for examples

### Reporting Issues
If you encounter problems with the setup script:
1. Note which step failed
2. Check the error message
3. Try the troubleshooting steps above
4. Review the related documentation

## Best Practices

### Do's ✅
- Run the setup script in the repository root directory
- Follow the prompts carefully
- Read the summary output
- Keep the script updated as you modify your workflow

### Don'ts ❌
- Don't run the script from a different directory
- Don't interrupt the script during npm install
- Don't modify the script without understanding what it does
- Don't skip reading the output - it contains important information

## Version History

### v1.0 (Current)
- Initial release
- Consolidates all setup commands
- Checks prerequisites
- Installs MCP dependencies
- Verifies directory structure
- Optional project board setup
- Comprehensive summary output

## Future Enhancements

Potential improvements for future versions:
- Auto-update check
- Interactive mode with more options
- Custom installation profiles
- Integration with more tools
- Configuration wizard
- Health check mode

---

**Last Updated**: October 2025  
**Maintained by**: Course Repository Automation

For questions or suggestions about the setup script, ask GitHub Copilot or check the related documentation files.
