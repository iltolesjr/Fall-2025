#!/usr/bin/env node

/**
 * Fall 2025 Academic MCP Server
 * 
 * This MCP server provides academic workflow management tools specifically
 * designed for the Fall 2025 course repository structure.
 */

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import fs from 'fs/promises';
import path from 'path';

class Fall2025AcademicServer {
  constructor() {
    this.server = new Server(
      {
        name: 'fall2025-academic',
        version: '0.1.0',
      },
      {
        capabilities: {
          tools: {},
        },
      }
    );

    this.setupToolHandlers();
    this.setupErrorHandling();
  }

  setupErrorHandling() {
    this.server.onerror = (error) => console.error('[MCP Error]', error);
    process.on('SIGINT', async () => {
      await this.server.close();
      process.exit(0);
    });
  }

  setupToolHandlers() {
    this.server.setRequestHandler(ListToolsRequestSchema, async () => ({
      tools: [
        {
          name: 'get_assignment_tracker',
          description: 'Get assignment tracking information for a specific course',
          inputSchema: {
            type: 'object',
            properties: {
              course: {
                type: 'string',
                description: 'Course identifier (e.g., ITEC-1475, COMP-1110)',
              },
            },
            required: ['course'],
          },
        },
        {
          name: 'update_assignment_status',
          description: 'Update the status of an assignment',
          inputSchema: {
            type: 'object',
            properties: {
              course: {
                type: 'string',
                description: 'Course identifier',
              },
              assignment: {
                type: 'string',
                description: 'Assignment name',
              },
              status: {
                type: 'string',
                enum: ['Not Started', 'In Progress', 'Completed'],
                description: 'New status for the assignment',
              },
            },
            required: ['course', 'assignment', 'status'],
          },
        },
        {
          name: 'get_due_dates',
          description: 'Get upcoming due dates across all courses',
          inputSchema: {
            type: 'object',
            properties: {
              days_ahead: {
                type: 'number',
                description: 'Number of days to look ahead (default: 7)',
                default: 7,
              },
            },
          },
        },
        {
          name: 'create_study_schedule',
          description: 'Create a study schedule for upcoming assignments and exams',
          inputSchema: {
            type: 'object',
            properties: {
              course: {
                type: 'string',
                description: 'Course identifier (optional, for course-specific schedule)',
              },
              week_start: {
                type: 'string',
                description: 'Start date for the schedule (YYYY-MM-DD format)',
              },
            },
            required: ['week_start'],
          },
        },
        {
          name: 'organize_notes',
          description: 'Help organize and structure course notes',
          inputSchema: {
            type: 'object',
            properties: {
              course: {
                type: 'string',
                description: 'Course identifier',
              },
              topic: {
                type: 'string',
                description: 'Topic or week identifier',
              },
              format: {
                type: 'string',
                enum: ['cornell', 'outline', 'mindmap', 'summary'],
                description: 'Note format type',
              },
            },
            required: ['course', 'format'],
          },
        },
      ],
    }));

    this.server.setRequestHandler(CallToolRequestSchema, async (request) => {
      switch (request.params.name) {
        case 'get_assignment_tracker':
          return this.getAssignmentTracker(request.params.arguments);
        case 'update_assignment_status':
          return this.updateAssignmentStatus(request.params.arguments);
        case 'get_due_dates':
          return this.getDueDates(request.params.arguments);
        case 'create_study_schedule':
          return this.createStudySchedule(request.params.arguments);
        case 'organize_notes':
          return this.organizeNotes(request.params.arguments);
        default:
          throw new Error(`Unknown tool: ${request.params.name}`);
      }
    });
  }

  async getAssignmentTracker(args) {
    try {
      const trackerPath = path.join(process.cwd(), 'assignments', `${args.course}-tracker.md`);
      const content = await fs.readFile(trackerPath, 'utf-8');
      
      return {
        content: [
          {
            type: 'text',
            text: `Assignment tracker for ${args.course}:\n\n${content}`,
          },
        ],
      };
    } catch (error) {
      return {
        content: [
          {
            type: 'text',
            text: `Could not find assignment tracker for ${args.course}. Error: ${error.message}`,
          },
        ],
        isError: true,
      };
    }
  }

  async updateAssignmentStatus(args) {
    try {
      const trackerPath = path.join(process.cwd(), 'assignments', `${args.course}-tracker.md`);
      let content = await fs.readFile(trackerPath, 'utf-8');
      
      // Simple status update - in a real implementation, this would be more robust
      const assignmentRegex = new RegExp(`(\\|\\s*${args.assignment}\\s*\\|[^|]*\\|)\\s*([^|]+)(\\|)`, 'i');
      content = content.replace(assignmentRegex, `$1 ${args.status} $3`);
      
      await fs.writeFile(trackerPath, content);
      
      return {
        content: [
          {
            type: 'text',
            text: `Updated ${args.assignment} status to "${args.status}" in ${args.course}`,
          },
        ],
      };
    } catch (error) {
      return {
        content: [
          {
            type: 'text',
            text: `Failed to update assignment status: ${error.message}`,
          },
        ],
        isError: true,
      };
    }
  }

