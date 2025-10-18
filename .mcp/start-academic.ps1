Param(
  [int]$Port = 8086,
  [string]$ServerHost = 'prodesk86',
  [string]$Role = 'school',
  [string]$RepoPath = '.',
  [switch]$Open
)

# Set environment variables for this session only
$env:PRODESK_PORT = $Port
$env:PRODESK_HOST = $ServerHost
$env:REPO_ROLE    = $Role
$env:REPO_PATH    = $RepoPath
$env:ACADEMIC_MODE = 'true'

Write-Host "[academic] Launching server on http://${ServerHost}:$Port role=$Role root=$RepoPath" -ForegroundColor Cyan

# Resolve script directory in case run elsewhere
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$server = Join-Path (Split-Path -Parent $scriptDir) 'server.js'

if (-not (Test-Path $server)) {
  Write-Error "Cannot find server.js at $server"
  exit 1
}

# Start the server
node $server

if ($LASTEXITCODE -ne 0) {
  Write-Warning "Server exited with code $LASTEXITCODE"
} elseif ($Open) {
  Start-Process "http://${ServerHost}:$Port/api/ping"
}
