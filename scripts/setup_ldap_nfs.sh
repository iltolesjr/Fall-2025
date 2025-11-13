#!/usr/bin/env bash
set -e

echo "LDAP and NFS setup for Debian or Ubuntu"
echo "========================================"
echo

# Function to handle apt update with error recovery
safe_apt_update() {
    echo "Updating package lists..."
    if ! sudo apt update 2>&1; then
        echo "Warning: Some repositories failed to update"
        echo "Attempting to continue anyway..."
    fi
}

# Install required packages
echo "Installing LDAP and NFS packages..."
safe_apt_update
sudo apt install -y slapd ldap-utils nfs-kernel-server nfs-common

# Configure slapd
echo
echo "Configuring SLAPD (OpenLDAP server)..."
echo "You will be prompted to:"
echo "  1. Set your domain (e.g., school.edu)"
echo "  2. Set your organization name"
echo "  3. Set the administrator password"
echo
read -p "Press Enter to continue with slapd configuration..."
sudo dpkg-reconfigure slapd

# Get configuration from user (no hardcoded placeholders)
echo
echo "LDAP Configuration"
echo "------------------"
read -p "Enter base DN (example: dc=school,dc=edu): " BASE_DN
read -p "Enter admin DN (example: cn=admin,$BASE_DN): " ADMIN_DN
echo

# Test user configuration
echo "Test User Configuration"
echo "-----------------------"
read -p "Enter test user ID [default: testuser]: " TEST_UID
TEST_UID=${TEST_UID:-testuser}
read -p "Enter test user full name [default: Test User]: " TEST_CN
TEST_CN=${TEST_CN:-Test User}
read -s -p "Enter test user password: " TEST_PW
echo
read -s -p "Confirm password: " TEST_PW_CONFIRM
echo

# Validate passwords match
if [ "$TEST_PW" != "$TEST_PW_CONFIRM" ]; then
    echo "Error: Passwords do not match!"
    exit 1
fi

# Create LDIF file for test user
echo
echo "Creating test user in LDAP..."
LDIF_FILE=$(mktemp /tmp/testuser.XXXXXX.ldif)
cat > "$LDIF_FILE" <<EOF
dn: uid=$TEST_UID,$BASE_DN
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: $TEST_UID
cn: $TEST_CN
sn: ${TEST_CN##* }
loginShell: /bin/bash
uidNumber: 10000
gidNumber: 10000
homeDirectory: /home/$TEST_UID
userPassword: $(slappasswd -s "$TEST_PW")
EOF

# Add user to LDAP
echo "Adding user to LDAP directory..."
read -s -p "Enter LDAP admin password: " ADMIN_PW
echo
ldapadd -x -D "$ADMIN_DN" -w "$ADMIN_PW" -f "$LDIF_FILE"

# Clean up LDIF file
shred -u "$LDIF_FILE"

# Configure NFS
echo
echo "Configuring NFS Server"
echo "----------------------"
read -p "Enter NFS export directory [default: /srv/nfs]: " NFS_DIR
NFS_DIR=${NFS_DIR:-/srv/nfs}

# Create NFS directory
echo "Creating NFS export directory: $NFS_DIR"
sudo mkdir -p "$NFS_DIR"
sudo chown nobody:nogroup "$NFS_DIR"
sudo chmod 755 "$NFS_DIR"

# Configure NFS exports
read -p "Enter network to allow (e.g., 192.168.1.0/24): " NFS_NETWORK
echo "Adding NFS export configuration..."
echo "$NFS_DIR $NFS_NETWORK(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports

# Apply NFS configuration
echo "Applying NFS configuration..."
sudo exportfs -ra
sudo systemctl restart nfs-kernel-server

# Enable services on boot
echo
echo "Enabling services to start on boot..."
sudo systemctl enable slapd
sudo systemctl enable nfs-kernel-server

# Verify services are running
echo
echo "Verifying services..."
echo "---------------------"
if sudo systemctl is-active --quiet slapd; then
    echo "✓ SLAPD is running"
else
    echo "✗ SLAPD is not running"
fi

if sudo systemctl is-active --quiet nfs-kernel-server; then
    echo "✓ NFS server is running"
else
    echo "✗ NFS server is not running"
fi

# Test LDAP search
echo
echo "Testing LDAP configuration..."
echo "-----------------------------"
ldapsearch -x -b "$BASE_DN" -LLL uid="$TEST_UID"

# Show NFS exports
echo
echo "Current NFS exports:"
echo "--------------------"
sudo exportfs -v

echo
echo "========================================"
echo "Setup complete!"
echo
echo "LDAP Details:"
echo "  Base DN: $BASE_DN"
echo "  Admin DN: $ADMIN_DN"
echo "  Test User: $TEST_UID"
echo
echo "NFS Details:"
echo "  Export Directory: $NFS_DIR"
echo "  Network: $NFS_NETWORK"
echo
echo "Next steps:"
echo "  1. Test LDAP authentication with: ldapwhoami -x -D uid=$TEST_UID,$BASE_DN -W"
echo "  2. Mount NFS share on client: sudo mount <server-ip>:$NFS_DIR /mnt"
echo "========================================"
