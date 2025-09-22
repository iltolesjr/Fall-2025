#!/usr/bin/env node

/**
 * MCP Server Test Script
 * Verifies that the Fall 2025 Academic MCP Server is working correctly
 */

import { spawn } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

console.log('🧪 Testing Fall 2025 MCP Server...\n');

// Test 1: Check if server starts without errors
console.log('Test 1: Server startup...');
const serverProcess = spawn('node', ['server.js'], {
  cwd: __dirname,
  stdio: ['pipe', 'pipe', 'pipe']
});

let serverOutput = '';
let serverError = '';

serverProcess.stdout.on('data', (data) => {
  serverOutput += data.toString();
});

serverProcess.stderr.on('data', (data) => {
  serverError += data.toString();
});

// Give the server time to start
setTimeout(async () => {
  if (serverError.includes('Fall 2025 Academic MCP server running on stdio')) {
    console.log('✅ Server started successfully');
  } else if (serverError) {
    console.log('⚠️  Server started with messages:', serverError.trim());
  } else {
    console.log('⚠️  Server startup status unclear');
  }
  
  // Test 2: Verify configuration files
  console.log('\nTest 2: Configuration files...');
  
  const fs = await import('fs/promises');
  const requiredFiles = [
    'server.js',
    'package.json',
    'agent-config.json',
    'README.md'
  ];
  
  for (const file of requiredFiles) {
    try {
      await fs.access(join(__dirname, file));
      console.log(`✅ ${file} exists`);
    } catch (error) {
      console.log(`❌ ${file} missing`);
    }
  }
  
  // Test 3: Verify repository structure
  console.log('\nTest 3: Repository structure...');
  const repoRoot = join(__dirname, '..');
  const expectedDirs = ['assignments', 'notes', 'schedules', 'discussions'];
  
  for (const dir of expectedDirs) {
    try {
      await fs.access(join(repoRoot, dir));
      console.log(`✅ ${dir}/ directory exists`);
    } catch (error) {
      console.log(`⚠️  ${dir}/ directory missing`);
    }
  }
  
  // Test 4: Check main configuration
  console.log('\nTest 4: Main configuration...');
  try {
    const mcpConfig = await fs.readFile(join(repoRoot, 'mcp.json'), 'utf-8');
    const config = JSON.parse(mcpConfig);
    if (config.mcpServers && config.mcpServers['fall2025-academic']) {
      console.log('✅ MCP configuration valid');
    } else {
      console.log('❌ MCP configuration invalid');
    }
  } catch (error) {
    console.log('❌ MCP configuration file error:', error.message);
  }
  
  console.log('\n🎉 MCP Server test completed!');
  console.log('\nTo use the MCP server:');
  console.log('1. Ensure VS Code has MCP extension installed');
  console.log('2. Open this repository in VS Code');
  console.log('3. The MCP client should automatically connect');
  console.log('4. Ask Copilot academic questions to test integration');
  
  serverProcess.kill();
  process.exit(0);
}, 3000);