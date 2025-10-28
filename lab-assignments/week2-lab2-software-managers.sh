#!/usr/bin/env bash
# week2-lab2-software-managers.sh
# Week 2 Lab 2: Software Managers - ITEC 1475
# 
# This script demonstrates various Linux software management tools.
# Based on vCenter Lab: Other Software Managers
#
# USAGE: 
#   sudo ./week2-lab2-software-managers.sh

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
echo "║    Week 2 Lab 2: Software Managers - ITEC 1475                ║"
echo "║    Fall 2025                                                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

print_info "This lab reviews various software management tools on Linux."
print_info "You will explore APT, Snap, Flatpak, and other package managers."
echo ""
echo "Press Enter to begin..."
read -r

# =============================================================================
# PART 1: Traditional Package Managers (APT)
# =============================================================================
print_step "PART 1: APT Package Manager (Debian/Ubuntu)"

print_info "Updating package lists..."
apt update

print_info "APT Commands Overview:"
echo ""
echo "Basic APT Commands:"
echo "  apt update              - Update package lists"
echo "  apt upgrade             - Upgrade all packages"
echo "  apt install <package>   - Install a package"
echo "  apt remove <package>    - Remove a package"
echo "  apt search <package>    - Search for packages"
echo "  apt show <package>      - Show package details"
echo "  apt list --installed    - List installed packages"
echo ""

print_info "Example: Searching for a package..."
echo ""
apt search htop | head -10
echo ""

print_info "Example: Showing package details..."
echo ""
apt show htop
echo ""

pause_for_screenshot "APT commands and package information"

# =============================================================================
# PART 2: Snap Package Manager
# =============================================================================
print_step "PART 2: Snap Package Manager"

print_info "Checking if Snap is installed..."
if command -v snap &> /dev/null; then
    print_info "Snap is installed!"
    snap version
else
    print_warning "Snap is not installed. Installing..."
    apt install snapd -y
    systemctl enable --now snapd.socket
    print_info "Snap installed successfully!"
fi

echo ""
print_info "Snap Commands Overview:"
echo ""
echo "Basic Snap Commands:"
echo "  snap find <package>     - Search for snaps"
echo "  snap install <package>  - Install a snap"
echo "  snap list               - List installed snaps"
echo "  snap remove <package>   - Remove a snap"
echo "  snap refresh            - Update all snaps"
echo "  snap info <package>     - Show snap information"
echo ""

print_info "Listing installed snaps..."
echo ""
snap list || echo "No snaps installed yet"
echo ""

print_info "Example: Searching for a snap package..."
echo ""
snap find hello | head -10
echo ""

pause_for_screenshot "Snap commands and installed snaps"

# =============================================================================
# PART 3: Flatpak Package Manager
# =============================================================================
print_step "PART 3: Flatpak Package Manager"

print_info "Checking if Flatpak is installed..."
if command -v flatpak &> /dev/null; then
    print_info "Flatpak is installed!"
    flatpak --version
else
    print_warning "Flatpak is not installed. Installing..."
    apt install flatpak -y
    print_info "Flatpak installed successfully!"
fi

echo ""
print_info "Flatpak Commands Overview:"
echo ""
echo "Basic Flatpak Commands:"
echo "  flatpak search <package>  - Search for packages"
echo "  flatpak install <package> - Install a package"
echo "  flatpak list              - List installed packages"
echo "  flatpak uninstall <pkg>   - Uninstall a package"
echo "  flatpak update            - Update all packages"
echo ""

print_info "Listing installed Flatpaks..."
echo ""
flatpak list || echo "No Flatpaks installed yet"
echo ""

pause_for_screenshot "Flatpak commands and status"

# =============================================================================
# PART 4: Alternative Installation Methods
# =============================================================================
print_step "PART 4: Alternative Installation Methods"

print_info "Overview of Other Installation Methods:"
echo ""
echo "1. AppImage:"
echo "   - Portable application format"
echo "   - No installation required"
echo "   - Download and make executable: chmod +x app.AppImage"
echo "   - Run directly: ./app.AppImage"
echo ""

