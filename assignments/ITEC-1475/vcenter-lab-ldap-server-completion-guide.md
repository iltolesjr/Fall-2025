# LDAP Server Lab Completion Guide - ITEC 1475

**Assignment**: vCenter Lab - LDAP Server  
**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Status**: 🔴 Not Started → 🟡 In Progress → 🟢 Completed  

## ⚠️ CRITICAL FIRST STEP

**Before you do ANYTHING else:**

✋ **STOP** - Don't touch your keyboard yet!

📖 **READ** the entire [vcenter-lab-ldap-server.md](vcenter-lab-ldap-server.md) file first

⏱️ **Time Required**: 20-25 minutes of reading

**Why?** See [why-read-instructions-first.md](why-read-instructions-first.md) for a detailed explanation.

**Quick reason**: Reading first will save you 2-3 hours of troubleshooting, prevent configuration errors, and help you understand the LDAP directory structure before making changes.

---

## Pre-Lab Reading Checklist

Before starting any actions, verify you've read and understand:

- [ ] All 14 parts of the lab
- [ ] All 15 questions you'll need to answer
- [ ] All screenshot requirements (15+ screenshots)
- [ ] Submission requirements at the end
- [ ] LDAP terminology (DN, Base DN, DIT, LDIF)
- [ ] The overall directory structure you'll create

---

## Quick Start Checklist

### Pre-Lab Preparation ⏱️ (~15 minutes)

