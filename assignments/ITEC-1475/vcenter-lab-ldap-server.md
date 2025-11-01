# On-Campus vCenter Lab: LDAP Server - ITEC 1475

**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Semester**: Fall 2025  
**Lab Type**: Linux System Administration - Directory Services  

## Lab Overview

The purpose of this lab is to learn about LDAP (Lightweight Directory Access Protocol) and its role in enterprise user management and authentication. LDAP is a critical service in modern IT infrastructure, used for centralizing user accounts, authentication, and directory information across multiple systems.

In this lab you will:

- Install and configure OpenLDAP (slapd) server
- Create and manage LDAP directory structure
- Add users to the LDAP directory
- Test LDAP authentication and queries
- Understand LDAP directory information trees (DIT)
- Learn LDAP command-line tools (ldapsearch, ldapadd, ldapmodify)

## Important Instructions - READ CAREFULLY

**Create a new document. Read through the lab below in full, every word, then go back to the top and take action (doing or typing something) where the text is highlighted. Answer questions in green text by copy-and-pasting the question from the lab into your document, then answer the question, possibly adding a requested screenshot. When you're done with the lab, submit your document to the appropriate assignment folder (see the bottom of this document).**

**Please carefully read each section BEFORE you take action. Everything you need to know is listed in each section. Some sections tell you exactly what to do, some sections are testing you on what you read in the textbook, and in some sections you may need to do more research (looking at man pages, looking at other chapters in your books, or even doing some Googling).**

## Connect to the ITEC vCenter Cluster

For this lab, you MUST use the ITEC vCenter cluster (possibly by first remotely connecting to an ITEC remote desktop system if your own system is underpowered). Please follow the instructions in the OpenVPN and Access the ITEC vCenter document to run OpenVPN and get connected (remember to authenticate to the vCenter with `mpls\starid` and your StarID password). Then use the vCenter web interface (or the VMware window) to connect to the vCenter cluster.

---

## Part 1: Understanding LDAP

### What is LDAP?

LDAP (Lightweight Directory Access Protocol) is an industry-standard protocol for accessing and maintaining distributed directory information services over a network. It's commonly used for:

- Centralized user authentication
- Contact information directories
- Organization structure management
- Application configuration storage

### LDAP Components

**Directory Information Tree (DIT)**: The hierarchical structure of entries in an LDAP directory

**Distinguished Name (DN)**: The unique identifier for an entry in the directory
- Example: `uid=jdoe,ou=users,dc=school,dc=edu`

**Base DN**: The root of your LDAP directory
- Example: `dc=school,dc=edu`

**Object Classes**: Define what type of entry it is (person, group, organization)

**Attributes**: Properties of an entry (uid, cn, mail, etc.)

📝 **Question 1**: In your own words, explain what LDAP is and why organizations use it for user management.

📝 **Question 2**: What does DN stand for in LDAP, and what is its purpose?

---

## Part 2: Install OpenLDAP Server

OpenLDAP is the most widely used open-source implementation of LDAP. The server component is called `slapd` (Standalone LDAP Daemon).

### Update System Packages

**Highlighted Action**: Update your system package list first:

```bash
sudo apt update
```

**📸 Screenshot Required**: Terminal showing `apt update` results

### Install LDAP Packages

**Highlighted Action**: Install the OpenLDAP server and utilities:

```bash
sudo apt install -y slapd ldap-utils
```

**📸 Screenshot Required**: Terminal showing successful installation of slapd and ldap-utils

📝 **Question 3**: What is the difference between `slapd` and `ldap-utils`? What does each package provide?

---

## Part 3: Configure OpenLDAP Server

### Initial Configuration

During the installation, you may be prompted for some basic configuration. However, we'll reconfigure it properly now.

**Highlighted Action**: Reconfigure slapd with proper settings:

```bash
sudo dpkg-reconfigure slapd
```

You will be prompted for the following information:

