#!/bin/bash

# Fall 2025 MCP Setup Script
# This script sets up the Model Context Protocol configuration for academic workflow management

set -e

echo "🎓 Fall 2025 MCP Setup"
echo "======================"
echo

# Check Node.js installation
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16+ and try again."
    echo "   Download from: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt "16" ]; then
    echo "❌ Node.js version 16+ is required. Current version: $(node --version)"
    exit 1
fi

echo "✅ Node.js $(node --version) detected"

# Check if we're in the right directory
if [ ! -f "mcp.json" ]; then
    echo "❌ Please run this script from the Fall-2025 repository root directory"
    exit 1
fi

echo "✅ Repository structure verified"

# Install MCP server dependencies
echo "📦 Installing MCP server dependencies..."
cd .mcp
npm install

echo "✅ Dependencies installed"

# Test MCP server
echo "🧪 Testing MCP server..."
timeout 5s npm start || true
echo "✅ MCP server test completed"

cd ..

# Check VS Code settings
if [ -f ".vscode/settings.json" ]; then
    echo "✅ VS Code settings configured"
else
    echo "⚠️  VS Code settings not found - MCP client integration may require manual setup"
fi

# Verify file structure
echo "📁 Verifying academic file structure..."
for dir in assignments notes schedules discussions; do
    if [ -d "$dir" ]; then
        echo "✅ $dir/ directory found"
    else
        echo "⚠️  $dir/ directory not found - creating..."
        mkdir -p "$dir"
    fi
done

echo
echo "🎉 MCP Setup Complete!"
echo
echo "Next steps:"
echo "1. Open VS Code in this directory"
echo "2. Install the MCP extension (if not already installed)"
echo "3. Try asking Copilot: 'Show me my ITEC-1475 assignment tracker'"
echo "4. Read .mcp/README.md for detailed usage instructions"
echo
echo "Available MCP tools:"
echo "• get_assignment_tracker - View assignment status"
echo "• update_assignment_status - Update assignment progress"  
echo "• get_due_dates - Check upcoming deadlines"
echo "• create_study_schedule - Generate study plans"
echo "• organize_notes - Create note templates"
echo
echo "For help: cat .mcp/README.md"