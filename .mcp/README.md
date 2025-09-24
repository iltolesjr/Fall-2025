# MCP Configuration for Fall 2025 Academic Repository

This repository is configured with Model Context Protocol (MCP) support to enhance academic workflow management and integrate seamlessly with AI assistants and development tools.

## 🎯 What is MCP?

Model Context Protocol (MCP) enables AI assistants to securely connect to data sources and tools, providing rich context for better assistance. In this academic repository, MCP provides specialized tools for course management, assignment tracking, and study organization.

## 🚀 Quick Start

### Prerequisites

- Node.js (version 16 or higher)
- VS Code (recommended) with MCP extension support
- Git

### Setup

1. **Install Dependencies**
   ```bash
   cd .mcp
   npm install
   ```

2. **Configure VS Code**
   - The repository includes VS Code settings in `.vscode/settings.json`
   - MCP client configuration is in `mcp.json`

3. **Test MCP Server**
   ```bash
   cd .mcp
   npm start
   ```

## 📁 MCP Configuration Files

### Core Configuration
- `mcp.json` - Main MCP server configuration
- `.mcp/server.js` - Custom academic workflow server
- `.mcp/package.json` - Node.js dependencies
- `.mcp/agent-config.json` - Academic agent configuration
- `.vscode/settings.json` - VS Code integration settings

## 🛠️ Available MCP Tools

### Assignment Management
- **get_assignment_tracker**: Retrieve assignment status for any course
- **update_assignment_status**: Update assignment progress (Not Started → In Progress → Completed)

### Due Date Tracking  
- **get_due_dates**: Get upcoming deadlines across all courses
- **create_study_schedule**: Generate personalized study schedules

### Note Organization
- **organize_notes**: Create structured note templates
  - Cornell Notes format
  - Outline format
  - Mind Map structure
  - Summary format

### File System Access
- Secure access to course materials
- Read/write permissions for academic files
- Git integration for version control

## 🎓 Academic Workflow Integration

### Course Structure Support
The MCP server understands your repository structure:
```
Fall-2025/
├── assignments/           # Assignment trackers and materials
├── notes/                # Course notes and study materials  
├── schedules/            # Class schedules and planning
├── discussions/          # Discussion preparation and materials
└── .mcp/                # MCP configuration and server
```

### GitHub Copilot Integration
MCP works alongside GitHub Copilot instructions to provide:
- Academic context awareness
- Course-specific suggestions
- Assignment guidance
- Study strategy recommendations

## 💡 Usage Examples

### Check Assignment Status
```javascript
// MCP tool call
get_assignment_tracker({ course: "ITEC-1475" })
```

### Update Assignment Progress
```javascript
// MCP tool call  
update_assignment_status({
  course: "ITEC-1475",
  assignment: "vCenter Lab: Change Hostname", 
  status: "Completed"
})
```

### Get Upcoming Deadlines
```javascript
// MCP tool call
get_due_dates({ days_ahead: 14 })
```

### Create Cornell Notes Template
```javascript
// MCP tool call
organize_notes({
  course: "COMP-1110",
  topic: "Object-Oriented Programming",
  format: "cornell"
})
```

### Generate Study Schedule
```javascript
// MCP tool call
create_study_schedule({
  week_start: "2025-09-22"
})
```

## 🔧 Customization

### Adding New Tools
1. Edit `.mcp/server.js`
2. Add tool definition in `setupToolHandlers()`
3. Implement tool logic
4. Update documentation

### Course-Specific Configuration
Modify `.mcp/agent-config.json` to add:
- New courses
- Assignment types
- Workflow patterns
- Integration settings

### VS Code Integration
Customize `.vscode/settings.json` for:
- File associations
- Editor preferences
- Workspace organization
- Color themes

## 🔒 Security Considerations

- MCP servers run in isolated environments
- File access is limited to repository scope
- No external network access required
- All data stays local to your machine

## 📚 Academic Benefits

### For Students
- **Automated Progress Tracking**: Keep tabs on all assignments
- **Smart Scheduling**: AI-generated study schedules
- **Note Organization**: Structured note-taking templates
- **Due Date Management**: Never miss a deadline

### For Coursework
- **Consistent Structure**: Standardized organization across courses
- **Template Generation**: Quick-start templates for common tasks
- **Collaboration Support**: Tools for group work and discussions
- **Integration**: Works with existing GitHub Copilot setup

## 🆘 Troubleshooting

### MCP Server Won't Start
1. Check Node.js installation: `node --version`
2. Install dependencies: `cd .mcp && npm install`
3. Check for port conflicts
4. Review error logs in terminal

### VS Code Integration Issues
1. Ensure MCP extension is installed
2. Verify `mcp.json` path in VS Code settings
3. Restart VS Code after configuration changes
4. Check VS Code developer console for errors

### Tool Not Working
1. Verify file paths exist
2. Check permissions on directories
3. Ensure assignment tracker files follow expected format
4. Review MCP server logs

## 📖 Resources

- [MCP Specification](https://modelcontextprotocol.io/)
- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [Academic Workflow Best Practices](./README.md)

## 🤝 Contributing

To improve the MCP configuration:
1. Test changes thoroughly
2. Update documentation
3. Follow existing code patterns
4. Consider security implications

---

*This MCP configuration is designed to enhance your Fall 2025 academic experience while maintaining the repository's focus on effective course management and study strategies.*