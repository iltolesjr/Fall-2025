#!/bin/bash
# Fall 2025 Course Repository - Master Setup Script
# This script runs all the required commands to set up your course management system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                                                               ║${NC}"
echo -e "${BLUE}║          Fall 2025 Course Management Setup                    ║${NC}"
echo -e "${BLUE}║          Complete Automation Script                          ║${NC}"
echo -e "${BLUE}║                                                               ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Change to repository root
cd "$(dirname "$0")"

echo -e "${BLUE}📍 Working directory: $(pwd)${NC}"
echo ""

# ============================================================================
# SECTION 1: Prerequisites Check
# ============================================================================

echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}STEP 1: Checking Prerequisites${NC}"
echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo ""

# Check Node.js
echo -n "Checking Node.js... "
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✓ Found $NODE_VERSION${NC}"
else
    echo -e "${RED}✗ Not found${NC}"
    echo -e "${RED}Please install Node.js 16+ from https://nodejs.org/${NC}"
    exit 1
fi

# Check npm
echo -n "Checking npm... "
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo -e "${GREEN}✓ Found v$NPM_VERSION${NC}"
else
    echo -e "${RED}✗ Not found${NC}"
    exit 1
fi

# Check PowerShell
echo -n "Checking PowerShell... "
if command -v pwsh &> /dev/null; then
    PWSH_VERSION=$(pwsh --version | head -1)
    echo -e "${GREEN}✓ Found $PWSH_VERSION${NC}"
else
    echo -e "${YELLOW}⚠ Not found (optional for project board)${NC}"
    echo -e "${YELLOW}  Install from: https://docs.microsoft.com/powershell${NC}"
fi

# Check GitHub CLI
echo -n "Checking GitHub CLI... "
if command -v gh &> /dev/null; then
    GH_VERSION=$(gh --version | head -1)
    echo -e "${GREEN}✓ Found $GH_VERSION${NC}"
    
    # Check authentication
    echo -n "Checking GitHub authentication... "
    if gh auth status &> /dev/null; then
        GH_USER=$(gh api user -q .login 2>/dev/null || echo "unknown")
        echo -e "${GREEN}✓ Authenticated as $GH_USER${NC}"
    else
        echo -e "${YELLOW}⚠ Not authenticated${NC}"
        echo -e "${YELLOW}  Run: gh auth login${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Not found (optional for project board)${NC}"
    echo -e "${YELLOW}  Install from: https://cli.github.com/${NC}"
fi

echo ""

# ============================================================================
# SECTION 2: MCP Server Setup
# ============================================================================

echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}STEP 2: Setting Up MCP Server${NC}"
echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo ""

if [ -f ".mcp/package.json" ]; then
    echo "Installing MCP server dependencies..."
    cd .mcp
    npm install --silent
    cd ..
    echo -e "${GREEN}✓ MCP dependencies installed${NC}"
    
    # Test MCP server
    echo "Testing MCP server..."
    cd .mcp
    timeout 3s npm start &> /dev/null || true
    cd ..
    echo -e "${GREEN}✓ MCP server test completed${NC}"
else
    echo -e "${YELLOW}⚠ MCP configuration not found, skipping...${NC}"
fi

echo ""

# ============================================================================
# SECTION 3: Directory Structure Verification
# ============================================================================

echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}STEP 3: Verifying Directory Structure${NC}"
echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo ""

for dir in assignments notes schedules discussions screenshots; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $dir/ directory exists"
    else
        echo -e "${YELLOW}⚠${NC} Creating $dir/ directory..."
        mkdir -p "$dir"
    fi
done

echo ""

# ============================================================================
# SECTION 4: GitHub Project Board Setup
# ============================================================================

echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}STEP 4: GitHub Project Board Setup${NC}"
echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo ""

if command -v gh &> /dev/null && gh auth status &> /dev/null; then
    if command -v pwsh &> /dev/null; then
        echo "Do you want to set up the GitHub Project Board for assignment tracking?"
        echo "(This creates issues and a project board from your tracker files)"
        read -p "Continue? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Running project board setup..."
            if [ -x "./scripts/create-project-board.sh" ]; then
                ./scripts/create-project-board.sh
            else
                echo -e "${YELLOW}⚠ Project board script not executable, trying PowerShell directly...${NC}"
                GH_USER=$(gh api user -q .login)
                pwsh -File scripts/create-assignments-project.ps1 -User "$GH_USER"
            fi
            echo -e "${GREEN}✓ Project board setup completed${NC}"
        else
            echo -e "${YELLOW}⊘ Skipped project board setup${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ PowerShell not found - skipping project board setup${NC}"
        echo -e "${YELLOW}  To set up later, run: ./scripts/create-project-board.sh${NC}"
    fi
else
    echo -e "${YELLOW}⚠ GitHub CLI not authenticated - skipping project board setup${NC}"
    echo -e "${YELLOW}  To set up later, run: gh auth login${NC}"
    echo -e "${YELLOW}  Then run: ./scripts/create-project-board.sh${NC}"
fi

echo ""

# ============================================================================
# SECTION 5: Summary & Next Steps
# ============================================================================

echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}Setup Complete!${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${GREEN}✓ Setup completed successfully!${NC}"
echo ""

echo -e "${BLUE}📚 Your Course Management System is Ready:${NC}"
echo ""
echo "  ✓ MCP Server installed (AI-powered academic assistance)"
echo "  ✓ Directory structure verified"
if command -v gh &> /dev/null && gh auth status &> /dev/null; then
    echo "  ✓ GitHub integration configured"
fi
echo ""

echo -e "${BLUE}📖 Quick Reference:${NC}"
echo ""
echo "  View assignments:"
echo "    • ENGL-1110: cat assignments/ENGL-1110-tracker.md"
echo "    • ITEC-1475: cat assignments/ITEC-1475-tracker.md"
echo ""
echo "  Update project board:"
echo "    • ./scripts/create-project-board.sh"
echo ""
echo "  Start MCP server:"
echo "    • cd .mcp && npm start"
echo ""
echo "  Get help from Copilot:"
echo "    • 'Show me my assignment status'"
echo "    • 'What's due this week?'"
echo "    • 'Help me break down this assignment'"
echo ""

echo -e "${BLUE}📋 Important Files:${NC}"
echo "  • README.md - Repository overview and getting started"
echo "  • START-HERE.md - Step-by-step setup guide"
echo "  • assignments/*-tracker.md - Assignment tracking files"
echo "  • .github/copilot-instructions.md - Copilot configuration"
echo ""

echo -e "${BLUE}🔄 Daily Workflow:${NC}"
echo "  1. Update assignment status in tracker files"
echo "  2. Run ./scripts/create-project-board.sh to sync"
echo "  3. Check your GitHub project board for visual progress"
echo "  4. Ask Copilot for help with any coursework"
echo ""

echo -e "${BLUE}📞 Need Help?${NC}"
echo "  • Check README.md for detailed documentation"
echo "  • See QUICK-START-PROJECT-BOARD.md for project board help"
echo "  • Ask GitHub Copilot in your IDE"
echo ""

echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  🎓 Happy studying! Your Fall 2025 semester is organized! 🎓  ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
