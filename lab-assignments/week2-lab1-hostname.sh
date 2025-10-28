#!/usr/bin/env bash
# week2-lab1-hostname.sh
# Week 2 Lab 1: Hostname Configuration - ITEC 1475
# 
# This script guides you through the hostname configuration lab.
# Based on vCenter Lab: Change the Hostname
#
# SERVER INFORMATION:
# StarID: fj3453rb
# Hostname: fj3453rb-mint
# IP Address: 10.14.75.235
# Network Interface: ens33
#
# USAGE: 
#   sudo ./week2-lab1-hostname.sh

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
echo "║    Week 2 Lab 1: Hostname Configuration - ITEC 1475           ║"
echo "║    Fall 2025                                                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

print_info "This lab focuses on hostname management and network configuration."
print_info "You will change the system hostname and configure network settings."
echo ""
echo "Press Enter to begin..."
read -r

# =============================================================================
# STEP 1: Change the Hostname
# =============================================================================
print_step "STEP 1: Change the Hostname"

print_info "Current hostname: $(hostname)"
print_warning "We will change the hostname to: fj3453rb-mint"
print_warning "Note: Replace 'fj3453rb' with YOUR actual StarID!"
echo ""

print_info "Setting hostname..."
hostnamectl set-hostname fj3453rb-mint

print_info "Verifying hostname change..."
echo ""
hostnamectl
echo ""

pause_for_screenshot "New hostname displayed by hostnamectl command"

# =============================================================================
# STEP 2: Find Your IP Address
# =============================================================================
print_step "STEP 2: Find Your IP Address"

print_info "Displaying network configuration..."
echo ""
ip a
echo ""

print_info "Look for your IP address (e.g., 10.14.75.235) under the 'inet' line"
print_info "Common interface names: ens33, eth0, enp0s3"
echo ""

pause_for_screenshot "IP address output showing your system's network configuration"

# =============================================================================
# STEP 3: Update the /etc/hosts File
# =============================================================================
print_step "STEP 3: Update the /etc/hosts File"

print_info "Backing up current hosts file..."
cp /etc/hosts /etc/hosts.backup.$(date +%Y%m%d-%H%M%S)

print_info "Current /etc/hosts content:"
echo ""
cat /etc/hosts
echo ""

print_info "Adding entry to /etc/hosts..."
HOSTNAME=$(hostname)
IP_ADDR="10.14.75.235"

# Check if entry already exists
if grep -q "$HOSTNAME" /etc/hosts; then
    print_warning "Hostname entry already exists in /etc/hosts"
else
    echo "$IP_ADDR    $HOSTNAME" >> /etc/hosts
    print_info "Added: $IP_ADDR    $HOSTNAME"
fi

print_info "Updated /etc/hosts content:"
echo ""
cat /etc/hosts
echo ""

pause_for_screenshot "/etc/hosts file showing the new entry"

# =============================================================================
# STEP 4: Test Connectivity (if applicable)
# =============================================================================
print_step "STEP 4: Test Network Connectivity"

print_info "Testing if hostname resolves..."
echo ""
ping -c 2 $(hostname) || true
echo ""

print_info "Testing external connectivity..."
echo ""
ping -c 3 google.com
echo ""

pause_for_screenshot "Ping test results showing connectivity"

# =============================================================================
# Optional: Group Member Testing
# =============================================================================
print_step "OPTIONAL: Group Member Testing"

echo ""
print_info "If you have group member information, you can test connectivity to them."
print_info "Example entries to add to /etc/hosts:"
echo ""
echo "  10.14.75.XXX    member1-hostname-mint"
echo "  10.14.75.YYY    member2-hostname-mint"
echo "  10.14.75.ZZZ    member3-hostname-mint"
echo ""

print_warning "This section requires coordination with your group members."
print_info "To manually add entries, edit /etc/hosts:"
echo "  sudo nano /etc/hosts"
echo ""

print_info "Would you like to add group member entries now? (y/n)"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    print_info "Opening /etc/hosts in nano for editing..."
    print_warning "Add your group members' IP addresses and hostnames"
    print_warning "Save with Ctrl+X, then Y, then Enter"
    echo ""
    echo "Press Enter to open nano..."
    read -r
    nano /etc/hosts
    
    print_info "Updated /etc/hosts:"
    echo ""
    cat /etc/hosts
    echo ""
    
    print_info "You can now test connectivity to group members:"
    print_info "  ping -c 2 member1-hostname-mint"
    echo ""
fi

# =============================================================================
# COMPLETION
# =============================================================================
print_step "LAB COMPLETE!"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       Week 2 Lab 1: Hostname Configuration Completed!          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

print_info "Summary of what was accomplished:"
echo "  • Changed hostname to: $(hostname)"
echo "  • Verified IP address: $IP_ADDR"
echo "  • Updated /etc/hosts file"
echo "  • Tested network connectivity"
echo "  • Backup created: /etc/hosts.backup.*"
echo ""

print_info "Required Screenshots Checklist:"
echo "  □ Screenshot 1: New hostname from hostnamectl"
echo "  □ Screenshot 2: IP address from 'ip a' command"
echo "  □ Screenshot 3: Updated /etc/hosts file"
echo "  □ Screenshot 4: Ping test results"
echo "  □ (Optional) Screenshots of group member testing"
echo ""

print_info "Next Steps:"
echo "  1. Verify you have all required screenshots"
echo "  2. Create your lab submission document"
echo "  3. Include all screenshots with clear labels"
echo "  4. Add brief explanations for each step"
echo "  5. Include any troubleshooting notes"
echo "  6. Submit to the appropriate assignment folder"
echo ""

print_info "Related Files:"
echo "  • Lab Instructions: assignments/ITEC-1475/vcenter-lab-hostname.md"
echo "  • Completion Guide: assignments/ITEC-1475/vcenter-lab-hostname-completion.md"
echo "  • Schedule: schedules/week2-linux-lab-schedule.md"
echo ""

echo -e "${GREEN}Thank you for using the automated lab script!${NC}"
echo ""
