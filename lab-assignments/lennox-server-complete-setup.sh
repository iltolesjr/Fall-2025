#!/usr/bin/env bash
# lennox-server-complete-setup.sh
# Complete Lennox Server Setup Lab - ITEC 1475
# 
# This script guides you through the complete Lennox server setup lab.
# It includes commands with pauses for screenshots where required.
#
# SERVER INFORMATION:
# Hostname: fj3453rb-mint
# IP Address: 10.14.75.235
# Network Interface: ens33
#
# USAGE: 
#   sudo ./lennox-server-complete-setup.sh
#
# NOTE: This script requires sudo/root privileges

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${GREEN}===== $1 =====${NC}"
}

print_info() {
    echo -e "${BLUE}INFO: $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}WARNING: $1${NC}"
}

print_screenshot() {
    echo -e "${MAGENTA}📸 SCREENSHOT REQUIRED: $1${NC}"
}

print_error() {
    echo -e "${RED}ERROR: $1${NC}"
}

# Function to pause for screenshot
pause_for_screenshot() {
    echo ""
    print_screenshot "$1"
    echo -e "${YELLOW}Press Enter after taking the screenshot to continue...${NC}"
    read -r
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    print_error "This script must be run as root (use sudo)"
    exit 1
fi

echo -e "${GREEN}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     Lennox Server Complete Setup Lab - ITEC 1475              ║"
echo "║     Fall 2025 - Automated Installation Script                 ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

print_info "This script will guide you through the complete server setup."
print_info "You will be prompted to take screenshots at required points."
echo ""
echo "Press Enter to begin..."
read -r

# =============================================================================
# STEP 1: Initial System Setup
# =============================================================================
print_step "STEP 1: Initial System Setup"

print_info "Updating system packages..."
apt update && apt upgrade -y

print_info "Checking system information..."
echo ""
hostnamectl
echo ""
uname -a

pause_for_screenshot "System update completion and system information"

# =============================================================================
# STEP 2: Configure Server Hostname and Network
# =============================================================================
print_step "STEP 2: Configure Server Hostname and Network"

print_info "Current hostname: $(hostname)"
print_info "Setting hostname to: fj3453rb-mint"

hostnamectl set-hostname fj3453rb-mint

print_info "Verifying hostname change..."
echo ""
hostnamectl
echo ""

print_info "Checking network configuration..."
echo ""
ip addr show

pause_for_screenshot "New hostname and network configuration"

# =============================================================================
# STEP 3: Create Administrative User Account
# =============================================================================
print_step "STEP 3: Create Administrative User Account"

print_info "Creating user 'serveradmin'..."
print_warning "You will be prompted to set a password for this user."

# Check if user already exists
if id "serveradmin" &>/dev/null; then
    print_warning "User 'serveradmin' already exists. Skipping creation."
else
    adduser serveradmin
    usermod -aG sudo serveradmin
    print_info "User created and added to sudo group."
fi

print_info "Verifying user creation and group membership..."
echo ""
id serveradmin
groups serveradmin

pause_for_screenshot "User creation and group assignment"

# =============================================================================
# STEP 4: Configure Basic Security Settings
# =============================================================================
print_step "STEP 4: Configure Basic Security Settings"

print_info "Backing up SSH configuration..."
if [ -f /etc/ssh/sshd_config ]; then
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
    print_info "SSH config backed up successfully."
    
    print_info "Checking current SSH configuration..."
    echo ""
    grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config || true
    echo ""
else
    print_warning "SSH config file not found. Skipping SSH configuration."
fi

print_info "Installing and configuring UFW firewall..."
apt install ufw -y

print_info "Configuring firewall rules..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
echo "y" | ufw enable

print_info "Checking firewall status..."
echo ""
ufw status verbose

pause_for_screenshot "SSH configuration and firewall status"

# =============================================================================
# STEP 5: Install Essential Server Services
# =============================================================================
print_step "STEP 5: Install Essential Server Services"

print_info "Installing essential packages..."
apt install -y curl wget htop net-tools tree nano vim

print_info "Installing Apache web server..."
apt install -y apache2

print_info "Enabling and starting Apache..."
systemctl enable apache2
systemctl start apache2

print_info "Checking Apache service status..."
echo ""
systemctl status apache2 --no-pager
echo ""

print_info "Testing web server locally..."
echo ""
curl localhost
echo ""

pause_for_screenshot "Apache service status and local web server test"

# =============================================================================
# STEP 6: Configure System Monitoring
# =============================================================================
print_step "STEP 6: Configure System Monitoring"

print_info "Displaying system resource information..."

echo ""
echo "=== Disk Usage ==="
df -h
echo ""

echo "=== Memory Usage ==="
free -h
echo ""

echo "=== Running Processes (top 10) ==="
ps aux | head -10
echo ""

echo "=== Recent System Logs ==="
journalctl --since "1 hour ago" | head -20
echo ""

pause_for_screenshot "System resource information (disk, memory, processes)"

# =============================================================================
# STEP 7: Create Server Documentation
# =============================================================================
print_step "STEP 7: Create Server Documentation"

print_info "Creating server documentation file..."

cat > /etc/server-info.txt << 'EOF'
Lennox Server Configuration
===========================
Server Name: fj3453rb-mint
Administrator: fj3453rb (Replace with your StarID)
Setup Date: $(date +%Y-%m-%d)
IP Address: 10.14.75.235
Network Interface: ens33
OS Version: $(lsb_release -d | cut -f2)
Services Installed: Apache2, UFW Firewall, SSH
Additional Tools: curl, wget, htop, net-tools, tree, nano, vim

Setup Steps Completed:
1. System update and upgrade
2. Hostname configuration
3. Administrative user creation (serveradmin)
4. SSH configuration and backup
5. UFW firewall installation and configuration
6. Apache web server installation
7. Essential tools installation
8. System monitoring setup
EOF

print_info "Verifying the documentation file..."
echo ""
cat /etc/server-info.txt

pause_for_screenshot "Completed server documentation file"

# =============================================================================
# STEP 8: Test Server Accessibility
# =============================================================================
print_step "STEP 8: Test Server Accessibility"

print_info "Testing network connectivity..."
echo ""
echo "=== Ping Test to Google ==="
ping -c 3 google.com
echo ""

print_info "Checking active services..."
echo ""
systemctl list-units --type=service --state=active | grep -E "apache2|ssh|ufw" || true
echo ""

print_info "Checking listening ports..."
echo ""
netstat -tlnp | head -20 || true
echo ""

pause_for_screenshot "Connectivity tests and service status verification"

# =============================================================================
# COMPLETION
# =============================================================================
print_step "SETUP COMPLETE!"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║          Lennox Server Setup Completed Successfully!           ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

print_info "Server Configuration Summary:"
echo "  • Hostname: fj3453rb-mint"
echo "  • IP Address: 10.14.75.235"
echo "  • Admin User: serveradmin"
echo "  • Firewall: Enabled (UFW)"
echo "  • Web Server: Apache2 (Running)"
echo "  • Essential Tools: Installed"
echo "  • Documentation: /etc/server-info.txt"
echo ""

print_info "Next Steps:"
echo "  1. Review all screenshots you captured"
echo "  2. Organize screenshots into a submission document"
echo "  3. Add brief explanations for each step"
echo "  4. Submit to the Lennox Server Setup assignment folder"
echo ""

print_info "To collect all outputs in one file, run:"
echo "  sudo ./collect-lennox-outputs.sh"
echo ""

echo -e "${GREEN}Thank you for using the automated setup script!${NC}"
echo ""