1. **Omit OpenLDAP server configuration?** NO
2. **DNS domain name**: Enter your domain (e.g., `school.edu`)
   - This creates base DN as `dc=school,dc=edu`
3. **Organization name**: Enter your organization name (e.g., "School")
4. **Administrator password**: Choose a secure password (remember it!)
5. **Confirm password**: Re-enter the password
6. **Database backend**: MDB (default)
7. **Remove database when slapd is purged?** NO
8. **Move old database?** YES

**📸 Screenshot Required**: Terminal showing the dpkg-reconfigure process (at least the domain name prompt)

📝 **Question 4**: What did you choose for your DNS domain name? What is the resulting Base DN?

### Verify LDAP Service

**Highlighted Action**: Check that the LDAP service is running:

```bash
sudo systemctl status slapd
```

**📸 Screenshot Required**: Terminal showing slapd service status (should show "active (running)")

**Highlighted Action**: Verify LDAP is listening on the correct port:

```bash
sudo netstat -tlnp | grep 389
```

Or if netstat is not installed:

```bash
sudo ss -tlnp | grep 389
```

**📸 Screenshot Required**: Terminal showing LDAP listening on port 389

📝 **Question 5**: What port does LDAP use for non-encrypted connections? What port would be used for LDAPS (LDAP over SSL)?

---

## Part 4: Basic LDAP Queries

### Search the Directory

Now let's query the LDAP directory to see its basic structure.

**Highlighted Action**: Search for the base naming contexts:

```bash
ldapsearch -x -b "" -s base namingContexts
```

**📸 Screenshot Required**: Terminal showing the namingContexts output

**Highlighted Action**: Search the entire directory tree:

```bash
ldapsearch -x -b "dc=school,dc=edu" -LLL
```

**Note**: Replace `dc=school,dc=edu` with your actual Base DN.

**📸 Screenshot Required**: Terminal showing the directory structure

📝 **Question 6**: Explain what the `-x`, `-b`, and `-LLL` options do in the ldapsearch command.

---

## Part 5: Add Users to LDAP

### Understanding LDIF Files

LDIF (LDAP Data Interchange Format) is a text format for representing LDAP entries and changes. We'll create an LDIF file to add a user.

### Create Test User LDIF

**Highlighted Action**: Create a new file called `testuser.ldif`:

```bash
nano testuser.ldif
```

Add the following content (adjust the Base DN to match yours):

```ldif
dn: uid=testuser,dc=school,dc=edu
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: testuser
cn: Test User
sn: User
loginShell: /bin/bash
uidNumber: 10000
gidNumber: 10000
homeDirectory: /home/testuser
userPassword: {SSHA}REPLACE_WITH_SLAPPASSWD_OUTPUT
mail: testuser@school.edu
```

**Note**: Don't use the placeholder above. We'll generate a proper password hash with `slappasswd` in the next step.

### Generate Password Hash

**Highlighted Action**: Generate a secure password hash:

```bash
slappasswd
```

Enter a password when prompted. Copy the generated hash (it will look like `{SSHA}randomstring`).

**Highlighted Action**: Edit your `testuser.ldif` file and replace `{SSHA}REPLACE_WITH_SLAPPASSWD_OUTPUT` with the hash you just generated.

**📸 Screenshot Required**: Terminal showing the slappasswd command and generated hash (you can partially obscure the hash for security)

### Add User to Directory

**Highlighted Action**: Add the user to LDAP:

```bash
ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f testuser.ldif
```

**Note**: Replace the Base DN with yours. You'll be prompted for the admin password you set during configuration.

**📸 Screenshot Required**: Terminal showing successful user addition

📝 **Question 7**: What do the objectClass entries (inetOrgPerson, posixAccount, shadowAccount) represent? Why do we need multiple object classes?

### Verify User Was Added

**Highlighted Action**: Search for the user you just added:

```bash
ldapsearch -x -b "dc=school,dc=edu" -LLL uid=testuser
```

**📸 Screenshot Required**: Terminal showing the testuser entry details

---

## Part 6: Add an Organizational Unit

