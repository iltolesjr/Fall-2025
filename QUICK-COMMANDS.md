# Quick Command Reference

**Too many files? Just run ONE command!** 🎯

## Setup (First Time)

```bash
# Linux/Mac
./setup.sh

# Windows
setup.bat
```

That's it! Everything else is automatic.

## Daily Commands

### View Assignments
```bash
# ENGL-1110
cat assignments/ENGL-1110-tracker.md

# ITEC-1475
cat assignments/ITEC-1475-tracker.md
```

### Update Project Board
```bash
./scripts/create-project-board.sh
```

### Start MCP Server
```bash
cd .mcp && npm start
```

## What the Setup Script Does

1. ✅ Checks prerequisites (Node.js, npm, PowerShell, GitHub CLI)
2. ✅ Installs MCP server dependencies
3. ✅ Verifies directory structure
4. ✅ Sets up GitHub Project Board (optional)
5. ✅ Shows complete summary

## Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Node.js not found | Install from [nodejs.org](https://nodejs.org/) |
| GitHub not authenticated | Run `gh auth login` |
| PowerShell not found | Install from [microsoft.com/powershell](https://docs.microsoft.com/powershell) |
| Permission denied | Run `chmod +x setup.sh` |

## Documentation

- **SETUP-GUIDE.md** - Complete setup documentation
- **README.md** - Repository overview
- **START-HERE.md** - Step-by-step guide
- **QUICK-START-PROJECT-BOARD.md** - Project board quick start

## Need More Help?

Ask GitHub Copilot:
- "How do I run the setup script?"
- "What does the setup script do?"
- "Show me my assignment status"
- "What's due this week?"

---

**Remember**: You don't need to run multiple commands anymore. Just run `./setup.sh` and you're done! 🚀
