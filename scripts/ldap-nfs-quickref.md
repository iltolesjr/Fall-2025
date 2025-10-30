# LDAP & NFS Quick Reference

## LDAP Commands

### Search Operations
```bash
# Search entire directory
ldapsearch -x -b "dc=school,dc=edu" -LLL

# Search for specific user
ldapsearch -x -b "dc=school,dc=edu" -LLL uid=testuser

# Search with authentication
ldapsearch -x -D "cn=admin,dc=school,dc=edu" -W -b "dc=school,dc=edu"
```

### User Management
```bash
# Add user from LDIF file
ldapadd -x -D "cn=admin,dc=school,dc=edu" -W -f user.ldif

# Modify user
ldapmodify -x -D "cn=admin,dc=school,dc=edu" -W -f modify.ldif

# Delete user
ldapdelete -x -D "cn=admin,dc=school,dc=edu" -W "uid=testuser,dc=school,dc=edu"

# Test authentication
ldapwhoami -x -D "uid=testuser,dc=school,dc=edu" -W
```

### Password Management
```bash
# Generate password hash
slappasswd -s "password"

# Change user password
ldappasswd -x -D "cn=admin,dc=school,dc=edu" -W -S "uid=testuser,dc=school,dc=edu"
```

## NFS Commands

### Server Side
```bash
# Edit exports
sudo nano /etc/exports

# Reload exports without restart
sudo exportfs -ra

# Show current exports
sudo exportfs -v

# Restart NFS server
sudo systemctl restart nfs-kernel-server

# Check NFS status
sudo systemctl status nfs-kernel-server
```

### Client Side
```bash
# Install NFS client
sudo apt install nfs-common

# Show available exports from server
showmount -e <server-ip>

# Mount NFS share
sudo mount <server-ip>:/srv/nfs /mnt/nfs

# Unmount
sudo umount /mnt/nfs

# Auto-mount on boot (add to /etc/fstab)
<server-ip>:/srv/nfs /mnt/nfs nfs defaults 0 0
```

## Service Management

### SLAPD (OpenLDAP)
```bash
# Start/Stop/Restart
sudo systemctl start slapd
sudo systemctl stop slapd
sudo systemctl restart slapd

# Status
sudo systemctl status slapd

# Enable/Disable on boot
sudo systemctl enable slapd
sudo systemctl disable slapd

# View logs
sudo journalctl -u slapd -f
```

### NFS Server
```bash
# Start/Stop/Restart
sudo systemctl start nfs-kernel-server
sudo systemctl stop nfs-kernel-server
sudo systemctl restart nfs-kernel-server

# Status
sudo systemctl status nfs-kernel-server

# Enable/Disable on boot
sudo systemctl enable nfs-kernel-server
sudo systemctl disable nfs-kernel-server

# View logs
sudo journalctl -u nfs-kernel-server -f
```

## Troubleshooting

### LDAP Issues
```bash
# Check if LDAP is listening
sudo netstat -tlnp | grep 389

# Test local connection
ldapsearch -x -b "" -s base namingContexts

# View LDAP logs
sudo tail -f /var/log/syslog | grep slapd
```

### NFS Issues
```bash
# Check NFS processes
ps aux | grep nfs

# Check RPC info
rpcinfo -p

# View NFS stats
nfsstat

# Check mount status
mount | grep nfs
```

## Example LDIF Files

### Add User
```ldif
dn: uid=jdoe,dc=school,dc=edu
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: jdoe
cn: John Doe
sn: Doe
loginShell: /bin/bash
uidNumber: 10001
gidNumber: 10001
homeDirectory: /home/jdoe
userPassword: {SSHA}hashedpassword
```

### Add Group
```ldif
dn: cn=students,dc=school,dc=edu
objectClass: posixGroup
cn: students
gidNumber: 10000
```

### Modify User
```ldif
dn: uid=jdoe,dc=school,dc=edu
changetype: modify
replace: loginShell
loginShell: /bin/zsh
```

## Common /etc/exports Examples

```bash
# Read-only export to specific network
/srv/nfs 192.168.1.0/24(ro,sync,no_subtree_check)

# Read-write with root access
/srv/nfs 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)

# Multiple networks
/srv/nfs 192.168.1.0/24(rw,sync) 10.0.0.0/8(ro,sync)

# Specific hosts
/srv/nfs client1.example.com(rw,sync) client2.example.com(rw,sync)
```

## Security Checklist

- [ ] Firewall configured for LDAP (389) and NFS (2049)
- [ ] Strong admin passwords set
- [ ] NFS exports limited to trusted networks
- [ ] Regular backups of LDAP database
- [ ] SSL/TLS enabled for LDAP (recommended)
- [ ] File permissions properly set on NFS exports
- [ ] Services updated regularly

## Backup Commands

### LDAP Backup
```bash
# Backup entire directory
sudo slapcat > ldap-backup.ldif

# Backup specific subtree
sudo slapcat -b "dc=school,dc=edu" > school-backup.ldif
```

### LDAP Restore
```bash
# Stop service
sudo systemctl stop slapd

# Clear database
sudo rm -rf /var/lib/ldap/*

# Restore
sudo slapadd < ldap-backup.ldif

# Start service
sudo systemctl start slapd
```
