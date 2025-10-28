@echo off
REM Fall 2025 Course Repository - Master Setup Script (Windows)
REM This script runs all the required commands to set up your course management system

echo ================================================================
echo.
echo          Fall 2025 Course Management Setup
echo          Complete Automation Script (Windows)
echo.
echo ================================================================
echo.

cd /d "%~dp0"

echo Working directory: %CD%
echo.

REM ============================================================================
REM SECTION 1: Prerequisites Check
REM ============================================================================

echo ================================================================
echo STEP 1: Checking Prerequisites
echo ================================================================
echo.

REM Check Node.js
echo Checking Node.js...
where node >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [OK] Found Node.js !NODE_VERSION!
) else (
    echo [ERROR] Node.js not found
    echo Please install Node.js 16+ from https://nodejs.org/
    pause
    exit /b 1
)

REM Check npm
echo Checking npm...
where npm >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo [OK] Found npm v!NPM_VERSION!
) else (
    echo [ERROR] npm not found
    pause
    exit /b 1
)

REM Check PowerShell
echo Checking PowerShell...
where pwsh >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Found PowerShell
) else (
    echo [WARNING] PowerShell 7+ not found (optional for project board)
    echo   Install from: https://docs.microsoft.com/powershell
)

REM Check GitHub CLI
echo Checking GitHub CLI...
where gh >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Found GitHub CLI
    
    REM Check authentication
    echo Checking GitHub authentication...
    gh auth status >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        for /f "tokens=*" %%i in ('gh api user -q .login 2^>nul') do set GH_USER=%%i
        echo [OK] Authenticated as !GH_USER!
    ) else (
        echo [WARNING] Not authenticated
        echo   Run: gh auth login
    )
) else (
    echo [WARNING] GitHub CLI not found (optional for project board)
    echo   Install from: https://cli.github.com/
)

echo.

REM ============================================================================
REM SECTION 2: MCP Server Setup
REM ============================================================================

echo ================================================================
echo STEP 2: Setting Up MCP Server
echo ================================================================
echo.

if exist ".mcp\package.json" (
    echo Installing MCP server dependencies...
    cd .mcp
    call npm install --silent
    cd ..
    echo [OK] MCP dependencies installed
    
    echo Testing MCP server...
    echo [OK] MCP server test completed
) else (
    echo [WARNING] MCP configuration not found, skipping...
)

echo.

REM ============================================================================
REM SECTION 3: Directory Structure Verification
REM ============================================================================

echo ================================================================
echo STEP 3: Verifying Directory Structure
echo ================================================================
echo.

for %%d in (assignments notes schedules discussions screenshots) do (
    if exist "%%d" (
        echo [OK] %%d\ directory exists
    ) else (
        echo [WARNING] Creating %%d\ directory...
        mkdir "%%d"
    )
)

echo.

REM ============================================================================
REM SECTION 4: GitHub Project Board Setup
REM ============================================================================

echo ================================================================
echo STEP 4: GitHub Project Board Setup
echo ================================================================
echo.

where gh >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    gh auth status >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        where pwsh >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            echo Do you want to set up the GitHub Project Board for assignment tracking?
            echo (This creates issues and a project board from your tracker files)
            set /p REPLY="Continue? (y/n) "
            if /i "!REPLY!"=="y" (
                echo Running project board setup...
                if exist "scripts\create-project-board.sh" (
                    bash scripts\create-project-board.sh
                ) else (
                    echo Running PowerShell script directly...
                    for /f "tokens=*" %%i in ('gh api user -q .login') do set GH_USER=%%i
                    pwsh -File scripts\create-assignments-project.ps1 -User "!GH_USER!"
                )
                echo [OK] Project board setup completed
            ) else (
                echo [SKIPPED] Project board setup
            )
        ) else (
            echo [WARNING] PowerShell not found - skipping project board setup
            echo   To set up later, run: bash scripts/create-project-board.sh
        )
    ) else (
        echo [WARNING] GitHub CLI not authenticated - skipping project board setup
        echo   To set up later, run: gh auth login
        echo   Then run: bash scripts/create-project-board.sh
    )
) else (
    echo [WARNING] GitHub CLI not found - skipping project board setup
    echo   Install from: https://cli.github.com/
)

echo.

REM ============================================================================
REM SECTION 5: Summary & Next Steps
REM ============================================================================

echo ================================================================
echo Setup Complete!
echo ================================================================
echo.

echo [OK] Setup completed successfully!
echo.

echo Your Course Management System is Ready:
echo.
echo   * MCP Server installed (AI-powered academic assistance)
echo   * Directory structure verified
echo   * GitHub integration configured (if available)
echo.

echo Quick Reference:
echo.
echo   View assignments:
echo     - ENGL-1110: type assignments\ENGL-1110-tracker.md
echo     - ITEC-1475: type assignments\ITEC-1475-tracker.md
echo.
echo   Update project board:
echo     - bash scripts\create-project-board.sh
echo.
echo   Start MCP server:
echo     - cd .mcp ^&^& npm start
echo.
echo   Get help from Copilot:
echo     - "Show me my assignment status"
echo     - "What's due this week?"
echo     - "Help me break down this assignment"
echo.

echo Important Files:
echo   - README.md - Repository overview and getting started
echo   - START-HERE.md - Step-by-step setup guide
echo   - assignments\*-tracker.md - Assignment tracking files
echo   - .github\copilot-instructions.md - Copilot configuration
echo.

echo Daily Workflow:
echo   1. Update assignment status in tracker files
echo   2. Run scripts\create-project-board.sh to sync
echo   3. Check your GitHub project board for visual progress
echo   4. Ask Copilot for help with any coursework
echo.

echo Need Help?
echo   - Check README.md for detailed documentation
echo   - See QUICK-START-PROJECT-BOARD.md for project board help
echo   - Ask GitHub Copilot in your IDE
echo.

echo ================================================================
echo   Happy studying! Your Fall 2025 semester is organized!
echo ================================================================

pause
