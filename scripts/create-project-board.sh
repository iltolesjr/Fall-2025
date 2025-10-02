#!/bin/bash
# Bash wrapper for create-assignments-project.ps1
# This script helps users run the PowerShell script to create/update the project board

set -e

# Check if PowerShell is installed
if ! command -v pwsh &> /dev/null; then
    echo "❌ PowerShell (pwsh) is not installed."
    echo "   Install it from: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell"
    exit 1
fi

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "   Install it from: https://cli.github.com/"
    exit 1
fi

# Check if gh is authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ GitHub CLI is not authenticated."
    echo "   Run: gh auth login"
    exit 1
fi

# Get GitHub username
GH_USER=$(gh api user -q .login)

echo "🎓 Fall 2025 Assignment Project Board Creator"
echo "=============================================="
echo ""
echo "This script will:"
echo "  1. Read assignments from tracker files"
echo "  2. Create GitHub Issues for each assignment"
echo "  3. Add them to a Project Board"
echo "  4. Organize by status: Todo, In Progress, Done"
echo "  5. Label by course: ENGL-1110, ITEC-1475"
echo ""
echo "GitHub User: $GH_USER"
echo "Repository: Fall-2025"
echo ""

# Ask for confirmation
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Run the PowerShell script
echo ""
echo "Running PowerShell script..."
echo ""

cd "$(dirname "$0")/.."
pwsh -File scripts/create-assignments-project.ps1 -User "$GH_USER"

echo ""
echo "✅ Done! Check your GitHub Project Board."
