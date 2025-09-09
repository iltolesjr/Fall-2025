# vCenter Lab: Change the Hostname - Completion Document
## ITEC 1475-80 Fall 2025

**Student Name**: [Enter Your Name]  
**StarID**: [Enter Your StarID]  
**Date**: [Enter Date]  
**Instructor**: Brian Huilman  

---

## Lab Completion Checklist

### Pre-Lab Setup
- [ ] Connected to ITEC vCenter via OpenVPN
- [ ] Logged into Linux Mint system (username: itec, password: itecitec)
- [ ] Opened Terminal window

### Task 1: Change the Hostname ✅
- [ ] **Command Executed**: `sudo hostnamectl set-hostname [YourStarID]-mint`
- [ ] **Verification**: `hostnamectl` command shows new hostname
- [ ] **Screenshot Taken**: Terminal showing `hostnamectl` output

**📸 Screenshot 1 - New Hostname**
```
[INSERT SCREENSHOT HERE]
- Must show: hostnamectl command output with your StarID-mint hostname
- Label: "Task 1 - Hostname Change Verification"
```

**New Hostname**: `[YourStarID]-mint`

---

### Task 2: Find Your IP Address ✅
- [ ] **Command Executed**: `ip a`
- [ ] **IP Address Identified**: [Enter your IP address]
- [ ] **Screenshot Taken**: Terminal showing IP configuration

**📸 Screenshot 2 - IP Address Discovery**
```
[INSERT SCREENSHOT HERE]
- Must show: ip a command output with your system's IP address highlighted
- Label: "Task 2 - IP Address Configuration"
```

**System IP Address**: `[Enter your IP address, e.g., 10.14.75.XXX]`

---

### Task 3: Update the /etc/hosts File ✅
- [ ] **Command Executed**: `sudo nano /etc/hosts`
- [ ] **File Updated**: Added hostname and IP address entries
- [ ] **Verification**: `cat /etc/hosts` shows updated content
- [ ] **Screenshot Taken**: Terminal showing updated hosts file

**📸 Screenshot 3 - Initial Hosts File Update**
```
[INSERT SCREENSHOT HERE]
- Must show: cat /etc/hosts output with your hostname and IP
- Label: "Task 3 - Updated /etc/hosts File"
```

**Updated /etc/hosts Content**:
```
127.0.0.1       localhost
127.0.1.1       [YourStarID]-mint
[YourIPAddress] [YourStarID]-mint
```

---

### Task 4: Group Collaboration Phase ✅
- [ ] **Posted Information**: Shared StarID and IP in group discussion
- [ ] **Collected Group Data**: Gathered group member information
- [ ] **Updated Hosts File**: Added all group member entries
- [ ] **Screenshot Taken**: Updated hosts file with group entries

**📸 Screenshot 4 - Group Members in Hosts File**
```
[INSERT SCREENSHOT HERE]
- Must show: cat /etc/hosts with all group member entries
- Label: "Task 4 - Complete Hosts File with Group Members"
```

**Group Member Information**:
| StarID | IP Address | Hostname |
|--------|------------|----------|
| [Member1] | [IP1] | [StarID1]-mint |
| [Member2] | [IP2] | [StarID2]-mint |
| [Member3] | [IP3] | [StarID3]-mint |
| gf4321yk | 10.14.75.205 | gf4321yk-mint |

---

### Task 5: Network Connectivity Testing ✅
- [ ] **Ping Tests Completed**: Tested each group member system
- [ ] **Screenshots Taken**: Successful ping results for each member

**📸 Screenshot 5 - Ping Test Results**
```
[INSERT SCREENSHOT HERE for each group member]
- Must show: ping -c 2 [hostname] results for each group member
- Label: "Task 5 - Network Connectivity Testing"
```

**Ping Test Results**:

**Group Member 1**: `ping -c 2 [hostname1]`
- [ ] **Success** - [ ] **Failed**
- **Result**: [Brief description]

**Group Member 2**: `ping -c 2 [hostname2]`
- [ ] **Success** - [ ] **Failed** 
- **Result**: [Brief description]

**Group Member 3**: `ping -c 2 [hostname3]`
- [ ] **Success** - [ ] **Failed**
- **Result**: [Brief description]

**Instructor System**: `ping -c 2 gf4321yk-mint`
- [ ] **Success** - [ ] **Failed**
- **Result**: [Brief description]

---

## Lab Summary

### Commands Used Reference
| Command | Purpose | Result |
|---------|---------|---------|
| `sudo hostnamectl set-hostname [StarID]-mint` | Change system hostname | ✅ |
| `hostnamectl` | Verify hostname change | ✅ |
| `ip a` | Display IP configuration | ✅ |
| `sudo nano /etc/hosts` | Edit hosts file | ✅ |
| `cat /etc/hosts` | Display hosts file content | ✅ |
| `ping -c 2 [hostname]` | Test network connectivity | ✅ |

### Learning Objectives Achieved
- [x] Successfully changed system hostname using modern Linux tools
- [x] Configured network host resolution via /etc/hosts file
- [x] Tested network connectivity between group systems
- [x] Demonstrated understanding of IP address configuration

### Technical Notes
- **Hostname Change**: Used `hostnamectl` command (modern systemd approach)
- **Network Configuration**: Manual /etc/hosts entries for local name resolution
- **Connectivity Testing**: ICMP ping tests with packet count limitation
- **Group Collaboration**: Coordinated with group members for IP sharing

### Challenges Encountered
[Describe any issues you faced and how you resolved them]

### Academic Integrity Statement
- [ ] I completed this work individually except for appropriate group information sharing
- [ ] All screenshots are from my own system and terminal sessions
- [ ] I collaborated appropriately with group members only for IP address collection
- [ ] I understand the concepts demonstrated in this lab

---

## Submission Verification

### Final Checklist
- [ ] All 5 screenshots included and properly labeled
- [ ] Screenshots show complete terminal output and are clearly readable
- [ ] Group member information collected and documented
- [ ] All ping tests attempted and results documented
- [ ] Academic integrity statement completed
- [ ] Document properly formatted and organized

### Submission Details
**Submitted To**: vCenter Lab assignment folder  
**Submission Date**: [Enter submission date]  
**File Format**: [PDF/Word document with embedded screenshots]

---

*This lab completion document demonstrates Linux system administration skills including hostname management, network configuration, and connectivity testing as required for ITEC 1475 coursework.*