# Lab Assignments Quick Reference Guide

**Course**: ITEC 1475-80  
**Semester**: Fall 2025  
**Server**: fj3453rb-mint (10.14.75.235)

## 📋 Quick Start

### Step 1: Navigate to Lab Assignments Folder
```bash
cd /path/to/Fall-2025/lab-assignments
```

### Step 2: Choose Your Lab

#### Option A: Interactive Menu (Recommended)
```bash
sudo ./run-all-labs.sh
```
This provides a menu to select and run any lab.

#### Option B: Run Individual Labs
```bash
# Week 2 Lab 1: Hostname Configuration
sudo ./week2-lab1-hostname.sh

# Week 2 Lab 2: Software Managers
sudo ./week2-lab2-software-managers.sh

# Lennox Server Complete Setup
sudo ./lennox-server-complete-setup.sh

# Collect Outputs for Submission
sudo ./collect-lennox-outputs.sh
```

## 📚 Available Labs

### Week 2 Labs

#### Lab 1: Hostname Configuration
- **File**: `week2-lab1-hostname.sh`
- **Duration**: 30-45 minutes
- **Prerequisites**: Root access, network connectivity
- **Screenshots**: 4 required
- **Learning Objectives**:
  - Change system hostname using hostnamectl
  - Configure /etc/hosts file
  - Verify network configuration
  - Test connectivity

**Quick Commands**:
```bash
# Change hostname
sudo hostnamectl set-hostname fj3453rb-mint

# View IP address
ip a

# Edit hosts file
sudo nano /etc/hosts

# Test connectivity
ping -c 3 google.com
```

---

#### Lab 2: Software Managers
- **File**: `week2-lab2-software-managers.sh`
- **Duration**: 45-60 minutes
- **Prerequisites**: Root access, internet connection
- **Screenshots**: 6 required
- **Learning Objectives**:
  - Use APT package manager
  - Install and use Snap
  - Install and use Flatpak
  - Understand alternative installation methods

**Quick Commands**:
```bash
# APT (Debian/Ubuntu)
sudo apt update
sudo apt install <package>
sudo apt search <package>

# Snap
sudo snap install <package>
snap list
snap find <package>

# Flatpak
sudo apt install flatpak
flatpak search <package>
flatpak list
```

---

### Lennox Server Labs

#### Complete Server Setup
- **File**: `lennox-server-complete-setup.sh`
- **Duration**: 2-3 hours
- **Prerequisites**: Clean server, root access, internet
- **Screenshots**: 8 required
- **Services Configured**:
  - Apache2 web server
  - UFW firewall
  - SSH server
  - System monitoring tools

**What Gets Installed**:
- Apache2 web server
- UFW firewall
- Essential tools (curl, wget, htop, net-tools, tree, nano, vim)
- User account (serveradmin)

**Quick Commands**:
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Set hostname
sudo hostnamectl set-hostname fj3453rb-mint

# Create admin user
sudo adduser serveradmin
sudo usermod -aG sudo serveradmin

# Configure firewall
sudo apt install ufw
sudo ufw allow ssh
sudo ufw enable

# Install Apache
sudo apt install apache2
sudo systemctl start apache2
sudo systemctl status apache2

# Test web server
curl localhost
```

---

#### Collect Outputs for Submission
- **File**: `collect-lennox-outputs.sh`
- **Duration**: 2-5 minutes
- **Purpose**: Gather all system information
- **Output**: `lennox-lab-outputs.txt`
- **When to Run**: After completing Lennox server setup

**What Gets Collected**:
- System information (hostname, OS, kernel)
- Network configuration (IP, routes, DNS)
- User accounts and groups
- Security settings (SSH, UFW)
- Installed services (Apache, SSH)
- System resources (CPU, memory, disk)
- Network connectivity tests
- System logs

---

## 🖼️ Screenshot Requirements

### When to Take Screenshots
Look for the 📸 icon in the script output. Each script will pause and prompt you to take a screenshot before continuing.

### Screenshot Checklist

#### Week 2 Lab 1 (Hostname):
- [ ] New hostname from hostnamectl
- [ ] IP address from 'ip a' command
- [ ] Updated /etc/hosts file
- [ ] Ping test results

#### Week 2 Lab 2 (Software Managers):
- [ ] APT commands and package search
- [ ] Snap installation and commands
- [ ] Flatpak installation and commands
- [ ] Alternative methods overview
- [ ] Package installation example
- [ ] Package statistics

#### Lennox Server Setup:
- [ ] System update and information
- [ ] Hostname and network configuration
- [ ] User account creation
- [ ] SSH and firewall configuration
- [ ] Apache service status
- [ ] System resource monitoring
- [ ] Server documentation file
- [ ] Connectivity tests

---

## 🔧 Server Configuration Reference

### Current Configuration
```
Hostname: fj3453rb-mint
IP Address: 10.14.75.235
Network Interface: ens33
StarID: fj3453rb
```

### Important Files
- `/etc/hosts` - Hostname to IP mapping
- `/etc/hostname` - System hostname
- `/etc/ssh/sshd_config` - SSH server configuration
- `/etc/server-info.txt` - Server documentation (created by script)

### Important Commands
```bash
# System Information
hostnamectl                    # View/set hostname
ip a                          # View IP addresses
uname -a                      # Kernel information
lsb_release -a               # OS version

