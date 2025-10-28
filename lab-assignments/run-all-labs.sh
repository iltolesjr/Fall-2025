#!/usr/bin/env bash
# run-all-labs.sh
# Master script to run all ITEC 1475 lab assignments
# 
# This interactive menu allows you to run any lab script or all of them.
#
# USAGE: 
#   sudo ./run-all-labs.sh

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}ERROR: This script must be run as root (use sudo)${NC}"
    exit 1
fi

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Function to display header
show_header() {
    clear
    echo -e "${GREEN}"
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║         ITEC 1475 Lab Assignment Runner                        ║"
    echo "║         Fall 2025 - Interactive Menu System                    ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

# Function to display server info
show_server_info() {
    echo -e "${CYAN}Current Server Configuration:${NC}"
    echo "  • Hostname: fj3453rb-mint"
    echo "  • IP Address: 10.14.75.235"
    echo "  • Network Interface: ens33"
    echo "  • StarID: fj3453rb"
    echo ""
}

# Function to make scripts executable
make_executable() {
    chmod +x week2-lab1-hostname.sh 2>/dev/null || true
    chmod +x week2-lab2-software-managers.sh 2>/dev/null || true
    chmod +x lennox-server-complete-setup.sh 2>/dev/null || true
    chmod +x collect-lennox-outputs.sh 2>/dev/null || true
}

# Function to display menu
show_menu() {
    echo -e "${YELLOW}Available Labs:${NC}"
    echo ""
    echo "  ${GREEN}Week 2 Labs:${NC}"
    echo "    1) Week 2 Lab 1: Hostname Configuration"
    echo "    2) Week 2 Lab 2: Software Managers"
    echo ""
    echo "  ${GREEN}Lennox Server Labs:${NC}"
    echo "    3) Lennox Server Complete Setup"
    echo "    4) Collect Lennox Outputs (for submission)"
    echo ""
    echo "  ${GREEN}Special Options:${NC}"
    echo "    5) Run All Week 2 Labs (1 + 2)"
    echo "    6) Run Everything (All labs in sequence)"
    echo ""
    echo "    ${CYAN}i) Show Lab Information${NC}"
    echo "    ${CYAN}h) Display Help${NC}"
    echo "    ${RED}q) Quit${NC}"
    echo ""
}

# Function to show lab information
show_lab_info() {
    clear
    show_header
    echo -e "${CYAN}Lab Information:${NC}"
    echo ""
    
    echo -e "${GREEN}Week 2 Lab 1: Hostname Configuration${NC}"
    echo "  • Duration: ~30-45 minutes"
    echo "  • Focus: System hostname and network configuration"
    echo "  • Screenshots: 4 required"
    echo "  • Prerequisites: Root access, network connectivity"
    echo ""
    
    echo -e "${GREEN}Week 2 Lab 2: Software Managers${NC}"
    echo "  • Duration: ~45-60 minutes"
    echo "  • Focus: Package management systems (APT, Snap, Flatpak)"
    echo "  • Screenshots: 6 required"
    echo "  • Prerequisites: Root access, internet connection"
    echo ""
    
    echo -e "${GREEN}Lennox Server Complete Setup${NC}"
    echo "  • Duration: ~2-3 hours"
    echo "  • Focus: Full server configuration and services"
    echo "  • Screenshots: 8 required"
    echo "  • Prerequisites: Clean server environment, root access"
    echo "  • Services: Apache2, UFW, SSH configuration"
    echo ""
    
    echo -e "${GREEN}Collect Lennox Outputs${NC}"
    echo "  • Duration: ~2-5 minutes"
    echo "  • Purpose: Gather all system information for submission"
    echo "  • Output: Creates lennox-lab-outputs.txt"
    echo "  • When to use: After completing Lennox server setup"
    echo ""
    
    echo "Press Enter to return to menu..."
    read -r
}

# Function to show help
show_help() {
    clear
    show_header
    echo -e "${CYAN}Help & Instructions:${NC}"
    echo ""
    
    echo -e "${YELLOW}Getting Started:${NC}"
    echo "  1. Make sure you're running this script with sudo"
    echo "  2. Select a lab from the menu by entering its number"
    echo "  3. Follow on-screen instructions during lab execution"
    echo "  4. Take screenshots when prompted (marked with 📸)"
    echo "  5. Review and organize screenshots after completion"
    echo ""
    
    echo -e "${YELLOW}Screenshot Tips:${NC}"
    echo "  • Use a screenshot tool (Shift+Print Screen on most Linux systems)"
    echo "  • Ensure text is readable and complete output is visible"
    echo "  • Name screenshots clearly: lab1-step1.png, lab1-step2.png, etc."
    echo "  • Organize screenshots in order for your submission document"
    echo ""
    
    echo -e "${YELLOW}Customization:${NC}"
    echo "  • Replace 'fj3453rb' with YOUR StarID in all scripts"
    echo "  • Update IP address if different from 10.14.75.235"
    echo "  • Modify hostname to match your requirements"
    echo ""
    
    echo -e "${YELLOW}Troubleshooting:${NC}"
    echo "  • If script fails, read error messages carefully"
    echo "  • Check you have internet connectivity"
    echo "  • Ensure you have sufficient permissions (use sudo)"
    echo "  • Review related lab instructions in assignments/ITEC-1475/"
    echo ""
    
    echo -e "${YELLOW}After Completion:${NC}"
    echo "  • Verify all required screenshots were captured"
    echo "  • Create submission document with screenshots and explanations"
    echo "  • Include any troubleshooting notes or interesting findings"
    echo "  • Submit to appropriate assignment folder"
    echo ""
    
    echo "Press Enter to return to menu..."
    read -r
}

# Function to run a specific lab
run_lab() {
    local lab_script="$1"
    local lab_name="$2"
    
    echo ""
    echo -e "${GREEN}Starting: $lab_name${NC}"
    echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    if [ -f "$lab_script" ]; then
        bash "$lab_script"
    else
        echo -e "${RED}ERROR: Script not found: $lab_script${NC}"
        echo "Press Enter to continue..."
        read -r
        return 1
    fi
    
    echo ""
    echo -e "${GREEN}Completed: $lab_name${NC}"
    echo ""
    echo "Press Enter to return to menu..."
    read -r
}

# Main menu loop
main() {
    # Make scripts executable
    make_executable
    
    while true; do
        show_header
        show_server_info
        show_menu
        
        echo -n "Enter your choice: "
        read -r choice
        
        case $choice in
            1)
                run_lab "week2-lab1-hostname.sh" "Week 2 Lab 1: Hostname Configuration"
                ;;
            2)
                run_lab "week2-lab2-software-managers.sh" "Week 2 Lab 2: Software Managers"
                ;;
            3)
                run_lab "lennox-server-complete-setup.sh" "Lennox Server Complete Setup"
                ;;
            4)
                run_lab "collect-lennox-outputs.sh" "Collect Lennox Outputs"
                ;;
            5)
                echo ""
                echo -e "${GREEN}Running All Week 2 Labs...${NC}"
                echo ""
                run_lab "week2-lab1-hostname.sh" "Week 2 Lab 1: Hostname Configuration"
                run_lab "week2-lab2-software-managers.sh" "Week 2 Lab 2: Software Managers"
                echo ""
                echo -e "${GREEN}All Week 2 labs completed!${NC}"
                echo "Press Enter to return to menu..."
                read -r
                ;;
            6)
                echo ""
                echo -e "${GREEN}Running All Labs in Sequence...${NC}"
                echo ""
                run_lab "week2-lab1-hostname.sh" "Week 2 Lab 1: Hostname Configuration"
                run_lab "week2-lab2-software-managers.sh" "Week 2 Lab 2: Software Managers"
                run_lab "lennox-server-complete-setup.sh" "Lennox Server Complete Setup"
                run_lab "collect-lennox-outputs.sh" "Collect Lennox Outputs"
                echo ""
                echo -e "${GREEN}All labs completed! 🎉${NC}"
                echo "Press Enter to return to menu..."
                read -r
                ;;
            i|I)
                show_lab_info
                ;;
            h|H)
                show_help
                ;;
            q|Q)
                echo ""
                echo -e "${GREEN}Thank you for using the Lab Assignment Runner!${NC}"
                echo ""
                exit 0
                ;;
            *)
                echo ""
                echo -e "${RED}Invalid choice. Please try again.${NC}"
                echo "Press Enter to continue..."
                read -r
                ;;
        esac
    done
}

# Run main menu
main
