# Week 2 Linux Assignment - Quick Action Items

## 🎯 What You Need to Do RIGHT NOW

**Assignment**: vCenter Lab - Change Hostname (ITEC 1475)  
**Status**: Ready to begin  
**Time Needed**: 1-2 hours (spread over the week)  

### 📋 Essential Steps to Complete

1. **Start the Lab** (30 minutes individual work)
   - Follow the [Week 2 Linux Completion Guide](assignments/ITEC-1475/week2-linux-completion-guide.md)
   - Use the detailed [vCenter Lab Instructions](assignments/ITEC-1475/vcenter-lab-hostname.md)

2. **Key Tasks Overview**:
   - Change your system hostname to `[YourStarID]-mint`
   - Find your system's IP address
   - Update `/etc/hosts` file with your information
   - Take screenshots of each step

3. **Group Coordination** (throughout the week)
   - Share your StarID and IP address in [Systems Group #4 Discussion](discussions/ITEC-1475/systems-group-4.md)
   - Collect their information and add to your hosts file
   - Test connectivity by pinging their systems

4. **Submit Documentation**
   - Use the [Submission Template](assignments/ITEC-1475/submission-template.md)
   - Include all required screenshots
   - Submit organized documentation

### 🚀 Quick Start Commands

```bash
# 1. Change hostname (replace YourStarID with your actual StarID)
sudo hostnamectl set-hostname YourStarID-mint
hostnamectl

# 2. Find IP address
ip a

# 3. Edit hosts file
sudo nano /etc/hosts

# 4. Verify changes
cat /etc/hosts

# 5. Test connectivity (after group coordination)
ping -c 2 groupmember-mint
```

### 📁 File Organization

All files are organized in `/assignments/ITEC-1475/`:
- `vcenter-lab-hostname.md` - Complete lab instructions
- `week2-linux-completion-guide.md` - Step-by-step checklist
- `submission-template.md` - Documentation template

### ⚡ Status Update

The assignment tracker has been updated to show "In Progress" status. Complete the lab steps and update to "Completed" when finished.

### 💡 Success Tips

- Take screenshots immediately after each command
- Keep your system running so group members can ping you
- Follow the completion guide checklist to track progress
- Ask for help if you encounter any issues

---

**Next Step**: Open the [Week 2 Linux Completion Guide](assignments/ITEC-1475/week2-linux-completion-guide.md) and start with Step 1!