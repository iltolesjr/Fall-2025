# LDAP Server Lab - Quick Command Reference

## vCenter Lab: LDAP Server - Command Guide

### 🚀 Quick Start Commands

**Step 1: Update System**
```bash
sudo apt update
```

**Step 2: Install LDAP**
```bash
sudo apt install -y slapd ldap-utils
```

**Step 3: Configure LDAP**
```bash
sudo dpkg-reconfigure slapd
# Answer prompts:
# - Omit config? NO
# - Domain: school.edu
# - Organization: School
# - Admin password: (choose secure password)
```

**Step 4: Verify Service**
```bash
sudo systemctl status slapd
sudo ss -tlnp | grep 389
```

---

## 📋 Essential LDAP Commands

### Basic Queries
```bash
# Check naming contexts
ldapsearch -x -b "" -s base namingContexts

# Search entire directory
ldapsearch -x -b "dc=school,dc=edu" -LLL

# Search for specific user
ldapsearch -x -b "dc=school,dc=edu" -LLL uid=testuser

# Search with authentication
ldapsearch -x -D "cn=admin,dc=school,dc=edu" -W -b "dc=school,dc=edu"
```

### User Management
```bash
# Generate password hash
slappasswd

# Add user from LDIF file
ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f user.ldif

# Modify user
ldapmodify -x -D "cn=admin,dc=school,dc=edu" -W -f modify.ldif

# Test user authentication
ldapwhoami -x -D "uid=testuser,dc=school,dc=edu" -W
```

### Service Management
```bash
# Check service status
sudo systemctl status slapd

# Restart service
sudo systemctl restart slapd

# Enable on boot
sudo systemctl enable slapd

# View logs
sudo journalctl -u slapd -n 50
```

### Backup
```bash
# Backup entire LDAP database
sudo slapcat > ~/ldap-backup.ldif

# View backup
cat ~/ldap-backup.ldif
```

---

## 📝 LDIF File Templates

### Add User (testuser.ldif)
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

### Add Organizational Unit (users_ou.ldif)
```ldif
dn: ou=users,dc=school,dc=edu
objectClass: organizationalUnit
ou: users
description: Container for user accounts
```

### Add User in OU (user_in_ou.ldif)
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

### Modify User (modify_user.ldif)
```ldif
dn: uid=testuser,dc=school,dc=edu
changetype: modify
replace: loginShell
loginShell: /bin/zsh
```

### Add Group (students_group.ldif)
```ldif
dn: cn=students,ou=users,dc=school,dc=edu
objectClass: posixGroup
cn: students
gidNumber: 10000
memberUid: testuser
memberUid: yourstarid
```

---

## 🔍 Advanced LDAP Filters

### Search Filters
```bash
# Find all users with uidNumber
ldapsearch -x -b "dc=school,dc=edu" -LLL "(uidNumber=*)"

# Find users in UID range
ldapsearch -x -b "dc=school,dc=edu" -LLL "(&(uidNumber>=10000)(uidNumber<=10100))"

# Find users with specific login shell
ldapsearch -x -b "dc=school,dc=edu" -LLL "(loginShell=/bin/bash)"

# Find all organizational units
ldapsearch -x -b "dc=school,dc=edu" -LLL "(objectClass=organizationalUnit)"

# Find all groups
ldapsearch -x -b "dc=school,dc=edu" -LLL "(objectClass=posixGroup)"
```

### Filter Operators
- `&` = AND (all conditions must match)
- `|` = OR (any condition can match)
- `!` = NOT (condition must not match)
- `=` = Equals
- `>=` = Greater than or equal
- `<=` = Less than or equal
- `*` = Wildcard (any value)

---

## 📋 Lab Progress Quick Checklist

### Setup Phase
- [ ] Update system packages
- [ ] Install slapd and ldap-utils
- [ ] Configure slapd with domain
- [ ] Verify service is running
- [ ] Check port 389 is listening
- [ ] Write down your Base DN

### User Management Phase
- [ ] Create testuser.ldif
- [ ] Generate password hash
- [ ] Add testuser to LDAP
- [ ] Verify user was added
- [ ] Create organizational unit
- [ ] Add user to OU (with your StarID)

