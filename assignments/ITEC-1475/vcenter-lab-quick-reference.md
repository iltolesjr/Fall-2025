# Linux Homework Week 2 - Quick Command Reference

## vCenter Lab: Hostname Change - Command Guide

### 🚀 Quick Start Commands

**Step 1: Change Hostname**
```bash
# Replace [YourStarID] with your actual StarID
sudo hostnamectl set-hostname [YourStarID]-mint
hostnamectl
```

**Step 2: Find IP Address**
```bash
ip a
# Look for inet line under ens33 interface (e.g., 10.14.75.XXX)
```

**Step 3: Edit Hosts File**
```bash
sudo nano /etc/hosts
# Edit to include:
# 127.0.0.1       localhost
# 127.0.1.1       [YourStarID]-mint
# [YourIP]        [YourStarID]-mint
```

**Step 4: Verify Hosts File**
```bash
cat /etc/hosts
```

**Step 5: Test Connectivity**
```bash
ping -c 2 [hostname]
# Replace [hostname] with group member hostnames
```

---

## 📋 Lab Progress Tracker

### Essential Tasks
- [ ] 1. Change hostname to StarID-mint format
- [ ] 2. Find and document IP address
- [ ] 3. Update /etc/hosts file initially
- [ ] 4. Share IP with group members
- [ ] 5. Add group members to /etc/hosts
- [ ] 6. Test ping to all group members
- [ ] 7. Take all required screenshots
- [ ] 8. Complete submission document

### Screenshot Requirements
- [ ] `hostnamectl` output showing new hostname
- [ ] `ip a` output showing IP address
- [ ] `cat /etc/hosts` showing initial update
- [ ] `cat /etc/hosts` with group member entries
- [ ] `ping -c 2` results for each group member

---

## 🔧 Troubleshooting Common Issues

**Hostname not updating in prompt?**
- Close terminal and open a new one

**Permission denied editing /etc/hosts?**
- Make sure to use `sudo nano /etc/hosts`

**Can't ping group members?**
- Verify their systems are running
- Check /etc/hosts entries are correct
- Confirm IP addresses are current

**IP address changed?**
- DHCP may assign different IPs
- Coordinate with group if needed

---

## 📝 Nano Editor Quick Help

When editing `/etc/hosts` with nano:
- Use arrow keys to move cursor
- Type to add text
- `Ctrl+X` to exit
- `Y` to save changes
- `Enter` to confirm filename

---

## 🎯 Example Output Formats

**Expected hostnamectl output:**
```
Static hostname: [YourStarID]-mint
Icon name: computer-vm
Chassis: vm
...
```

**Expected /etc/hosts format:**
```
127.0.0.1       localhost
127.0.1.1       [YourStarID]-mint
10.14.75.XXX    [YourStarID]-mint
10.14.75.205    gf4321yk-mint
```

**Expected ping output:**
```
PING hostname (IP) 56(84) bytes of data.
64 bytes from hostname (IP): icmp_seq=1 ttl=64 time=X.XXX ms
64 bytes from hostname (IP): icmp_seq=2 ttl=64 time=X.XXX ms

--- hostname ping statistics ---
2 packets transmitted, 2 received, 0% packet loss
```

---

## 📚 Academic Notes

- Complete work individually except for IP sharing
- Screenshots must be from your own system
- Collaborate appropriately for group member coordination
- Ask instructor if you need help
- Keep your system running so others can ping you

---

*Use this guide alongside the main completion document for efficient lab completion.*