  async getDueDates(args) {
    const daysAhead = args.days_ahead || 7;
    const today = new Date();
    const futureDate = new Date(today);
    futureDate.setDate(today.getDate() + daysAhead);

    try {
      // Scan assignment trackers for due dates
      const assignmentsDir = path.join(process.cwd(), 'assignments');
      const files = await fs.readdir(assignmentsDir);
      const trackers = files.filter(f => f.endsWith('-tracker.md'));
      
      let dueDates = [];
      
      for (const tracker of trackers) {
        const content = await fs.readFile(path.join(assignmentsDir, tracker), 'utf-8');
        const course = tracker.replace('-tracker.md', '');
        
        // Simple due date extraction - could be enhanced with proper parsing
        const lines = content.split('\n');
        for (const line of lines) {
          if (line.includes('|') && line.includes('TBD') === false) {
            const match = line.match(/\|\s*([^|]+)\s*\|\s*([^|]+)\s*\|/);
            if (match) {
              dueDates.push({
                course,
                assignment: match[1].trim(),
                dueDate: match[2].trim(),
              });
            }
          }
        }
      }
      
      return {
        content: [
          {
            type: 'text',
            text: `Upcoming due dates (next ${daysAhead} days):\n\n${dueDates.map(d => 
              `• ${d.course}: ${d.assignment} - ${d.dueDate}`
            ).join('\n') || 'No specific due dates found in trackers.'}`,
          },
        ],
      };
    } catch (error) {
      return {
        content: [
          {
            type: 'text',
            text: `Error retrieving due dates: ${error.message}`,
          },
        ],
        isError: true,
      };
    }
  }

  async createStudySchedule(args) {
    const weekStart = new Date(args.week_start);
    const schedule = [];
    
    // Generate a basic weekly study schedule template
    for (let i = 0; i < 7; i++) {
      const day = new Date(weekStart);
      day.setDate(weekStart.getDate() + i);
      const dayName = day.toLocaleDateString('en-US', { weekday: 'long' });
      
      schedule.push(`**${dayName} (${day.toLocaleDateString()})**`);
      schedule.push('- Morning: Review previous day\'s notes (30 min)');
      schedule.push('- Afternoon: Work on assignments (1-2 hours)');
      schedule.push('- Evening: Prepare for next day\'s classes (30 min)');
      schedule.push('');
    }
    
    return {
      content: [
        {
          type: 'text',
          text: `Study Schedule for week starting ${args.week_start}:\n\n${schedule.join('\n')}`,
        },
      ],
    };
  }

  async organizeNotes(args) {
    const templates = {
      cornell: `# Cornell Notes Template - ${args.course}${args.topic ? ` - ${args.topic}` : ''}

## Cue Column | Notes Column
### Questions and Keywords | Main Notes and Details

---

### Summary Section
Key takeaways and main concepts:

`,
      outline: `# Outline Notes - ${args.course}${args.topic ? ` - ${args.topic}` : ''}

## I. Main Topic
   A. Subtopic 1
      1. Detail
      2. Detail
   B. Subtopic 2
      1. Detail
      2. Detail

## II. Secondary Topic
   A. Subtopic 1
   B. Subtopic 2

`,
      mindmap: `# Mind Map Structure - ${args.course}${args.topic ? ` - ${args.topic}` : ''}

## Central Concept: [Main Topic]

### Branch 1: [Subtopic]
- Detail 1
- Detail 2
- Connection to other concepts

### Branch 2: [Subtopic]
- Detail 1
- Detail 2
- Related examples

### Branch 3: [Subtopic]
- Detail 1
- Detail 2
- Practical applications

`,
      summary: `# Summary Notes - ${args.course}${args.topic ? ` - ${args.topic}` : ''}

## Key Concepts
1. **Concept 1**: Brief explanation
2. **Concept 2**: Brief explanation
3. **Concept 3**: Brief explanation

## Important Details
- Detail 1
- Detail 2
- Detail 3

## Review Questions
1. Question 1
2. Question 2
3. Question 3

## Action Items
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

`
    };

    return {
      content: [
        {
          type: 'text',
          text: templates[args.format] || 'Unknown note format requested.',
        },
      ],
    };
  }

  async run() {
    const transport = new StdioServerTransport();
    await this.server.connect(transport);
    console.error('Fall 2025 Academic MCP server running on stdio');
  }
}

const server = new Fall2025AcademicServer();
server.run().catch(console.error);