Organizational Units (OUs) help organize entries in your directory tree.

### Create OU LDIF File

**Highlighted Action**: Create a file called `users_ou.ldif`:

```bash
nano users_ou.ldif
```

Add this content:

```ldif
dn: ou=users,dc=school,dc=edu
objectClass: organizationalUnit
ou: users
description: Container for user accounts
```

**Highlighted Action**: Add the OU to LDAP:

```bash
ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f users_ou.ldif
```

**📸 Screenshot Required**: Terminal showing successful OU creation

📝 **Question 8**: Why is it beneficial to organize LDAP entries into Organizational Units?

---

## Part 7: Add a User to the OU

Now let's add another user within the organizational unit structure.

**Highlighted Action**: Create `user_in_ou.ldif`:

```bash
nano user_in_ou.ldif
```

Add content for a new user (use your StarID or another username):

```ldif
dn: uid=yourstarid,ou=users,dc=school,dc=edu
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: yourstarid
cn: Your Full Name
sn: LastName
loginShell: /bin/bash
uidNumber: 10001
gidNumber: 10000
homeDirectory: /home/yourstarid
userPassword: {SSHA}REPLACE_WITH_SLAPPASSWD_OUTPUT
mail: yourstarid@school.edu
```

**Highlighted Action**: Generate a password hash with `slappasswd` and update the LDIF file.

**Highlighted Action**: Add the user:

```bash
ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f user_in_ou.ldif
```

**📸 Screenshot Required**: Terminal showing the new user added to the OU

---

## Part 8: Test LDAP Authentication

### Test User Authentication

**Highlighted Action**: Test if a user can authenticate:

```bash
ldapwhoami -x -D "uid=testuser,dc=school,dc=edu" -W
```

Enter the password you set for testuser. If successful, it should return the user's DN.

**📸 Screenshot Required**: Terminal showing successful authentication with ldapwhoami

📝 **Question 9**: What happens if you enter the wrong password? Try it and describe the error message.

---

## Part 9: Modify LDAP Entries

### Modify User Information

**Highlighted Action**: Create a modification LDIF file `modify_user.ldif`:

```bash
nano modify_user.ldif
```

Add content to change the user's shell:

```ldif
dn: uid=testuser,dc=school,dc=edu
changetype: modify
replace: loginShell
loginShell: /bin/zsh
```

**Highlighted Action**: Apply the modification:

```bash
ldapmodify -x -D "cn=admin,dc=school,dc=edu" -W -f modify_user.ldif
```

**📸 Screenshot Required**: Terminal showing successful modification

**Highlighted Action**: Verify the change:

```bash
ldapsearch -x -b "dc=school,dc=edu" -LLL uid=testuser loginShell
```

**📸 Screenshot Required**: Terminal showing the updated loginShell value

📝 **Question 10**: What's the difference between `ldapadd`, `ldapmodify`, and `ldapdelete` commands?

---

## Part 10: Create a Group

### Add a POSIX Group

**Highlighted Action**: Create `students_group.ldif`:

```bash
nano students_group.ldif
```

Add this content:

```ldif
dn: cn=students,ou=users,dc=school,dc=edu
objectClass: posixGroup
cn: students
gidNumber: 10000
memberUid: testuser
memberUid: yourstarid
```

**Highlighted Action**: Add the group:

```bash
ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f students_group.ldif
```

**📸 Screenshot Required**: Terminal showing successful group creation

**Highlighted Action**: Verify the group:

```bash
ldapsearch -x -b "dc=school,dc=edu" -LLL cn=students
```

**📸 Screenshot Required**: Terminal showing the students group details

📝 **Question 11**: How do LDAP groups differ from Linux system groups?

---

## Part 11: Backup and Restore

### Backup LDAP Database

**Highlighted Action**: Create a backup of your entire LDAP database:

```bash
sudo slapcat > ~/ldap-backup.ldif
```

**Highlighted Action**: View the backup file:

```bash
cat ~/ldap-backup.ldif
```

