# Group Member Information Template

Use this template to track your group members' information for the vCenter Lab assignment.

## My Information

**Name**: [Your Name]  
**StarID**: [Your StarID]  
**IP Address**: [Your IP Address]  
**Hostname**: [Your StarID]-mint  
**Status**: ✅ Posted  

---

## Group Members

### Member 1
**Name**: [Group Member Name]  
**StarID**: [Member StarID]  
**IP Address**: [Member IP Address]  
**Hostname**: [Member StarID]-mint  
**Status**: [ ] Posted / [ ] Collected  

### Member 2
**Name**: [Group Member Name]  
**StarID**: [Member StarID]  
**IP Address**: [Member IP Address]  
**Hostname**: [Member StarID]-mint  
**Status**: [ ] Posted / [ ] Collected  

### Member 3
**Name**: [Group Member Name]  
**StarID**: [Member StarID]  
**IP Address**: [Member IP Address]  
**Hostname**: [Member StarID]-mint  
**Status**: [ ] Posted / [ ] Collected  

---

## Lab Progress Tracking

### /etc/hosts File Updates
- [ ] Added my own hostname entry
- [ ] Added Member 1 entry
- [ ] Added Member 2 entry  
- [ ] Added Member 3 entry
- [ ] Verified all entries with `cat /etc/hosts`

### Connectivity Testing
- [ ] Pinged Member 1: `ping -c 2 [member1-hostname]`
- [ ] Pinged Member 2: `ping -c 2 [member2-hostname]`
- [ ] Pinged Member 3: `ping -c 2 [member3-hostname]`
- [ ] All ping tests successful

### Screenshots Captured
- [ ] hostnamectl output
- [ ] IP address output (`ip a`)
- [ ] Updated /etc/hosts file
- [ ] /etc/hosts with all group members
- [ ] Successful ping results for each member

---

## Quick Reference Commands

```bash
# Check your hostname
hostnamectl

# Find your IP address
ip a

# Edit hosts file
sudo nano /etc/hosts

# View hosts file
cat /etc/hosts

# Test connectivity (replace hostname)
ping -c 2 [group-member-hostname]
```

---

*Copy this template to your personal notes to track group collaboration progress.*