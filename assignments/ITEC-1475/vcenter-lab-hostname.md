# vCenter Lab: Change the Hostname - ITEC 1475

**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Semester**: Fall 2025  
**Lab Type**: Linux System Administration  

## Lab Overview

This lab focuses on Linux system hostname management, network configuration, and connectivity testing. You will learn essential system administration skills including hostname changes, hosts file management, and network troubleshooting.

## Learning Objectives

- Change system hostname using modern Linux tools
- Configure network host resolution via /etc/hosts
- Test network connectivity between systems
- Understand IP address configuration and management

## Step-by-Step Instructions

### 1. Change the Hostname

Change your system hostname to include your StarID:

```bash
sudo hostnamectl set-hostname <YourStarID>-mint
hostnamectl
```

**Replace `<YourStarID>` with your actual StarID** (e.g., `gf4321yk`).

**📸 Screenshot Required**: Take a screenshot showing the new hostname displayed by the `hostnamectl` command.

---

### 2. Find Your IP Address

Determine your system's current IP address:

```bash
ip a
```

Look for the IP address associated with your system (e.g., `10.14.75.205`) under the section starting with `inet`.

**📸 Screenshot Required**: Take a screenshot showing the IP address output.

---

### 3. Update the `/etc/hosts` File

Edit the system hosts file to reflect your new hostname:

```bash
sudo nano /etc/hosts
```

**Modify the file as follows:**
1. Update the second line to include your new hostname
2. Add a new line with your system's IP address and hostname

**Example updated `/etc/hosts` file:**
```
127.0.0.1       localhost
127.0.1.1       <YourStarID>-mint
<YourIPAddress> <YourStarID>-mint
```

**Replace:**
- `<YourStarID>` with your StarID 
- `<YourIPAddress>` with your system IP

**Save and exit**: Press `CTRL-X`, then `Y`, and `ENTER`.

**Verify changes:**
```bash
cat /etc/hosts
```

**📸 Screenshot Required**: Take a screenshot showing the updated `/etc/hosts` file.

---

### 4. Share and Add Group Members to `/etc/hosts`

**Group Collaboration Phase:**

1. **Post your information**: Share your StarID and IP address in your group discussion area
2. **Collect group member info**: Throughout the week, gather IP addresses from group members
3. **Update hosts file**: Add entries for each group member

**Example updated file:**
```
127.0.0.1       localhost
127.0.1.1       <YourStarID>-mint
10.14.75.205    gf4321yk-mint
10.14.75.206    ab1234cd-mint
10.14.75.207    ef5678gh-mint
```

**Verify group entries:**
```bash
cat /etc/hosts
```

**📸 Screenshot Required**: Take a screenshot of the updated file with group member entries.

---

### 5. Ping Other Systems

Test connectivity to each group member's system:

```bash
ping -c 2 <GroupMemberHostname>
```

**Example:**
```bash
ping -c 2 gf4321yk-mint
```

**📸 Screenshot Required**: Take a screenshot showing successful ping results for each group member.

---

### 6. System Management

**Important**: Leave your system running so other group members can ping your system for their lab completion.

---

## Submission Requirements

### Documentation Checklist

- [ ] Screenshot of `hostnamectl` showing new hostname
- [ ] Screenshot of `ip a` command showing IP address
- [ ] Screenshot of updated `/etc/hosts` file (initial)
- [ ] Screenshot of `/etc/hosts` with group member entries
- [ ] Screenshot of successful ping results for each group member
- [ ] All screenshots clearly labeled and organized
- [ ] Document submitted to appropriate assignment folder

### Submission Format

1. **Combine all screenshots** into a single document
2. **Label each section** clearly with task numbers
3. **Ensure screenshots are readable** and show complete terminal output
4. **Submit document** to the vCenter Lab assignment folder

## Technical Notes

### Commands Reference

| Command | Purpose |
|---------|---------|
| `hostnamectl` | Display/set system hostname |
| `ip a` | Show IP address configuration |
| `sudo nano /etc/hosts` | Edit hosts file |
| `cat /etc/hosts` | Display hosts file content |
| `ping -c 2 hostname` | Test connectivity (2 packets) |

### Troubleshooting Tips

- **Hostname not updating in prompt**: Close and reopen terminal window
- **Permission denied**: Ensure you're using `sudo` for system file edits
- **Cannot ping group members**: Verify their systems are running and hosts file entries are correct
- **IP address changes**: DHCP may assign different IPs; coordinate with group if needed

## Academic Integrity

- Complete work individually except for group information sharing
- Screenshots must be from your own system
- Collaborate appropriately for group member IP collection
- Ask instructor for help if needed

---

*This lab assignment is designed to work with GitHub Copilot for enhanced learning support and academic workflow management.*