**📸 Screenshot Required**: Terminal showing the backup command and first few lines of the backup file

📝 **Question 12**: Why is it important to regularly backup your LDAP directory? What situations would require a restore?

---

## Part 12: Advanced Queries

### Search with Filters

**Highlighted Action**: Search for all users (entries with uidNumber):

```bash
ldapsearch -x -b "dc=school,dc=edu" -LLL "(uidNumber=*)"
```

**📸 Screenshot Required**: Terminal showing filtered search results

**Highlighted Action**: Search for users with specific UID range:

```bash
ldapsearch -x -b "dc=school,dc=edu" -LLL "(&(uidNumber>=10000)(uidNumber<=10100))"
```

**📸 Screenshot Required**: Terminal showing range query results

📝 **Question 13**: Explain the LDAP filter syntax. What do the `&`, `|`, and `!` operators mean?

---

## Part 13: Security Considerations

### Service Management

**Highlighted Action**: Check the service configuration:

```bash
sudo systemctl status slapd
sudo systemctl is-enabled slapd
```

**📸 Screenshot Required**: Terminal showing service status and enabled state

📝 **Question 14**: List three security best practices for running an LDAP server in a production environment.

---

## Part 14: Troubleshooting

### View LDAP Logs

**Highlighted Action**: View recent LDAP logs:

```bash
sudo journalctl -u slapd -n 50
```

**📸 Screenshot Required**: Terminal showing recent LDAP log entries

📝 **Question 15**: If you couldn't connect to LDAP on port 389, what troubleshooting steps would you take?

---

## Lab Summary and Submission

### What You Accomplished

In this lab, you:

✅ Installed and configured OpenLDAP server (slapd)  
✅ Understood LDAP directory structure and terminology  
✅ Created LDAP entries using LDIF files  
✅ Added users and organizational units  
✅ Tested LDAP authentication  
✅ Modified LDAP entries  
✅ Created LDAP groups  
✅ Backed up the LDAP database  
✅ Performed advanced LDAP queries  
✅ Learned LDAP security considerations  

### Key Concepts Review

- **LDAP**: Directory service protocol for centralized authentication
- **DIT**: Directory Information Tree - hierarchical structure
- **DN**: Distinguished Name - unique identifier for entries
- **LDIF**: LDAP Data Interchange Format for data representation
- **slapd**: OpenLDAP server daemon
- **Object Classes**: Define entry types and required/optional attributes
- **Base DN**: Root of the LDAP directory tree

### Submission Requirements

Your submission document should include:

1. **All 15 answered questions** with complete explanations
2. **All required screenshots** clearly labeled by section
3. **Your Base DN** and domain configuration
4. **List of users created** with their DNs
5. **Any troubleshooting** you had to perform
6. **Time invested** in completing the lab

### Submission Format

- Submit as: **PDF or Word Document**
- File name format: `[YourStarID]-LDAP-Lab.pdf` or `.docx`
- Submit to: **Canvas Assignment - vCenter Lab: LDAP Server**

### Additional Resources

- [OpenLDAP Documentation](https://www.openldap.org/doc/)
- [LDAP Filters Tutorial](https://ldap.com/ldap-filters/)
- [Understanding LDAP Design](https://www.zytrax.com/books/ldap/)

---

## Optional Challenge (Extra Credit)

If you finish early or want extra practice:

1. Install and configure LDAP Account Manager (LAM) - a web-based interface
2. Configure LDAP over TLS/SSL (LDAPS on port 636)
3. Set up LDAP client authentication on another VM
4. Create a script to bulk-import users from a CSV file

Document any optional work in a separate section of your submission for potential extra credit consideration.

---

**Remember**: LDAP is a foundational technology in enterprise IT. The skills you learn here apply to Active Directory, Azure AD, and many other directory services.

**Need Help?** Don't hesitate to ask your instructor or classmates. LDAP can be complex, especially when first learning the concepts!

---

*This lab is designed to provide hands-on experience with enterprise directory services and centralized user management.*
