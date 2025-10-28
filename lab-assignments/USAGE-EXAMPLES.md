# Lab Assignments - Usage Examples

This guide shows you exactly what to expect when using the lab assignment scripts.

## 📖 Table of Contents
1. [Getting Started](#getting-started)
2. [Interactive Menu System](#interactive-menu-system)
3. [Individual Lab Scripts](#individual-lab-scripts)
4. [Output Collection](#output-collection)
5. [Customization Guide](#customization-guide)

---

## Getting Started

### Prerequisites
- Linux system (Ubuntu/Linux Mint recommended)
- Root/sudo access
- Internet connectivity
- Screenshot tool ready

### First Time Setup

1. **Navigate to the folder:**
   ```bash
   cd /path/to/Fall-2025/lab-assignments
   ```

2. **Verify scripts are executable:**
   ```bash
   ls -l *.sh
   # All scripts should show -rwxr-xr-x
   ```

3. **If needed, make them executable:**
   ```bash
   chmod +x *.sh
   ```

---

## Interactive Menu System

### Running the Menu
```bash
sudo ./run-all-labs.sh
```

### What You'll See

```
╔════════════════════════════════════════════════════════════════╗
║         ITEC 1475 Lab Assignment Runner                        ║
║         Fall 2025 - Interactive Menu System                    ║
╚════════════════════════════════════════════════════════════════╝

Current Server Configuration:
  • Hostname: fj3453rb-mint
  • IP Address: 10.14.75.235
  • Network Interface: ens33
  • StarID: fj3453rb

Available Labs:

  Week 2 Labs:
    1) Week 2 Lab 1: Hostname Configuration
    2) Week 2 Lab 2: Software Managers

  Lennox Server Labs:
    3) Lennox Server Complete Setup
    4) Collect Lennox Outputs (for submission)

  Special Options:
    5) Run All Week 2 Labs (1 + 2)
    6) Run Everything (All labs in sequence)

    i) Show Lab Information
    h) Display Help
    q) Quit

Enter your choice: _
```

### Menu Options Explained

- **Options 1-4**: Run individual lab scripts
- **Option 5**: Automatically runs both Week 2 labs in sequence
- **Option 6**: Runs all labs (Week 2 + Lennox Server) in sequence
- **Option i**: Shows detailed information about each lab
- **Option h**: Displays help and tips
- **Option q**: Exit the menu

---

## Individual Lab Scripts

### Week 2 Lab 1: Hostname Configuration

**Command:**
```bash
sudo ./week2-lab1-hostname.sh
```

**What Happens:**
1. Script displays welcome header with lab information
2. Shows current hostname and what will be changed
3. Executes each step with clear output
4. Pauses at screenshot points with 📸 icon
5. Waits for you to take screenshot before continuing
6. Displays summary at completion

**Example Output:**

```
╔════════════════════════════════════════════════════════════════╗
║    Week 2 Lab 1: Hostname Configuration - ITEC 1475           ║
║    Fall 2025                                                   ║
╚════════════════════════════════════════════════════════════════╝

INFO: This lab focuses on hostname management and network configuration.
INFO: You will change the system hostname and configure network settings.

Press Enter to begin...

===== STEP 1: Change the Hostname =====
INFO: Current hostname: ubuntu-vm
WARNING: We will change the hostname to: fj3453rb-mint
WARNING: Note: Replace 'fj3453rb' with YOUR actual StarID!

INFO: Setting hostname...
INFO: Verifying hostname change...

 Static hostname: fj3453rb-mint
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 8c6e837f55634ae5922907eecccec3b8
         Boot ID: 3d0db85e235c46d18c81b9ff0013d326
  Virtualization: vmware
Operating System: Linux Mint 22.1
          Kernel: Linux 6.8.0-51-generic
    Architecture: x86-64

📸 SCREENSHOT REQUIRED: New hostname displayed by hostnamectl command
Press Enter after taking the screenshot to continue...
```

**Duration:** ~30-45 minutes (including screenshot time)

---

### Week 2 Lab 2: Software Managers

**Command:**
```bash
sudo ./week2-lab2-software-managers.sh
```

**What Happens:**
1. Explores APT package manager with examples
2. Installs and demonstrates Snap
3. Installs and demonstrates Flatpak
4. Shows alternative installation methods
5. Provides practical package installation examples
6. Displays package statistics

**Example Output:**

```
╔════════════════════════════════════════════════════════════════╗
║    Week 2 Lab 2: Software Managers - ITEC 1475                ║
║    Fall 2025                                                   ║
╚════════════════════════════════════════════════════════════════╝

INFO: This lab reviews various software management tools on Linux.
INFO: You will explore APT, Snap, Flatpak, and other package managers.

Press Enter to begin...

===== PART 1: APT Package Manager (Debian/Ubuntu) =====
INFO: Updating package lists...
Hit:1 http://packages.linuxmint.com vera InRelease
Hit:2 http://archive.ubuntu.com/ubuntu noble InRelease
Reading package lists... Done

INFO: APT Commands Overview:

Basic APT Commands:
  apt update              - Update package lists
  apt upgrade             - Upgrade all packages
  apt install <package>   - Install a package
  apt remove <package>    - Remove a package
  apt search <package>    - Search for packages
  apt show <package>      - Show package details
  apt list --installed    - List installed packages

📸 SCREENSHOT REQUIRED: APT commands and package information
Press Enter after taking the screenshot to continue...
```

**Duration:** ~45-60 minutes

---

### Lennox Server Complete Setup

**Command:**
```bash
sudo ./lennox-server-complete-setup.sh
```

**What Happens:**
1. Updates system packages
2. Configures hostname
3. Creates administrative user (serveradmin)
4. Configures SSH and UFW firewall
5. Installs Apache web server
6. Sets up system monitoring
7. Creates server documentation
8. Tests connectivity and services

**Example Output:**

```
╔════════════════════════════════════════════════════════════════╗
║     Lennox Server Complete Setup Lab - ITEC 1475              ║
║     Fall 2025 - Automated Installation Script                 ║
╚════════════════════════════════════════════════════════════════╝

INFO: This script will guide you through the complete server setup.
INFO: You will be prompted to take screenshots at required points.

Press Enter to begin...

===== STEP 1: Initial System Setup =====
INFO: Updating system packages...
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done

INFO: Checking system information...

 Static hostname: fj3453rb-mint
       Icon name: computer-vm
         Chassis: vm

📸 SCREENSHOT REQUIRED: System update completion and system information
Press Enter after taking the screenshot to continue...

===== STEP 2: Configure Server Hostname and Network =====
INFO: Current hostname: ubuntu-vm
INFO: Setting hostname to: fj3453rb-mint

[... continues through all 8 steps ...]

===== SETUP COMPLETE! =====

╔════════════════════════════════════════════════════════════════╗
║          Lennox Server Setup Completed Successfully!           ║
╚════════════════════════════════════════════════════════════════╝

INFO: Server Configuration Summary:
  • Hostname: fj3453rb-mint
  • IP Address: 10.14.75.235
  • Admin User: serveradmin
  • Firewall: Enabled (UFW)
  • Web Server: Apache2 (Running)
  • Essential Tools: Installed
  • Documentation: /etc/server-info.txt

INFO: Next Steps:
  1. Review all screenshots you captured
  2. Organize screenshots into a submission document
  3. Add brief explanations for each step
  4. Submit to the Lennox Server Setup assignment folder

INFO: To collect all outputs in one file, run:
  sudo ./collect-lennox-outputs.sh

Thank you for using the automated setup script!
```

**Duration:** ~2-3 hours (includes user interaction and screenshots)

---

## Output Collection

### Collect Lennox Outputs Script

**Command:**
```bash
sudo ./collect-lennox-outputs.sh
```

**What It Does:**
- Gathers all system information
- Collects service statuses
- Tests connectivity
- Creates a single file: `lennox-lab-outputs.txt`

**Example Output:**

```
Collecting Lennox Lab outputs...

Lennox Lab outputs collected on: Tue Oct 28 07:38:47 AM CDT 2025
Server: fj3453rb-mint
IP Address: 10.14.75.235

═══════════════════════════════════════════════════════════════
                    SYSTEM INFORMATION
═══════════════════════════════════════════════════════════════

=== Hostnamectl ===
 Static hostname: fj3453rb-mint
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 8c6e837f55634ae5922907eecccec3b8
[... continues with all system info ...]

═══════════════════════════════════════════════════════════════
                    COMPLETION
═══════════════════════════════════════════════════════════════

✓ All outputs collected successfully!
✓ Output saved to: lennox-lab-outputs.txt

You can now review the file and include it in your lab submission.
```

**Output File Location:** Same directory where you ran the script

**Usage:** Include this file in your lab submission to show all system configurations

---

## Customization Guide

### Updating Server Information

Before running any scripts, you should customize them with YOUR information:

1. **Open a script in your favorite editor:**
   ```bash
   nano week2-lab1-hostname.sh
   # or
   vim lennox-server-complete-setup.sh
   ```

2. **Find and replace these values:**
   - `fj3453rb` → Your StarID
   - `fj3453rb-mint` → Your desired hostname
   - `10.14.75.235` → Your IP address (if different)
   - `ens33` → Your network interface (if different)

3. **Look for these sections near the top of each script:**
   ```bash
   # SERVER INFORMATION:
   # Hostname: fj3453rb-mint
   # IP Address: 10.14.75.235
   # Network Interface: ens33
   ```

### Finding Your Own Information

**Your IP Address:**
```bash
ip a
# Look for inet line under your interface (usually ens33, eth0, or enp0s3)
```

**Your Hostname:**
```bash
hostname
# or
hostnamectl
```

**Your Network Interface:**
```bash
ip link show
# or
ip a
# Interface names are like ens33, eth0, enp0s3, wlan0
```

---

## Tips for Best Results

### Screenshot Best Practices
1. **Capture the full terminal window** including command and output
2. **Make sure text is readable** - zoom if needed
3. **Include the username@hostname prompt** in each screenshot
4. **Name files systematically**: `lab1-step1.png`, `lab1-step2.png`, etc.
5. **Save in a dedicated folder** for organization

### Common Issues and Solutions

**Issue: "Permission denied"**
```bash
# Solution: Use sudo
sudo ./script-name.sh
```

**Issue: "Script not executable"**
```bash
# Solution: Make it executable
chmod +x script-name.sh
```

**Issue: "Command not found"**
```bash
# Solution: Make sure you're in the right directory
cd /path/to/Fall-2025/lab-assignments
pwd  # Should show .../Fall-2025/lab-assignments
```

**Issue: "Package not found"**
```bash
# Solution: Update package lists first
sudo apt update
```

---

## Submission Workflow

### Recommended Process

1. **Run the lab script(s)**
   - Follow prompts carefully
   - Take all required screenshots
   - Don't skip any steps

2. **Collect outputs (for Lennox labs)**
   ```bash
   sudo ./collect-lennox-outputs.sh
   ```

3. **Organize your files**
   ```
   lab-submission/
   ├── screenshots/
   │   ├── step1-hostname.png
   │   ├── step2-ip-address.png
   │   ├── step3-hosts-file.png
   │   └── ...
   ├── lennox-lab-outputs.txt (if applicable)
   └── lab-report.docx (or .pdf)
   ```

4. **Create submission document**
   - Include cover page with your info
   - Add each screenshot with explanation
   - Include the output file if applicable
   - Add conclusion/reflection

5. **Review checklist**
   - [ ] All required screenshots included
   - [ ] Screenshots are clear and readable
   - [ ] Each step has explanation
   - [ ] Personal information updated (StarID)
   - [ ] Document is properly formatted
   - [ ] File named appropriately

6. **Submit through proper channel**
   - Course LMS/assignment folder
   - Follow instructor's submission guidelines

---

## Need Help?

### Resources Available
- **README.md**: General information about labs
- **QUICK-REFERENCE.md**: Command quick reference
- **Lab instructions**: See `assignments/ITEC-1475/` folder
- **Instructor**: Contact for technical assistance

### Getting Support
1. Check the error message carefully
2. Review related documentation
3. Try searching for the error online
4. Ask classmates (for understanding, not copying)
5. Contact instructor if stuck

---

*This usage guide is designed to help you successfully complete all ITEC 1475 lab assignments. Keep it handy as a reference while working through the labs!*