### Testing Phase
- [ ] Test LDAP authentication
- [ ] Modify user entry
- [ ] Verify modification
- [ ] Create POSIX group
- [ ] Add users to group

### Advanced Phase
- [ ] Backup LDAP database
- [ ] Run filtered searches
- [ ] Test range queries
- [ ] Review logs

### Documentation Phase
- [ ] Answer all 15 questions
- [ ] Capture 22+ screenshots
- [ ] Complete submission document
- [ ] Review and submit

---

## 🎯 Key Concepts to Remember

**Base DN**: The root of your LDAP directory (e.g., dc=school,dc=edu)

**Distinguished Name (DN)**: Unique identifier for an entry
- Example: uid=testuser,dc=school,dc=edu
- Example with OU: uid=jdoe,ou=users,dc=school,dc=edu

**Object Classes**: Define what type of entry it is
- inetOrgPerson: Person with organizational attributes
- posixAccount: Unix/Linux account
- shadowAccount: Password aging and policies
- organizationalUnit: Container for organizing entries
- posixGroup: Unix/Linux group

**LDIF**: LDAP Data Interchange Format
- Text file format for LDAP data
- Used with ldapadd, ldapmodify, ldapdelete

---

## 🔧 Troubleshooting Quick Fixes

**"Can't contact LDAP server"**
```bash
sudo systemctl restart slapd
sudo ss -tlnp | grep 389
```

**"Invalid credentials"**
- Check admin password
- Verify admin DN matches your Base DN
- Try: `sudo dpkg-reconfigure slapd`

**"No such object"**
- Verify Base DN is correct
- Check: `ldapsearch -x -b "" -s base namingContexts`

**"Already exists"**
- Entry already in directory
- Use different uid or delete first

**"Invalid syntax" in LDIF**
- Check colons have space after them
- No extra blank lines within entry
- Proper indentation

**Check logs for details**
```bash
sudo journalctl -u slapd -n 100
```

---

## 🎓 LDAP Terminology Cheat Sheet

| Term | Meaning |
|------|---------|
| LDAP | Lightweight Directory Access Protocol |
| DN | Distinguished Name (unique identifier) |
| RDN | Relative Distinguished Name |
| Base DN | Root of directory tree |
| DIT | Directory Information Tree |
| LDIF | LDAP Data Interchange Format |
| slapd | Standalone LDAP Daemon (server) |
| OU | Organizational Unit |
| cn | Common Name |
| uid | User ID |
| dc | Domain Component |
| objectClass | Defines entry type and attributes |

---

## 🚨 Important Reminders

⚠️ **Write down your Base DN** - you'll use it in every command!

⚠️ **Remember admin password** - you set it during dpkg-reconfigure

⚠️ **Take screenshots as you go** - don't wait until the end

⚠️ **Test each LDIF immediately** - catch errors early

⚠️ **Keep LDIF files organized** - create ~/ldap-lab directory

⚠️ **Save your work frequently** - LDAP changes are immediate

---

## 📚 Quick Reference Links

**Ports**:
- LDAP: 389 (unencrypted)
- LDAPS: 636 (SSL/TLS encrypted)

**Log Location**: `sudo journalctl -u slapd`

**Configuration**: `/etc/ldap/slapd.d/`

**Database Location**: `/var/lib/ldap/`

---

## ⏱️ Time Estimates

| Section | Time |
|---------|------|
| Installation & Config | 25 min |
| Basic Operations | 40 min |
| User Management | 35 min |
| Advanced Features | 30 min |
| Documentation | 30 min |
| **Total** | **~2.5-3 hours** |

---

## 💡 Pro Tips

1. **Copy/paste Base DN** to avoid typos
2. **Use tab completion** for file paths
3. **Keep terminal history** for reference
4. **Screenshot immediately** after each command
5. **Name screenshots descriptively**: 01-install.png, 02-config.png
6. **Test authentication** after each user creation
7. **Check logs** if something doesn't work
8. **Backup before modifications** (slapcat)

---

**Remember**: Replace `dc=school,dc=edu` with YOUR actual Base DN throughout all commands!

**Need Help?** Check the main lab document or completion guide for detailed explanations.

---

*Use this quick reference alongside the main lab document for efficient completion.*