echo "2. .deb Packages (Debian/Ubuntu):"
echo "   - Download .deb file"
echo "   - Install: sudo dpkg -i package.deb"
echo "   - Fix dependencies: sudo apt install -f"
echo ""

echo "3. .tar.gz Archives:"
echo "   - Extract: tar -xzf package.tar.gz"
echo "   - Often contains pre-compiled binaries"
echo "   - May need to add to PATH or symlink"
echo ""

echo "4. Source Code Compilation:"
echo "   - Extract source code"
echo "   - ./configure"
echo "   - make"
echo "   - sudo make install"
echo ""

pause_for_screenshot "Alternative installation methods overview"

# =============================================================================
# PART 5: Installing a Sample Package with Each Manager
# =============================================================================
print_step "PART 5: Practical Examples"

print_info "This section demonstrates installing a simple package with different managers."
echo ""

# APT Example
print_info "Example 1: Installing 'tree' with APT..."
echo ""
if ! command -v tree &> /dev/null; then
    apt install tree -y
    print_info "Installed 'tree' successfully!"
else
    print_info "'tree' is already installed"
fi
echo ""
echo "Testing tree command:"
tree -L 1 /etc | head -10
echo ""

pause_for_screenshot "APT package installation example"

# =============================================================================
# PART 6: Package Information and Management
# =============================================================================
print_step "PART 6: Package Information and Management"

print_info "Displaying system package information..."
echo ""

echo "=== Total Installed Packages (APT) ==="
dpkg --list | grep '^ii' | wc -l
echo ""

echo "=== Recently Installed Packages ==="
grep " install " /var/log/dpkg.log 2>/dev/null | tail -10 || echo "Log not available"
echo ""

echo "=== Upgradable Packages ==="
apt list --upgradable 2>/dev/null | head -10
echo ""

echo "=== Package Statistics ==="
echo "Installed packages: $(dpkg --list | grep '^ii' | wc -l)"
echo "Snaps installed: $(snap list 2>/dev/null | tail -n +2 | wc -l || echo 0)"
echo "Flatpaks installed: $(flatpak list 2>/dev/null | wc -l || echo 0)"
echo ""

pause_for_screenshot "Package information and statistics"

# =============================================================================
# COMPLETION
# =============================================================================
print_step "LAB COMPLETE!"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║      Week 2 Lab 2: Software Managers Completed!                ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

print_info "Summary of Package Managers Explored:"
echo "  • APT (Advanced Package Tool) - Debian/Ubuntu default"
echo "  • Snap - Universal Linux packages"
echo "  • Flatpak - Cross-distribution apps"
echo "  • Alternative methods (AppImage, .deb, source)"
echo ""

print_info "Required Screenshots Checklist:"
echo "  □ Screenshot 1: APT commands and package search"
echo "  □ Screenshot 2: Snap installation and commands"
echo "  □ Screenshot 3: Flatpak installation and commands"
echo "  □ Screenshot 4: Alternative methods overview"
echo "  □ Screenshot 5: Package installation example"
echo "  □ Screenshot 6: Package statistics"
echo ""

print_info "Key Takeaways:"
echo "  • APT is the primary package manager for Debian/Ubuntu systems"
echo "  • Snap and Flatpak provide cross-distribution compatibility"
echo "  • Different installation methods serve different purposes"
echo "  • Always prefer official repository packages when available"
echo "  • Update regularly to keep system secure"
echo ""

print_info "Next Steps:"
echo "  1. Review all screenshots captured"
echo "  2. Answer any questions from the lab instructions"
echo "  3. Create your lab submission document"
echo "  4. Include explanations demonstrating understanding"
echo "  5. Note any interesting findings or challenges"
echo "  6. Submit to the appropriate assignment folder"
echo ""

print_info "Related Files:"
echo "  • Lab Instructions: assignments/ITEC-1475/vcenter-lab-software-managers.md"
echo "  • Other Managers: assignments/ITEC-1475/other-software-managers-lab.md"
echo "  • Completion Guide: assignments/ITEC-1475/vcenter-lab-software-managers-completion-guide.md"
echo ""

echo -e "${GREEN}Thank you for using the automated lab script!${NC}"
echo ""
