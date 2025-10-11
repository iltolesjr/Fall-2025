# Software Managers Lab Completion Guide - ITEC 1475

**Assignment**: vCenter Lab - Other Software Managers  
**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Status**: 🔴 Not Started → 🟡 In Progress → 🟢 Completed  

## ⚠️ CRITICAL FIRST STEP

**Before you do ANYTHING else:**

✋ **STOP** - Don't touch your keyboard yet!

📖 **READ** the entire [vcenter-lab-software-managers.md](vcenter-lab-software-managers.md) file first

⏱️ **Time Required**: 15-20 minutes of reading

**Why?** See [why-read-instructions-first.md](why-read-instructions-first.md) for a detailed explanation.

**Quick reason**: Reading first will save you 1-2 hours of troubleshooting and prevent having to redo work.

---

## Pre-Lab Reading Checklist

Before starting any actions, verify you've read and understand:

- [ ] All 9 parts of the lab
- [ ] All 15 questions you'll need to answer
- [ ] All screenshot requirements
- [ ] Submission requirements at the end
- [ ] System requirements (disk space, permissions, etc.)

---

## Quick Start Checklist

### Pre-Lab Preparation ⏱️ (~10 minutes)

- [ ] Read entire lab document (don't skip this!)
- [ ] Create a new document for answers and screenshots
- [ ] Verify you have vCenter access (if required)
- [ ] Check disk space: `df -h` (need ~5-10 GB free)
- [ ] Verify sudo access: `sudo -v`
- [ ] Create a folder for screenshots: `mkdir ~/software-managers-lab`
- [ ] Have a text editor ready for notes

---

## Lab Steps Progress Tracker

### Part 1: Traditional Package Managers ⏱️ (~15 minutes)

- [ ] Read through APT section completely
- [ ] Run `sudo apt update` command
- [ ] **📸 Screenshot**: apt update results
- [ ] **📝 Question 1**: Search command for web servers
- [ ] Read through YUM/DNF section
- [ ] **📝 Question 2**: APT vs YUM/DNF differences
- [ ] Document commands in your notes

**Time check**: If you spent more than 15 minutes here, you might be overthinking. Move on!

---

### Part 2: Snap Package Manager ⏱️ (~20 minutes)

- [ ] Check if snap is installed: `snap --version`
- [ ] Install snap if needed: `sudo apt install snapd`
- [ ] **📸 Screenshot**: snap --version output
- [ ] Install hello-world snap: `sudo snap install hello-world`
- [ ] Run hello-world: `hello-world`
- [ ] **📸 Screenshot**: hello-world installation and execution
- [ ] **📝 Question 3**: Two advantages of Snap packages
- [ ] List installed snaps: `snap list`

**Common issue**: If snap commands fail, you may need to restart your terminal or session.

---

### Part 3: Flatpak Package Manager ⏱️ (~20 minutes)

- [ ] Install Flatpak: `sudo apt install flatpak`
- [ ] Add Flathub repository (copy full command from lab)
- [ ] **📸 Screenshot**: Flatpak installation success
- [ ] Search for text editor: `flatpak search text editor`
- [ ] **📸 Screenshot**: Search results
- [ ] **📝 Question 4**: Flatpak vs Snap sandboxing differences
- [ ] Review Flatpak commands for reference

**Important**: Don't install large applications unless you have plenty of disk space!

---

### Part 4: AppImage ⏱️ (~15 minutes)

- [ ] Read and understand AppImage concept
- [ ] **📝 Question 5**: What makes AppImage different
- [ ] **📝 Question 6**: When AppImage is more useful
- [ ] If instructor provided example AppImage:
  - [ ] Download it
  - [ ] Make executable: `chmod +x filename.AppImage`
  - [ ] Test run: `./filename.AppImage`
  - [ ] **📸 Screenshot**: If you ran an AppImage

**Note**: This section is more conceptual if no AppImage is provided.

---

### Part 5: Docker Containers ⏱️ (~30 minutes)

**⚠️ WARNING**: This is the longest section. Budget your time!

- [ ] Install Docker prerequisites (follow exact commands from lab)
- [ ] Add Docker GPG key
- [ ] Add Docker repository
- [ ] Install Docker: `sudo apt install docker-ce docker-ce-cli containerd.io`
- [ ] Verify: `sudo docker --version`
- [ ] **📸 Screenshot**: docker --version output
- [ ] Run hello-world container: `sudo docker run hello-world`
- [ ] **📸 Screenshot**: hello-world container output
- [ ] **📝 Question 7**: Container vs VM differences
- [ ] **📝 Question 8**: Why use containers
- [ ] Review basic Docker commands

**Common issues:**
- If installation fails, check you followed ALL prerequisite steps
- If "permission denied", make sure you're using `sudo`
- Docker may take several minutes to download and install

---

### Part 6: Tarball Archives ⏱️ (~15 minutes)

- [ ] Create test tarball (follow lab commands)
- [ ] Extract test tarball
- [ ] List tarball contents
- [ ] **📸 Screenshot**: Tarball creation and extraction
- [ ] **📝 Question 9**: What files to look for after extracting
- [ ] Practice extraction commands for different formats
- [ ] Clean up test files: `rm -rf test-app test-app.tar.gz`

**Tip**: Understanding tar is crucial for Linux administration!

---

### Part 7: Source Code and Binary Installation ⏱️ (~20 minutes)

- [ ] Install build-essential: `sudo apt install build-essential`
- [ ] **📸 Screenshot**: build-essential installation
- [ ] **📝 Question 10**: Command for compiler/build tools
- [ ] **📝 Question 11**: Binary vs source preference
- [ ] Review typical build process (./configure, make, make install)
- [ ] Review binary installation steps

**Note**: You're NOT compiling anything from source yet - just learning the process.

---

### Part 8: Package Manager Comparison ⏱️ (~30 minutes)

- [ ] Create comparison table with all methods
- [ ] **📝 Question 12**: Complete comparison table including:
  - [ ] APT/YUM
  - [ ] Snap
  - [ ] Flatpak
  - [ ] AppImage
  - [ ] Docker
  - [ ] Tarball
  - [ ] Source Code
- [ ] Consider all factors: ease of use, dependencies, integration, portability, security, disk space

**Tip**: Use this format:

| Method | Advantages | Disadvantages | Best Use Case |
|--------|-----------|---------------|---------------|
| APT/YUM | ... | ... | ... |
| Snap | ... | ... | ... |
| etc. | ... | ... | ... |

---

### Part 9: Reflection Questions ⏱️ (~20 minutes)

- [ ] **📝 Question 13**: Recommendations for different user types
  - [ ] System administrator use case
  - [ ] Developer use case  
  - [ ] End user use case
- [ ] **📝 Question 14**: Security considerations
- [ ] **📝 Question 15**: Why "read first" matters (with three examples)

**Important**: Question 15 is testing whether you actually read first! Your answer should reference specific examples from THIS lab.

---

## Submission Preparation ⏱️ (~20-30 minutes)

### Document Organization

- [ ] Copy-paste each question before your answer
- [ ] Number all questions (1-15)
- [ ] Insert screenshots in appropriate locations
- [ ] Label each screenshot clearly:
  - "Screenshot 1: apt update results"
  - "Screenshot 2: snap version check"
  - etc.

### Quality Check

- [ ] All 15 questions answered completely
- [ ] All required screenshots included (count them!)
- [ ] Screenshots are clear and readable
- [ ] Answers demonstrate understanding (not just copied from internet)
- [ ] Comparison table is complete and thoughtful
- [ ] Reflection answers are specific to THIS lab
- [ ] Document is well-formatted and professional

### Final Verification

- [ ] Proofread all answers
- [ ] Check screenshot quality
- [ ] Verify nothing is missing from submission checklist
- [ ] Save document with proper filename
- [ ] Submit to correct assignment folder

---

## Time Management Guide

**Recommended Schedule** (Total: 3-4 hours)

| Phase | Time | Activity |
|-------|------|----------|
| Reading | 15-20 min | Read entire lab without touching keyboard |
| Setup | 10 min | Verify access, check resources, prepare document |
| Parts 1-2 | 45 min | Traditional managers and Snap |
| **BREAK** | 10 min | Step away, stretch, hydrate |
| Parts 3-4 | 45 min | Flatpak and AppImage |
| Part 5 | 30 min | Docker (longest section) |
| **BREAK** | 10 min | Step away again |
| Parts 6-7 | 45 min | Tarballs and source/binary |
| Parts 8-9 | 50 min | Comparison and reflection |
| Submission | 30 min | Final checks and submit |

**Total**: 3 hours 35 minutes + breaks

---

## Common Pitfalls to Avoid

### ❌ Don't Do This:

1. **Skipping the read-through** - This will cost you time later
2. **Installing everything** - Some are just for learning, not installing
3. **Forgetting screenshots** - You can't recreate some outputs
4. **Rushing reflection questions** - These show your understanding
5. **Copying answers from internet** - Instructors can tell
6. **Working on low disk space** - Check space before installing
7. **Not testing commands** - Verify each step works before proceeding

### ✅ Do This Instead:

1. **Read completely first** - Save hours of frustration
2. **Follow instructions exactly** - They're written carefully
3. **Screenshot as you go** - Don't leave it until the end
4. **Answer questions immediately** - Context is fresh
5. **Think critically** - Reflection questions want YOUR thoughts
6. **Check disk space early** - Better to know upfront
7. **Test each step** - Verify before moving forward

---

## Troubleshooting Guide

### Issue: Out of Disk Space

**Symptoms**: Installation fails with "no space left on device"

**Solutions**:
1. Check space: `df -h`
2. Clean apt cache: `sudo apt clean`
3. Remove unused packages: `sudo apt autoremove`
4. Use vCenter cluster instead (unlimited space)

### Issue: Permission Denied

**Symptoms**: Commands fail with "permission denied"

**Solutions**:
1. Use `sudo` for system operations
2. Check you're in correct directory for file operations
3. For Docker: may need to add user to docker group

### Issue: Package Not Found

**Symptoms**: "Unable to locate package" or similar

**Solutions**:
1. Run `sudo apt update` first
2. Check package name spelling
3. Verify repository is added (for Flatpak)
4. Check internet connection

### Issue: Docker Won't Start

**Symptoms**: Docker commands hang or fail

**Solutions**:
1. Check if Docker service is running: `sudo systemctl status docker`
2. Start Docker service: `sudo systemctl start docker`
3. Check logs: `sudo journalctl -u docker`

---

## Success Indicators

You're on track if:

- ✅ You read the entire lab before starting actions
- ✅ All commands execute without major errors
- ✅ You have all required screenshots
- ✅ You understand WHY each package manager exists
- ✅ Your comparison table shows real understanding
- ✅ Your reflection answers reference specific lab examples
- ✅ You can explain when to use each installation method

---

## What You Should Learn

By completing this lab, you should be able to:

1. **Explain** differences between package managers
2. **Choose** appropriate installation method for different scenarios
3. **Install** software using multiple methods
4. **Troubleshoot** common installation issues
5. **Understand** security implications of different sources
6. **Appreciate** why reading instructions first matters
7. **Apply** these skills in real-world IT scenarios

---

## Next Steps After Completion

- [ ] Update your assignment tracker to "Completed"
- [ ] Save your document for future reference
- [ ] Review comparison table before exams
- [ ] Practice using different package managers
- [ ] Help classmates who are struggling
- [ ] Reflect on how reading first helped (or how not reading first hurt)

---

## Pro Tips

💡 **Tip 1**: Create your comparison table FIRST (after reading), then fill it in as you work through each section.

💡 **Tip 2**: Take screenshots immediately after successful commands - don't wait!

💡 **Tip 3**: Keep a terminal log of all commands you run for debugging and reference.

💡 **Tip 4**: The reflection questions (especially Q15) directly test if you read first. Your answer quality will show it.

💡 **Tip 5**: If you're struggling, re-read the relevant section. The answer is usually in the text.

💡 **Tip 6**: Use the vCenter cluster if your personal system doesn't have enough resources.

---

## Grading Insights

Based on the lab grading criteria:

**Questions (60% of grade):**
- All 15 questions must be answered
- Answers should show understanding, not just facts
- Comparison table must be thorough and insightful

**Screenshots (25% of grade):**
- All required screenshots must be included
- Must be clearly labeled and readable
- Must show the correct output/command

**Reflection (15% of grade):**
- Question 15 is critical - shows you understood the "read first" instruction
- Should provide specific examples from THIS lab
- Should demonstrate critical thinking

**To get full points:** Complete everything thoroughly, think critically, and show your work.

---

*This completion guide is designed to help you work efficiently through the Software Managers lab while developing professional IT habits like reading documentation thoroughly before taking action.*
