# Lab Assignments - ITEC 1475

This folder contains organized lab assignments with scripts for quick execution.

## Available Labs

### Week 2 Labs
- **Lab 1: Hostname Configuration** - Learn to change system hostname and configure network settings
  - Script: `week2-lab1-hostname.sh`
  
- **Lab 2: Software Managers** - Explore Linux package management tools
  - Script: `week2-lab2-software-managers.sh`

### Lennox Server Labs
- **Lennox Server Setup** - Complete server configuration and service setup
  - Script: `lennox-server-complete-setup.sh`
  - Output Collection: `collect-lennox-outputs.sh`

## How to Use These Scripts

### Option 1: Interactive Menu (Recommended) ⭐
Run all labs through an easy-to-use menu system:

```bash
sudo ./run-all-labs.sh
```

This provides an interactive menu to select and run any lab, plus helpful information and options.

### Option 2: Run Individual Lab Scripts
Each lab has its own script that you can run step by step:

```bash
# Make script executable (if needed)
chmod +x week2-lab1-hostname.sh

# Run the script (with sudo)
sudo ./week2-lab1-hostname.sh
```

### Option 3: Use Complete Setup Script
For the Lennox server, there's a comprehensive script that runs all steps:

```bash
chmod +x lennox-server-complete-setup.sh
sudo ./lennox-server-complete-setup.sh
```

### 📖 Detailed Documentation
- **[QUICK-REFERENCE.md](QUICK-REFERENCE.md)** - Command reference and lab overviews
- **[USAGE-EXAMPLES.md](USAGE-EXAMPLES.md)** - Detailed examples and screenshots of what to expect

## Important Notes

- **Screenshots Required**: Many steps require screenshots. Instructions in each script indicate where to take screenshots
- **Your Information**: Replace placeholder values (StarID, IP addresses, etc.) with your actual information
- **Read Instructions**: Always read the full lab instructions before running scripts
- **Backup**: The scripts include backup commands where appropriate

## Server Information

Current configuration:
- **Hostname**: fj3453rb-mint
- **IP Address**: 10.14.75.235
- **Network Interface**: ens33

## Getting Help

If you encounter issues:
1. Check the detailed lab instructions in `/assignments/ITEC-1475/`
2. Review error messages carefully
3. Ask instructor for assistance
4. Use `man` pages for command help: `man <command>`
