# Week 2 Linux Assignment Completion Guide - ITEC 1475

**Assignment**: vCenter Lab - Change Hostname  
**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Status**: 🔴 Not Started → 🟡 In Progress → 🟢 Completed  

## Quick Start Checklist

### Pre-Lab Preparation
- [ ] Ensure you have access to a Linux system (Ubuntu/Mint)
- [ ] Have terminal access with sudo privileges
- [ ] Identify your StarID for hostname setup
- [ ] Create a folder for storing screenshots

### Lab Steps Progress Tracker

#### Step 1: Change Hostname ⏱️ (~5 minutes)
- [ ] Run `sudo hostnamectl set-hostname <YourStarID>-mint`
- [ ] Verify with `hostnamectl` command
- [ ] **📸 Screenshot**: Terminal showing new hostname
- [ ] Restart terminal to see hostname change in prompt

#### Step 2: Find IP Address ⏱️ (~3 minutes)
- [ ] Run `ip a` command
- [ ] Identify your system's IP address (look for inet line)
- [ ] **📸 Screenshot**: IP address output
- [ ] Note down your IP address: ________________

#### Step 3: Update /etc/hosts File ⏱️ (~10 minutes)
- [ ] Open hosts file: `sudo nano /etc/hosts`
- [ ] Update second line with your hostname
- [ ] Add new line with your IP and hostname
- [ ] Save and exit (Ctrl+X, Y, Enter)
- [ ] Verify with `cat /etc/hosts`
- [ ] **📸 Screenshot**: Updated /etc/hosts file

#### Step 4: Group Collaboration ⏱️ (~Throughout week)
- [ ] Post your StarID and IP in [Systems Group #4 Discussion](../../discussions/ITEC-1475/systems-group-4.md)
- [ ] Use the [Group Member Template](../../discussions/ITEC-1475/group-member-template.md) to track information
- [ ] Collect group members' information:
  - Member 1: StarID: _______ IP: _______
  - Member 2: StarID: _______ IP: _______
  - Member 3: StarID: _______ IP: _______
- [ ] Add group members to your /etc/hosts file
- [ ] **📸 Screenshot**: /etc/hosts with group entries

#### Step 5: Test Connectivity ⏱️ (~5 minutes per member)
- [ ] Ping each group member: `ping -c 2 <hostname>`
- [ ] **📸 Screenshot**: Successful ping results for each member
- [ ] Keep your system running for others to ping you

### Submission Preparation ⏱️ (~15 minutes)
- [ ] Organize all screenshots in chronological order
- [ ] Label each screenshot clearly
- [ ] Create submission document with all requirements
- [ ] Double-check all screenshots are readable
- [ ] Submit to appropriate assignment folder

## Common Commands Reference

| Task | Command | Purpose |
|------|---------|---------|
| Change hostname | `sudo hostnamectl set-hostname <name>` | Sets system hostname |
| Check hostname | `hostnamectl` | Displays current hostname info |
| Find IP address | `ip a` | Shows network configuration |
| Edit hosts file | `sudo nano /etc/hosts` | Open hosts file for editing |
| View hosts file | `cat /etc/hosts` | Display hosts file content |
| Test connectivity | `ping -c 2 <hostname>` | Send 2 ping packets |

## Troubleshooting Quick Fixes

### Issue: Hostname not showing in terminal prompt
**Solution**: Close and reopen terminal window

### Issue: Permission denied when editing /etc/hosts
**Solution**: Make sure you're using `sudo nano /etc/hosts`

### Issue: Can't ping group members
**Solutions**:
- Verify their systems are powered on and connected
- Double-check /etc/hosts entries for typos
- Confirm IP addresses are correct

### Issue: IP address changes
**Solution**: DHCP may reassign IPs - coordinate with group if this happens

## Time Estimates
- **Individual work**: 30-45 minutes
- **Group coordination**: Throughout the week
- **Screenshot organization**: 15 minutes
- **Total time commitment**: 1-2 hours spread over the week

## Success Indicators
✅ New hostname appears in `hostnamectl` output  
✅ IP address identified and documented  
✅ /etc/hosts file successfully updated  
✅ All group members added to hosts file  
✅ Successful ping responses from group members  
✅ All required screenshots captured and labeled  
✅ Documentation complete and submitted  

## Next Steps After Completion
- [ ] Update assignment tracker status to "Completed"
- [ ] Mark due date as met
- [ ] Save submission confirmation
- [ ] Help group members if they need assistance

---

**💡 Pro Tips**:
- Take screenshots immediately after each successful command
- Keep your terminal window large enough for clear screenshots
- Save group member information in a text file for easy reference
- Test ping connectivity multiple times if first attempts fail

*This completion guide is designed to work with GitHub Copilot for enhanced academic workflow management.*