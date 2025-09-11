# vCenter Lab Submission - Change Hostname
**Student**: [Your Name]  
**StarID**: [Your StarID]  
**Course**: ITEC 1475-80  
**Date**: [Submission Date]  

---

## Screenshot Documentation

### Step 1: Hostname Change ✅
**Command Used**: `sudo hostnamectl set-hostname [StarID]-mint`

**Screenshot 1**: Terminal showing hostname change command and verification
![Hostname Screenshot](screenshots/01-hostname-change.png)

**Verification**: `hostnamectl` command output showing new hostname

---

### Step 2: IP Address Identification ✅
**Command Used**: `ip a`

**Screenshot 2**: IP address output from network configuration
![IP Address Screenshot](screenshots/02-ip-address.png)

**Identified IP Address**: [Your IP Address Here]

---

### Step 3: Initial /etc/hosts Update ✅
**Commands Used**: 
- `sudo nano /etc/hosts`
- `cat /etc/hosts`

**Screenshot 3**: Updated /etc/hosts file with hostname entries
![Hosts File Screenshot](screenshots/03-hosts-initial.png)

**Changes Made**:
- Updated second line to include new hostname
- Added IP address entry for hostname

---

### Step 4: Group Member Hosts Entries ✅
**Group Members Information**:
- Member 1: [StarID] - [IP Address]
- Member 2: [StarID] - [IP Address]  
- Member 3: [StarID] - [IP Address]

**Screenshot 4**: Complete /etc/hosts file with all group members
![Complete Hosts File Screenshot](screenshots/04-hosts-complete.png)

---

### Step 5: Connectivity Testing ✅

#### Ping Test Results

**Group Member 1**: [StarID]-mint
**Command**: `ping -c 2 [StarID]-mint`
**Screenshot 5**: Successful ping to member 1
![Ping Member 1 Screenshot](screenshots/05-ping-member1.png)

**Group Member 2**: [StarID]-mint
**Command**: `ping -c 2 [StarID]-mint`
**Screenshot 6**: Successful ping to member 2
![Ping Member 2 Screenshot](screenshots/06-ping-member2.png)

**Group Member 3**: [StarID]-mint
**Command**: `ping -c 2 [StarID]-mint`
**Screenshot 7**: Successful ping to member 3
![Ping Member 3 Screenshot](screenshots/07-ping-member3.png)

---

## Lab Completion Summary

### Requirements Met ✅
- [x] System hostname changed to [StarID]-mint
- [x] IP address identified and documented
- [x] /etc/hosts file updated with hostname mapping
- [x] Group member entries added to /etc/hosts
- [x] Successful connectivity tests to all group members
- [x] All required screenshots captured and labeled
- [x] System left running for group member testing

### Technical Skills Demonstrated
- Linux hostname management using `hostnamectl`
- Network configuration analysis with `ip` command
- System file editing with `nano` and proper permissions
- Network troubleshooting with `ping` command
- Understanding of DNS/hosts file resolution

### Group Collaboration
Successfully coordinated with group members to:
- Share hostname and IP information
- Update hosts files with member entries
- Test network connectivity between systems
- Maintain systems for mutual testing access

---

## Submission Checklist ✅
- [x] All 7 required screenshots included
- [x] Screenshots clearly labeled and organized
- [x] Complete /etc/hosts file documented
- [x] Successful ping results for all group members shown
- [x] Document formatting professional and readable
- [x] All technical requirements met per lab instructions

---

**Submission Notes**: [Any additional comments or issues encountered]

**Date Completed**: [Completion Date]  
**Time Invested**: [Estimated hours]

---

*This submission follows the requirements outlined in the vCenter Lab: Change Hostname assignment for ITEC 1475-80.*