# User Management
sudo adduser <username>       # Create new user
sudo usermod -aG sudo <user>  # Add to sudo group
id <username>                 # View user info

# Firewall (UFW)
sudo ufw status              # Check firewall status
sudo ufw allow <service>     # Allow service
sudo ufw enable              # Enable firewall

# Services
sudo systemctl start <svc>   # Start service
sudo systemctl stop <svc>    # Stop service
sudo systemctl status <svc>  # Check status
sudo systemctl enable <svc>  # Enable at boot

# Apache Web Server
sudo systemctl status apache2  # Check status
curl localhost                 # Test locally
curl http://10.14.75.235      # Test by IP

# System Resources
df -h                         # Disk usage
free -h                       # Memory usage
htop                          # Interactive process viewer
ps aux                        # Process list
```

---

## 📁 Related Files and Documentation

### Lab Instructions
- `assignments/ITEC-1475/vcenter-lab-hostname.md`
- `assignments/ITEC-1475/vcenter-lab-software-managers.md`
- `assignments/ITEC-1475/lennox-server-setup.md`
- `assignments/ITEC-1475/other-software-managers-lab.md`

### Completion Guides
- `assignments/ITEC-1475/vcenter-lab-hostname-completion.md`
- `assignments/ITEC-1475/vcenter-lab-software-managers-completion-guide.md`
- `assignments/ITEC-1475/lennox-server-completion-guide.md`

### Submission Templates
- `assignments/ITEC-1475/submission-template.md`
- `assignments/ITEC-1475/lennox-server-submission-template.md`

### Schedules
- `schedules/week2-linux-lab-schedule.md`

---

## 💡 Tips and Best Practices

### Before Starting
1. **Read thoroughly**: Review lab instructions completely before running scripts
2. **Check requirements**: Ensure you have internet connectivity and root access
3. **Backup data**: Scripts include backups, but save important work first
4. **Screenshot tool ready**: Have your screenshot tool ready to use
5. **Time allocation**: Set aside adequate time (don't rush)

### During Lab Work
1. **Read prompts carefully**: Scripts provide context and instructions
2. **Take clear screenshots**: Ensure text is readable and complete
3. **Name screenshots systematically**: lab1-step1.png, lab1-step2.png, etc.
4. **Note any errors**: Document unexpected behavior or errors
5. **Don't skip steps**: Follow all instructions in sequence

### After Completion
1. **Review screenshots**: Verify all required screenshots are captured
2. **Organize files**: Create a clear folder structure for submission
3. **Write explanations**: Add your understanding of what each step does
4. **Proofread**: Check for completeness and clarity
5. **Submit on time**: Use appropriate assignment submission method

### Troubleshooting
1. **Permission errors**: Make sure you're using `sudo`
2. **Network errors**: Check internet connectivity
3. **Package errors**: Run `sudo apt update` first
4. **Service errors**: Check with `systemctl status <service>`
5. **Script errors**: Read error messages, check syntax

---

## 🎯 Submission Checklist

### Before Submitting
- [ ] All required screenshots captured and readable
- [ ] Screenshots organized in correct sequence
- [ ] Each screenshot labeled with step number and description
- [ ] Brief explanations written for each major step
- [ ] Troubleshooting notes included (if applicable)
- [ ] Document formatted professionally
- [ ] Spelling and grammar checked
- [ ] All required sections completed
- [ ] Personal information updated (StarID, etc.)
- [ ] File named appropriately

### Submission Contents
1. **Cover page** with your name, StarID, date
2. **Lab objective** statement (what you learned)
3. **Screenshots** with labels and descriptions
4. **Command explanations** showing understanding
5. **Results** of each major step
6. **Challenges** encountered and solutions
7. **Conclusion** summarizing the lab

---

## 🔐 Security Notes

### Important Security Practices
- Use strong passwords for all accounts
- Don't share root passwords
- Keep firewall enabled
- Regular system updates
- Monitor logs for unusual activity
- Only open necessary ports
- Use SSH keys when possible

### Default Configurations
- SSH typically runs on port 22
- Apache runs on port 80 (HTTP) and 443 (HTTPS)
- UFW default: deny incoming, allow outgoing

---

## 📞 Getting Help

### Resources
1. **Lab instructions**: Check detailed guides in assignments/ITEC-1475/
2. **Man pages**: `man <command>` for command help
3. **Instructor**: Contact for technical difficulties
4. **Classmates**: Collaborate on understanding (not copying)
5. **Online resources**: Ubuntu documentation, StackOverflow

### Common Issues
- **Script won't run**: Check if executable (`chmod +x script.sh`)
- **Permission denied**: Use `sudo` for system-level commands
- **Package not found**: Run `sudo apt update` first
- **Service won't start**: Check logs with `journalctl -u <service>`
- **Network issues**: Verify with `ping google.com`

---

*This quick reference guide is designed to help you complete ITEC 1475 lab assignments efficiently. Keep it handy while working through the labs!*
