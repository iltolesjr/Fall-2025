# vCenter Lab Submission - LDAP Server

**Student**: [Your Full Name]  
**StarID**: [Your StarID]  
**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Date**: [Submission Date]  

---

## Lab Configuration Summary

**Domain Name**: [e.g., school.edu]  
**Base DN**: [e.g., dc=school,dc=edu]  
**Admin DN**: [e.g., cn=admin,dc=school,dc=edu]  

**Users Created**:
1. testuser (uid=testuser,dc=school,dc=edu)
2. [YourStarID] (uid=[YourStarID],ou=users,dc=school,dc=edu)

**Organizational Units**: ou=users,dc=school,dc=edu  
**Groups Created**: cn=students,ou=users,dc=school,dc=edu  

---

## Part 1: Understanding LDAP

### Question 1: Explain LDAP and Why Organizations Use It

**Answer**: 

[Your explanation here - should be 3-4 sentences in your own words explaining what LDAP is and why it's valuable for organizations]

---

### Question 2: What Does DN Stand For and What Is Its Purpose?

**Answer**: 

[Your explanation of Distinguished Name and how it uniquely identifies entries in the LDAP directory tree]

---

## Part 2: Install OpenLDAP Server

### Installation Screenshots

**Screenshot 1: apt update results**  
![apt update](screenshots/01-apt-update.png)

**Screenshot 2: slapd and ldap-utils installation**  
![Installation](screenshots/02-ldap-install.png)

---

### Question 3: Difference Between slapd and ldap-utils

**Answer**: 

[Explain what slapd provides (the server daemon) versus what ldap-utils provides (command-line client tools)]

---

## Part 3: Configure OpenLDAP Server

### Configuration Screenshots

**Screenshot 3: dpkg-reconfigure slapd process**  
![Configuration](screenshots/03-reconfigure-slapd.png)

**Screenshot 4: slapd service status**  
![Service Status](screenshots/04-slapd-status.png)

**Screenshot 5: LDAP listening on port 389**  
![Port 389](screenshots/05-port-389.png)

---

### Question 4: Your Domain and Base DN

**Domain Name**: [Your domain]  
**Resulting Base DN**: [Your Base DN]

---

### Question 5: LDAP Ports

**Answer**: 

[Explain which port LDAP uses for non-encrypted connections and which port is used for LDAPS (LDAP over SSL)]

---

## Part 4: Basic LDAP Queries

### Query Screenshots

**Screenshot 6: namingContexts output**  
![Naming Contexts](screenshots/06-naming-contexts.png)

**Screenshot 7: Directory structure search**  
![Directory Structure](screenshots/07-directory-tree.png)

---

### Question 6: Explain ldapsearch Options

**Answer**: 

[Explain what the -x, -b, and -LLL options do in the ldapsearch command]

---

## Part 5: Add Users to LDAP

### User Creation Screenshots

**Screenshot 8: slappasswd password hash generation**  
![Password Hash](screenshots/08-slappasswd.png)

**Screenshot 9: Successful testuser addition**  
![Add testuser](screenshots/09-add-testuser.png)

**Screenshot 10: testuser entry verification**  
![Verify testuser](screenshots/10-verify-testuser.png)

---

### Question 7: Explain objectClass Entries

**Answer**: 

[Explain what inetOrgPerson, posixAccount, and shadowAccount represent, and why multiple object classes are needed]

---

## Part 6: Add Organizational Unit

### Organizational Unit Screenshots

**Screenshot 11: Successful OU creation**  
![Create OU](screenshots/11-create-ou.png)

---

### Question 8: Benefits of Organizational Units

**Answer**: 

[Explain why organizing LDAP entries into Organizational Units is beneficial]

---

## Part 7: Add User to OU

### User in OU Screenshot

**Screenshot 12: New user added to OU**  
![User in OU](screenshots/12-user-in-ou.png)

**User Details**:
- **UID**: [Your StarID]
- **Full DN**: uid=[YourStarID],ou=users,dc=school,dc=edu
- **CN (Full Name)**: [Your Full Name]
- **UID Number**: 10001

---

## Part 8: Test LDAP Authentication

### Authentication Screenshots

**Screenshot 13: Successful ldapwhoami authentication**  
![Authentication Success](screenshots/13-ldapwhoami.png)

---

### Question 9: Wrong Password Error

**Answer**: 

[Describe what happens when you enter the wrong password - include the specific error message you received]

---

## Part 9: Modify LDAP Entries

### Modification Screenshots

**Screenshot 14: Successful entry modification**  
![Modify Entry](screenshots/14-ldapmodify.png)

**Screenshot 15: Updated loginShell verification**  
![Verify Modification](screenshots/15-verify-modification.png)

---

### Question 10: LDAP Command Differences

**Answer**: 

[Explain the difference between ldapadd, ldapmodify, and ldapdelete commands and when each is used]

---

## Part 10: Create a Group

### Group Creation Screenshots

**Screenshot 16: Successful students group creation**  
![Create Group](screenshots/16-create-group.png)

**Screenshot 17: Students group details**  
![Group Details](screenshots/17-group-details.png)

**Group Information**:
- **Group Name**: students
- **Group DN**: cn=students,ou=users,dc=school,dc=edu
- **GID Number**: 10000
- **Members**: testuser, [YourStarID]

---

### Question 11: LDAP Groups vs Linux System Groups

**Answer**: 

[Explain how LDAP groups differ from Linux system groups]

---

## Part 11: Backup and Restore

### Backup Screenshots

**Screenshot 18: LDAP database backup**  
![Backup Database](screenshots/18-backup-ldap.png)

---

### Question 12: Importance of LDAP Backups

**Answer**: 

[Explain why regular LDAP backups are important and what situations would require a restore]

---

## Part 12: Advanced Queries

### Advanced Query Screenshots

**Screenshot 19: Filtered search for all users**  
![Filtered Search](screenshots/19-filtered-search.png)

**Screenshot 20: Range query results**  
![Range Query](screenshots/20-range-query.png)

---

### Question 13: LDAP Filter Syntax

**Answer**: 

[Explain LDAP filter syntax and what the &, |, and ! operators mean]

- **&** (AND): [Your explanation]
- **|** (OR): [Your explanation]
- **!** (NOT): [Your explanation]

---

## Part 13: Security Considerations

### Security Screenshots

**Screenshot 21: Service status and enabled state**  
![Service Management](screenshots/21-service-status.png)

---

### Question 14: LDAP Security Best Practices

**Answer**: 

Three security best practices for running an LDAP server in production:

1. [First security best practice]
2. [Second security best practice]
3. [Third security best practice]

---

## Part 14: Troubleshooting

### Troubleshooting Screenshots

**Screenshot 22: Recent LDAP log entries**  
![LDAP Logs](screenshots/22-ldap-logs.png)

---

### Question 15: Troubleshooting Connection Issues

**Answer**: 

[List the troubleshooting steps you would take if you couldn't connect to LDAP on port 389]

1. [First troubleshooting step]
2. [Second troubleshooting step]
3. [Third troubleshooting step]
4. [Additional steps as needed]

---

## Lab Completion Summary

### Requirements Met ✅

- [x] OpenLDAP server (slapd) installed successfully
- [x] LDAP server configured with domain and Base DN
- [x] Created testuser entry
- [x] Created user entry with my StarID in ou=users
- [x] Created ou=users organizational unit
- [x] Created students POSIX group
- [x] Successfully tested LDAP authentication
- [x] Modified LDAP entry (changed loginShell)
- [x] Performed basic and advanced LDAP queries
- [x] Created backup of LDAP database
- [x] All 15 questions answered completely
- [x] All 22+ screenshots captured and labeled
- [x] Service verified as running and enabled

### Technical Skills Demonstrated

- ✅ Linux package management (apt)
- ✅ Service configuration and management (systemctl)
- ✅ LDAP directory structure design
- ✅ LDIF file creation and syntax
- ✅ LDAP query operations (ldapsearch)
- ✅ LDAP data manipulation (ldapadd, ldapmodify)
- ✅ Password hash generation (slappasswd)
- ✅ Authentication testing (ldapwhoami)
- ✅ Database backup procedures (slapcat)
- ✅ Log analysis and troubleshooting (journalctl)
- ✅ Network service verification (ss/netstat)
- ✅ LDAP filter syntax and advanced queries

### LDAP Concepts Understood

- **LDAP Purpose**: Centralized directory service for authentication and information storage
- **Directory Information Tree (DIT)**: Hierarchical organization of LDAP entries
- **Distinguished Names (DNs)**: Unique identifiers for entries in the directory
- **Base DN**: Root of the LDAP directory tree
- **Object Classes**: Define entry types and available attributes
- **LDIF Format**: Standard format for representing LDAP data
- **Organizational Units**: Containers for organizing related entries
- **POSIX Groups**: Groups that can be used for Unix/Linux system permissions

### Troubleshooting Performed

[Document any issues you encountered and how you resolved them]

**Issue 1**: [If any]  
**Resolution**: [How you fixed it]

**Issue 2**: [If any]  
**Resolution**: [How you fixed it]

---

## Directory Structure Created

```
dc=school,dc=edu (Base DN)
├── cn=admin (Administrator)
├── uid=testuser (Test User)
└── ou=users (Organizational Unit)
    ├── uid=[YourStarID] (Your User Account)
    └── cn=students (POSIX Group)
        ├── memberUid: testuser
        └── memberUid: [YourStarID]
```

---

## LDIF Files Created

1. **testuser.ldif** - Created initial test user at base level
2. **users_ou.ldif** - Created organizational unit for users
3. **user_in_ou.ldif** - Created user account within OU
4. **modify_user.ldif** - Modified testuser's loginShell
5. **students_group.ldif** - Created POSIX group for students

---

## Key Commands Reference

### User Management
```bash
# Add user
ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f user.ldif

# Search for user
ldapsearch -x -b "dc=school,dc=edu" -LLL uid=username

# Modify user
ldapmodify -x -D "cn=admin,dc=school,dc=edu" -W -f modify.ldif

# Test authentication
ldapwhoami -x -D "uid=username,dc=school,dc=edu" -W
```

### Service Management
```bash
# Check status
sudo systemctl status slapd

# Restart service
sudo systemctl restart slapd

# View logs
sudo journalctl -u slapd -n 50
```

### Backup
```bash
# Backup entire directory
sudo slapcat > backup.ldif
```

---

## Time Investment

**Total Time Spent**: [X hours]

**Breakdown**:
- Reading lab instructions: [X minutes]
- Installation and configuration: [X minutes]
- Creating users and OUs: [X minutes]
- Testing and queries: [X minutes]
- Documentation and screenshots: [X minutes]
- Troubleshooting: [X minutes]

---

## Reflection and Learning

### What I Learned

[Write 2-3 sentences about the most important concepts you learned from this lab]

### Challenges Faced

[Describe any significant challenges and how you overcame them]

### Real-World Applications

[Explain how you might use LDAP in a real-world IT environment]

---

## Optional Challenge Work (Extra Credit)

[If you completed any optional challenge tasks, document them here with screenshots and descriptions]

- [ ] Configured LDAPS (TLS/SSL)
- [ ] Installed phpLDAPadmin or LAM
- [ ] Set up LDAP client authentication on another VM
- [ ] Created bulk import script
- [ ] Configured password policies
- [ ] Other: [Describe]

---

## Additional Notes

[Any additional comments, observations, or notes about the lab]

---

## Submission Checklist ✅

- [x] All 15 questions answered with complete explanations
- [x] All 22+ required screenshots included and clearly labeled
- [x] Screenshots are clear and readable
- [x] Base DN and domain documented
- [x] All LDAP entries created and verified
- [x] Directory structure diagram included
- [x] LDIF files documented
- [x] Time investment recorded
- [x] Reflection section completed
- [x] Document formatted professionally
- [x] Filename follows convention: [StarID]-LDAP-Lab.pdf or .docx
- [x] File opens correctly without errors
- [x] No sensitive passwords or credentials visible in screenshots

---

**Date Completed**: [Completion Date]  
**Submission Date**: [When submitted to Canvas]  

---

*This submission demonstrates comprehensive understanding of LDAP directory services, OpenLDAP configuration, user management, and enterprise authentication systems.*