- [ ] Read entire lab document (seriously, don't skip this!)
- [ ] Create a new document for answers and screenshots
- [ ] Verify you have vCenter access
- [ ] Check disk space: `df -h` (need ~500 MB free)
- [ ] Verify sudo access: `sudo -v`
- [ ] Create a folder for LDIF files: `mkdir ~/ldap-lab`
- [ ] Create a folder for screenshots: `mkdir ~/ldap-screenshots`
- [ ] Have a text editor ready (nano, vim, or gedit)
- [ ] Prepare to take organized notes

### Important Notes Before Starting

⚠️ **Critical Information:**
- You'll set an admin password during configuration - **REMEMBER IT**
- Choose a simple domain name (e.g., school.edu) for easier work
- Your Base DN will be based on your domain (dc=school,dc=edu)
- Every command will use your Base DN - write it down!
- Take screenshots as you go, not at the end

---

## Lab Steps Progress Tracker

### Part 1: Understanding LDAP ⏱️ (~10 minutes)

- [ ] Read through LDAP overview completely
- [ ] Understand Directory Information Tree (DIT) concept
- [ ] Learn Distinguished Name (DN) structure
- [ ] Understand Base DN concept
- [ ] **📝 Question 1**: Explain LDAP and its use
- [ ] **📝 Question 2**: What is DN and its purpose

**Key Concept**: LDAP is like a phone book for your network - organized hierarchically.

---

### Part 2: Install OpenLDAP Server ⏱️ (~10 minutes)

- [ ] Run: `sudo apt update`
- [ ] **📸 Screenshot**: apt update results
- [ ] Run: `sudo apt install -y slapd ldap-utils`
- [ ] **📸 Screenshot**: Successful installation
- [ ] **📝 Question 3**: Difference between slapd and ldap-utils

**Common issue**: If installation hangs, check network connectivity.

**Time check**: Installation should take 2-5 minutes depending on network speed.

---

### Part 3: Configure OpenLDAP Server ⏱️ (~15 minutes)

- [ ] Run: `sudo dpkg-reconfigure slapd`
- [ ] Answer prompts carefully:
  - [ ] Omit configuration? **NO**
  - [ ] DNS domain: (e.g., school.edu)
  - [ ] Organization name: (e.g., School)
  - [ ] Admin password: (choose and REMEMBER!)
  - [ ] Confirm password
  - [ ] Backend: MDB (default)
  - [ ] Remove on purge? **NO**
  - [ ] Move old database? **YES**
- [ ] **📸 Screenshot**: dpkg-reconfigure process
- [ ] **📝 Question 4**: Your domain and Base DN
- [ ] **Write down your Base DN** - you'll use it constantly!
- [ ] Run: `sudo systemctl status slapd`
- [ ] **📸 Screenshot**: slapd status (should be active)
- [ ] Run: `sudo ss -tlnp | grep 389` or `sudo netstat -tlnp | grep 389`
- [ ] **📸 Screenshot**: LDAP listening on port 389
- [ ] **📝 Question 5**: LDAP ports (389 and 636)

**Critical**: Write your Base DN on a sticky note! Example: `dc=school,dc=edu`

**Common issue**: If slapd isn't running, try `sudo systemctl restart slapd`

---

### Part 4: Basic LDAP Queries ⏱️ (~10 minutes)

- [ ] Run: `ldapsearch -x -b "" -s base namingContexts`
- [ ] **📸 Screenshot**: namingContexts output
- [ ] Run: `ldapsearch -x -b "dc=school,dc=edu" -LLL` (use YOUR Base DN!)
- [ ] **📸 Screenshot**: Directory structure
- [ ] **📝 Question 6**: Explain ldapsearch options (-x, -b, -LLL)

**Tip**: If you get "No such object" error, check your Base DN matches what you configured.

---

### Part 5: Add Users to LDAP ⏱️ (~20 minutes)

- [ ] Read about LDIF format
- [ ] Create file: `nano ~/ldap-lab/testuser.ldif`
- [ ] Add LDIF content (use YOUR Base DN!)
- [ ] Run: `slappasswd` to generate password hash
- [ ] **📸 Screenshot**: slappasswd output (can blur some of hash)
- [ ] Copy hash into testuser.ldif
- [ ] Save and close file
- [ ] Run: `ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f ~/ldap-lab/testuser.ldif`
- [ ] Enter admin password when prompted
- [ ] **📸 Screenshot**: Successful user addition
- [ ] **📝 Question 7**: Explain objectClass entries
- [ ] Run: `ldapsearch -x -b "dc=school,dc=edu" -LLL uid=testuser`
- [ ] **📸 Screenshot**: testuser entry details

**Common issues**:
- "Invalid credentials" = wrong admin password
- "Invalid syntax" = typo in LDIF file (check colons and spaces)
- "Already exists" = user already added (skip or use different uid)

**Pro tip**: Keep the LDIF template open to copy/paste for new users.

---

### Part 6: Add an Organizational Unit ⏱️ (~10 minutes)

- [ ] Create file: `nano ~/ldap-lab/users_ou.ldif`
- [ ] Add OU LDIF content
- [ ] Run: `ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f ~/ldap-lab/users_ou.ldif`
- [ ] **📸 Screenshot**: Successful OU creation
- [ ] **📝 Question 8**: Benefits of Organizational Units

**Key concept**: OUs are like folders - they help organize your directory.

---

### Part 7: Add User to OU ⏱️ (~15 minutes)

- [ ] Create file: `nano ~/ldap-lab/user_in_ou.ldif`
- [ ] Use YOUR StarID as the uid
- [ ] Use YOUR full name in cn field
- [ ] Generate new password hash with `slappasswd`
- [ ] Add hash to LDIF file
- [ ] Change uidNumber to 10001 (different from testuser)
- [ ] Run: `ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f ~/ldap-lab/user_in_ou.ldif`
- [ ] **📸 Screenshot**: New user added to OU

**Note**: The DN includes `ou=users` - this places the user inside the OU!

---

### Part 8: Test LDAP Authentication ⏱️ (~10 minutes)

- [ ] Run: `ldapwhoami -x -D "uid=testuser,dc=school,dc=edu" -W`
- [ ] Enter testuser's password
- [ ] **📸 Screenshot**: Successful authentication
- [ ] **📝 Question 9**: Try wrong password, describe error
- [ ] Try with wrong password intentionally
- [ ] Document the error message

**This proves**: LDAP can authenticate users - the foundation of directory services!

---

### Part 9: Modify LDAP Entries ⏱️ (~15 minutes)

- [ ] Create file: `nano ~/ldap-lab/modify_user.ldif`
- [ ] Add modification LDIF content
- [ ] Run: `ldapmodify -x -D "cn=admin,dc=school,dc=edu" -W -f ~/ldap-lab/modify_user.ldif`
- [ ] **📸 Screenshot**: Successful modification
- [ ] Run: `ldapsearch -x -b "dc=school,dc=edu" -LLL uid=testuser loginShell`
- [ ] **📸 Screenshot**: Updated loginShell value
- [ ] **📝 Question 10**: Difference between ldapadd, ldapmodify, ldapdelete

**Key difference**: ldapmodify changes existing entries, ldapadd creates new ones.

---

### Part 10: Create a Group ⏱️ (~15 minutes)

- [ ] Create file: `nano ~/ldap-lab/students_group.ldif`
- [ ] Add group LDIF content
- [ ] Include both testuser and your StarID as memberUid
- [ ] Run: `ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f ~/ldap-lab/students_group.ldif`
- [ ] **📸 Screenshot**: Successful group creation
- [ ] Run: `ldapsearch -x -b "dc=school,dc=edu" -LLL cn=students`
- [ ] **📸 Screenshot**: Students group details
- [ ] **📝 Question 11**: LDAP groups vs Linux system groups

**Groups** allow you to manage permissions for multiple users at once.

---

### Part 11: Backup and Restore ⏱️ (~10 minutes)

- [ ] Run: `sudo slapcat > ~/ldap-backup.ldif`
- [ ] Run: `cat ~/ldap-backup.ldif | head -50` to view
- [ ] **📸 Screenshot**: Backup command and first lines
- [ ] **📝 Question 12**: Why backup LDAP? When to restore?

**Critical**: In production, backup LDAP daily! It contains all user accounts.

---

### Part 12: Advanced Queries ⏱️ (~15 minutes)

- [ ] Run: `ldapsearch -x -b "dc=school,dc=edu" -LLL "(uidNumber=*)"`
- [ ] **📸 Screenshot**: Filtered search results
- [ ] Run: `ldapsearch -x -b "dc=school,dc=edu" -LLL "(&(uidNumber>=10000)(uidNumber<=10100))"`
- [ ] **📸 Screenshot**: Range query results
- [ ] **📝 Question 13**: Explain LDAP filter syntax (&, |, !)

**LDAP filters** are powerful - like SQL WHERE clauses for directories.

---

### Part 13: Security Considerations ⏱️ (~10 minutes)

- [ ] Run: `sudo systemctl status slapd`
- [ ] Run: `sudo systemctl is-enabled slapd`
- [ ] **📸 Screenshot**: Service status and enabled state
- [ ] **📝 Question 14**: Three security best practices for LDAP

**Security tip**: In production, always use LDAPS (TLS/SSL) and strong passwords!

---

### Part 14: Troubleshooting ⏱️ (~10 minutes)

- [ ] Run: `sudo journalctl -u slapd -n 50`
- [ ] **📸 Screenshot**: Recent LDAP log entries
- [ ] **📝 Question 15**: Troubleshooting steps for port 389 issues

**Logs** are your friend - they show connection attempts, errors, and changes.

---

## Final Submission Checklist ✅

### Document Completeness
- [ ] All 15 questions answered with complete explanations
- [ ] All 15+ screenshots included and clearly labeled
- [ ] Your Base DN documented at the beginning
- [ ] List of all users created with their DNs
- [ ] List of all LDIF files created
- [ ] Any troubleshooting performed documented

### Technical Requirements Met
- [ ] OpenLDAP server installed and running
- [ ] At least 2 users created (testuser + your StarID)
- [ ] Organizational Unit (ou=users) created
- [ ] POSIX group (students) created
- [ ] User authentication tested successfully
- [ ] Entry modification performed
- [ ] Backup created
- [ ] Advanced queries executed

### Quality Checks
- [ ] Screenshots are clear and readable
- [ ] Terminal output shows commands and results
- [ ] Answers demonstrate understanding (not just copied)
- [ ] Document is well-organized with headers
- [ ] Grammar and spelling checked
- [ ] Professional formatting maintained

### File Preparation
- [ ] Document saved as PDF or Word format
- [ ] Filename: `[YourStarID]-LDAP-Lab.pdf` or `.docx`
- [ ] File size reasonable (compress screenshots if >10MB)
- [ ] Test that file opens correctly

### Before Submitting
- [ ] Review entire document one more time
- [ ] Verify all screenshots are included
- [ ] Check that Base DN is consistent throughout
- [ ] Ensure admin credentials NOT included (security!)
- [ ] Add your name, StarID, and date at the top

---

## Time Estimation Summary

| Section | Estimated Time |
|---------|---------------|
| Pre-reading | 25 minutes |
| Parts 1-3 (Setup & Config) | 35 minutes |
| Parts 4-7 (Basic Operations) | 55 minutes |
| Parts 8-11 (Advanced Features) | 50 minutes |
| Parts 12-14 (Queries & Troubleshooting) | 35 minutes |
| Documentation & Screenshots | 30 minutes |
| **Total Estimated Time** | **3.5-4 hours** |

**Note**: Times vary based on experience level and reading speed.

---

## Troubleshooting Common Issues

### "Can't contact LDAP server"
- Check if slapd is running: `sudo systemctl status slapd`
- Restart service: `sudo systemctl restart slapd`
- Verify port 389: `sudo ss -tlnp | grep 389`

### "Invalid credentials"
- Double-check your admin password
- Verify the admin DN matches your Base DN
- Try reconfiguring: `sudo dpkg-reconfigure slapd`

### "No such object"
- Verify your Base DN is correct
- Check if you're using dc=school,dc=edu vs your actual domain
- Search for namingContexts to see actual Base DN

### "Already exists"
- Entry already in directory
- Use ldapsearch to verify: `ldapsearch -x -b "dc=school,dc=edu" -LLL`
- Delete and recreate, or use different uid

### "Invalid syntax" in LDIF
- Check for missing colons (:)
- Ensure proper spacing after colons
- No extra blank lines within an entry
- Base64 encode if using special characters

### Permission Denied
- Use sudo for slapcat command
- Verify you have write permissions in directory
- Check LDIF file permissions

---

## Pro Tips for Success

💡 **Tip 1**: Create a "cheat sheet" with your Base DN and common commands  
💡 **Tip 2**: Test each LDIF file immediately after creating it  
💡 **Tip 3**: Take screenshots AS you complete each section  
💡 **Tip 4**: Keep all LDIF files organized in one directory  
💡 **Tip 5**: Use descriptive filenames for screenshots (01-install.png, 02-config.png)  
💡 **Tip 6**: If stuck, check `sudo journalctl -u slapd -n 100` for clues  
💡 **Tip 7**: Copy/paste Base DN to avoid typos  
💡 **Tip 8**: Write down admin password in your notes (securely!)  

---

## Additional Resources

- [OpenLDAP Quick Start Guide](https://www.openldap.org/doc/admin24/quickstart.html)
- [LDAP Filter Syntax](https://ldap.com/ldap-filters/)
- [Understanding LDIF Format](https://ldap.com/ldif-the-ldap-data-interchange-format/)
- [LDAP for Rocket Scientists](https://www.zytrax.com/books/ldap/)

---

## Post-Lab Learning

After completing this lab, you should understand:

✅ How LDAP directories are structured hierarchically  
✅ The relationship between DNs, Base DN, and directory entries  
✅ How to create, modify, and query LDAP entries  
✅ The role of object classes and attributes  
✅ How LDAP authentication works  
✅ Basic LDAP administration and troubleshooting  

**Next steps**: Explore LDAP client configuration, LDAPS (TLS/SSL), and integration with other services like SSH or email.

---

## Optional Challenge Tasks

If you finish early or want to explore further:

1. **Configure LDAPS**: Enable SSL/TLS for encrypted connections
2. **Install phpLDAPadmin**: Web-based LDAP management tool
3. **Set up LDAP client**: Configure another VM to authenticate against your LDAP server
4. **Create bulk import script**: Write a bash script to add multiple users
5. **Configure password policies**: Set expiration, complexity requirements
6. **Enable logging**: Configure detailed logging for auditing

Document any optional work for potential extra credit!

---

**Remember**: LDAP is a foundational technology. Take your time to understand the concepts, not just complete the steps. The knowledge you gain here applies to Active Directory, Azure AD, and many enterprise systems.

**Need Help?** 
- Ask your instructor during lab time
- Check the troubleshooting section above
- Review the OpenLDAP documentation
- Discuss concepts (not answers) with classmates

Good luck! 🚀

---

*This completion guide is designed to help you successfully complete the LDAP Server lab with understanding and confidence.*
