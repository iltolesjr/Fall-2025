# Week 2 Linux Homework - Complete Resource Package

## 📚 Assignment Overview
**Course**: ITEC 1475-80 Fall 2025  
**Assignment**: vCenter Lab: Change the Hostname  
**Due**: Week 2  
**Type**: Linux System Administration Lab  

---

## 🎯 Learning Objectives
By completing this homework, you will:
- Master Linux hostname management using modern systemd tools
- Configure network host resolution via /etc/hosts file
- Test network connectivity between systems using ping
- Understand IP address configuration and DHCP concepts
- Practice collaborative learning with group coordination

---

## 📁 Resource Files Created

### 1. **Main Lab Instructions**
- **File**: `assignments/ITEC-1475/vcenter-lab-hostname.md`
- **Purpose**: Complete step-by-step lab instructions
- **Use**: Primary reference for lab requirements

### 2. **Completion Document Template** ⭐ START HERE
- **File**: `assignments/ITEC-1475/vcenter-lab-hostname-completion.md`
- **Purpose**: Structured submission template with checklist
- **Use**: Fill in as you complete each lab task

### 3. **Quick Reference Guide**
- **File**: `assignments/ITEC-1475/vcenter-lab-quick-reference.md`
- **Purpose**: Essential commands and troubleshooting
- **Use**: Keep open while working in terminal

### 4. **Study Schedule & Time Management**
- **File**: `schedules/week2-linux-lab-schedule.md`
- **Purpose**: Day-by-day breakdown and time allocation
- **Use**: Plan your lab work efficiently

---

## 🚀 Getting Started - Quick Steps

### Step 1: Preparation (5 minutes)
1. Read the main lab instructions completely
2. Open the completion document template
3. Connect to ITEC vCenter environment

### Step 2: Core Lab Tasks (45-60 minutes)
1. **Change Hostname**: `sudo hostnamectl set-hostname [YourStarID]-mint`
2. **Find IP Address**: `ip a` (look for 10.14.75.XXX)
3. **Update Hosts File**: `sudo nano /etc/hosts`
4. **Take Screenshots**: Document each major step

### Step 3: Group Collaboration (30 minutes)
1. **Share Information**: Post StarID and IP in group discussion
2. **Collect Group Data**: Gather classmate information
3. **Update Hosts File**: Add all group member entries

### Step 4: Testing & Submission (30 minutes)
1. **Test Connectivity**: `ping -c 2 [hostname]` for each member
2. **Complete Documentation**: Fill in all template sections
3. **Submit**: Upload to vCenter Lab assignment folder

---

## 📋 Required Screenshots Checklist

Make sure you capture these 5 essential screenshots:

1. **📸 Hostname Change**: `hostnamectl` output showing new StarID-mint hostname
2. **📸 IP Discovery**: `ip a` output highlighting your system's IP address
3. **📸 Initial Hosts File**: `cat /etc/hosts` showing your hostname/IP entry
4. **📸 Group Hosts File**: `cat /etc/hosts` with all group member entries
5. **📸 Ping Tests**: `ping -c 2` results for each group member system

---

## 🔧 Essential Commands Reference

```bash
# Core Lab Commands
sudo hostnamectl set-hostname [YourStarID]-mint
hostnamectl
ip a
sudo nano /etc/hosts
cat /etc/hosts
ping -c 2 [hostname]

# Nano Editor Controls
# Ctrl+X = Exit
# Y = Save changes
# Enter = Confirm filename
```

---

## 👥 Group Collaboration Guide

### Information to Share
- Your StarID (e.g., ab1234cd)
- Your system's IP address (e.g., 10.14.75.123)

### Information to Collect
- Each group member's StarID and IP
- Format hostnames as: [StarID]-mint

### /etc/hosts Format
```
127.0.0.1       localhost
127.0.1.1       [YourStarID]-mint
[YourIP]        [YourStarID]-mint
[Member1IP]     [Member1StarID]-mint
[Member2IP]     [Member2StarID]-mint
[Member3IP]     [Member3StarID]-mint
10.14.75.205    gf4321yk-mint
```

---

## ⚠️ Important Reminders

### Technical Requirements
- Must use ITEC vCenter environment
- Keep your system running so others can ping you
- Use exact hostname format: [StarID]-mint

### Academic Integrity
- Complete individual work except for IP sharing
- Screenshots must be from your own system
- Collaborate appropriately for group coordination only

### Submission Requirements
- All 5 screenshots properly labeled and clear
- Complete submission document with all sections filled
- Submit to correct vCenter Lab assignment folder

---

## 🆘 Getting Help

### If You Need Assistance
- **Copilot Commands**: 
  - "Help me troubleshoot this Linux command"
  - "Explain what this error means"
  - "Create a checklist for my lab progress"

### Common Issues & Solutions
- **Hostname not updating**: Close and reopen terminal
- **Permission denied**: Use `sudo` for system files
- **Can't ping others**: Verify systems are running and hosts entries correct
- **IP address changed**: DHCP may reassign; coordinate with group

---

## 🎓 Learning Extensions

### After Completing the Lab
- Research DNS vs /etc/hosts resolution order
- Explore other `hostnamectl` options
- Learn about systemd service management
- Practice additional network troubleshooting commands

### Connect to Future Topics
- File permissions and ownership
- Network services configuration  
- System administration automation
- Security considerations for hostname resolution

---

**Ready to Start?** 
1. Open `assignments/ITEC-1475/vcenter-lab-hostname-completion.md`
2. Connect to vCenter
3. Follow the step-by-step checklist
4. Use the quick reference guide as needed

*Good luck with your Linux homework! Remember, this lab builds essential system administration skills you'll use throughout the course.*