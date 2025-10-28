# Week 2 Linux Lab - Study Schedule & Task Breakdown

## Time Allocation Guide

### Total Estimated Time: 2-3 hours (spread over week)

---

## Day-by-Day Breakdown

### **Day 1 (Monday/Tuesday): Lab Setup & Initial Tasks**
*Time: 45-60 minutes*

**Tasks:**
- [ ] Review lab instructions thoroughly (15 min)
- [ ] Connect to ITEC vCenter environment (10 min)
- [ ] Complete Tasks 1-3: Hostname change, IP discovery, initial hosts file update (20-30 min)
- [ ] Take screenshots 1-3 (5 min)

**Commands to Execute:**
```bash
sudo hostnamectl set-hostname [YourStarID]-mint
hostnamectl
ip a
sudo nano /etc/hosts
cat /etc/hosts
```

---

### **Day 2-3 (Mid-Week): Group Coordination**
*Time: 30-45 minutes*

**Tasks:**
- [ ] Post your StarID and IP in group discussion (5 min)
- [ ] Monitor group discussion for other member information (10 min)
- [ ] Begin documenting group member details (10 min)
- [ ] Start working on completion document (15-20 min)

**Focus Areas:**
- Group communication and coordination
- Documentation organization
- Preparation for connectivity testing

---

### **Day 4-5 (Thursday/Friday): Testing & Completion**
*Time: 45-60 minutes*

**Tasks:**
- [ ] Update /etc/hosts with all group member entries (15 min)
- [ ] Perform ping tests for all group members (15 min)
- [ ] Take final screenshots (10 min)
- [ ] Complete submission document (15-20 min)
- [ ] Final review and submission (5 min)

**Commands to Execute:**
```bash
sudo nano /etc/hosts  # Add group members
cat /etc/hosts        # Verify updates
ping -c 2 [member1-hostname]
ping -c 2 [member2-hostname]
ping -c 2 [member3-hostname]
ping -c 2 gf4321yk-mint
```

---

## Priority Matrix

### High Priority (Must Complete)
1. **Hostname Change** - Core lab requirement
2. **IP Address Discovery** - Essential for networking tasks
3. **Initial Hosts File Update** - System configuration
4. **Screenshot Documentation** - Submission requirement

### Medium Priority (Important)
1. **Group Coordination** - Collaborative learning
2. **Connectivity Testing** - Practical application
3. **Completion Document** - Professional submission

### Low Priority (Nice to Have)
1. **Additional troubleshooting** - Extended learning
2. **Command exploration** - Deeper understanding

---

## Study Tips

### Before Starting
- [ ] Read through entire lab document
- [ ] Ensure stable internet connection for vCenter access
- [ ] Have screenshot tool ready
- [ ] Prepare completion document template

### During Lab Work
- [ ] Take notes on any issues encountered
- [ ] Document exact commands used
- [ ] Save work frequently
- [ ] Test each step before moving forward

### After Completion
- [ ] Review all screenshots for clarity
- [ ] Verify completion checklist
- [ ] Proofread submission document
- [ ] Submit to correct assignment folder

---

## Time Management Strategies

### Pomodoro Technique Application
- **25 min work blocks** for focused lab tasks
- **5 min breaks** between major sections
- **Longer break** between days for processing

### Task Batching
- **Setup Phase**: All environment and connection tasks
- **Execution Phase**: All command-line work
- **Documentation Phase**: All screenshot and writing tasks
- **Submission Phase**: Final review and submission

---

## Integration with Other Coursework

### ITEC 1425 Network Concepts Review
- IP addressing fundamentals
- Network connectivity concepts
- ICMP protocol understanding

### Future Linux Topics Connection
- System administration basics
- File system navigation
- Command-line proficiency

---

## Buffer Time Recommendations

### Add Extra Time For:
- **First-time vCenter access** (+15 min)
- **Group coordination delays** (+20 min)
- **Screenshot retakes** (+10 min)
- **Documentation writing** (+15 min)

### Common Time Sinks:
- Waiting for group members to post information
- Troubleshooting network connectivity issues
- Formatting and organizing screenshots
- Proofreading and final document review

---

## Success Indicators

### Daily Checkpoints
- **Day 1**: Basic lab setup and initial tasks completed
- **Day 2-3**: Group information collected and documented
- **Day 4-5**: All testing completed and document submitted

### Quality Measures
- All screenshots are clear and properly labeled
- All required commands executed successfully
- Group collaboration completed appropriately
- Academic integrity maintained throughout

---

*This schedule can be adjusted based on your personal pace and course load. Use Copilot for help with any step: "Help me troubleshoot this Linux command" or "Create a submission checklist for my lab."*