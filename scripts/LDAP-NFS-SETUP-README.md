# LDAP and NFS Setup Script

## Overview

This script (`setup_ldap_nfs.sh`) automates the installation and configuration of:
- **OpenLDAP (slapd)**: Lightweight Directory Access Protocol server for centralized user authentication
- **NFS Server**: Network File System for sharing directories across a network

## Problem Resolution

### Original Issue
The original script attempt had several problems:
1. **Syntax Error**: Corrupted heredoc with malformed command (`sudo ./setup_ldap_nfs.shshred and the test file"nfs defaults 0 0"`)
2. **Docker Repository Error**: The apt update failed due to a missing Docker repository release file
3. **Incomplete Implementation**: The script was cut off and didn't complete the setup

### Solutions Implemented
1. **Fixed Script Syntax**: Complete, properly formatted bash script with error handling
2. **Graceful Error Recovery**: Added `safe_apt_update()` function that continues even if some repositories fail
3. **Complete Implementation**: Full LDAP and NFS setup with user creation and verification
4. **Security Best Practices**: 
   - Uses `slappasswd` for password hashing
   - Securely shreds temporary LDIF files
   - No hardcoded credentials

## Prerequisites

- Debian or Ubuntu Linux system
- Sudo privileges
- Internet connection for package downloads

## Usage

### Basic Usage

```bash
sudo ./setup_ldap_nfs.sh
```

### Interactive Prompts

The script will prompt you for:

1. **SLAPD Configuration** (via dpkg-reconfigure):
   - Domain name (e.g., school.edu)
   - Organization name
   - Administrator password

2. **LDAP Configuration**:
   - Base DN (e.g., `dc=school,dc=edu`)
   - Admin DN (e.g., `cn=admin,dc=school,dc=edu`)

3. **Test User Details**:
   - User ID (default: testuser)
   - Full name (default: Test User)
   - Password

4. **NFS Configuration**:
   - Export directory (default: `/srv/nfs`)
   - Network to allow (e.g., `192.168.1.0/24`)

## Features

### Error Handling
- Gracefully handles apt repository errors
- Validates password confirmation
- Checks service status after configuration
- Provides clear error messages

### Security
- No hardcoded passwords or placeholders
- Securely hashes LDAP passwords
- Shreds temporary files containing sensitive data
- Prompts for credentials interactively

### Verification
- Tests LDAP search functionality
- Verifies services are running
- Displays final configuration summary
- Shows NFS exports

## Troubleshooting

### Docker Repository Error

If you encounter the error:
```
E: The repository 'https://download.docker.com/linux/ubuntu xia Release' does not have a Release file.
```

**Solution**: The script now handles this gracefully with `safe_apt_update()`. The error won't stop the installation.

**Manual Fix** (optional):
```bash
# Remove the problematic Docker repository
sudo rm /etc/apt/sources.list.d/docker.list
sudo apt update
```

### LDAP Connection Issues

Test LDAP connection:
```bash
ldapsearch -x -b "dc=school,dc=edu" -LLL
```

### NFS Mount Issues

On client machines, test NFS mount:
```bash
# Show available exports
showmount -e <server-ip>

# Mount the share
sudo mount <server-ip>:/srv/nfs /mnt
```

## Post-Installation

### Test LDAP Authentication
```bash
# Test user authentication
ldapwhoami -x -D "uid=testuser,dc=school,dc=edu" -W

# Search for users
ldapsearch -x -b "dc=school,dc=edu" -LLL uid=testuser
```

### Test NFS Share
```bash
# On client machine
sudo apt install nfs-common
sudo mkdir -p /mnt/nfs
sudo mount <server-ip>:/srv/nfs /mnt/nfs

# Test write access
echo "test" | sudo tee /mnt/nfs/test.txt
```

## Configuration Files

The script modifies the following files:
- `/etc/ldap/slapd.d/` - LDAP configuration
- `/etc/exports` - NFS export configuration
- Creates user in LDAP directory

## Services Managed

- `slapd` - OpenLDAP server (port 389)
- `nfs-kernel-server` - NFS server (port 2049)

Both services are enabled to start on boot.

## Example Configuration

```
LDAP Setup:
  Base DN: dc=school,dc=edu
  Admin DN: cn=admin,dc=school,dc=edu
  Test User: testuser (uid=10000)

NFS Setup:
  Export: /srv/nfs
  Network: 192.168.1.0/24
  Options: rw,sync,no_subtree_check,no_root_squash
```

## Security Considerations

1. **Firewall Rules**: Ensure ports 389 (LDAP) and 2049 (NFS) are open
2. **Network Access**: Limit NFS exports to trusted networks only
3. **LDAP Security**: Consider enabling LDAPS (LDAP over SSL/TLS)
4. **Regular Updates**: Keep packages updated with `sudo apt update && sudo apt upgrade`

## Additional Resources

- [OpenLDAP Documentation](https://www.openldap.org/doc/)
- [NFS Ubuntu Guide](https://ubuntu.com/server/docs/service-nfs)
- [LDAP Authentication Setup](https://help.ubuntu.com/community/LDAPClientAuthentication)

## License

This script is provided for educational purposes as part of the Fall 2025 coursework.
