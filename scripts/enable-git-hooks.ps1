# enables repo-local git hooks so .githooks/post-commit auto-push runs
param(
    [switch]$Global
)

$ErrorActionPreference = 'Stop'

# ensure we are in a git repo
try {
    git rev-parse --is-inside-work-tree | Out-Null
} catch {
    Write-Error 'not in a git repository. cd to the repo root and run again.'
    exit 1
}

if ($Global) {
    git config --global core.hooksPath "$PWD/.githooks"
    Write-Host "set global core.hooksPath to $PWD/.githooks"
} else {
    git config core.hooksPath .githooks
    Write-Host 'set core.hooksPath to .githooks for this repo'
}

# show current hooksPath
$hooks = git config --get core.hooksPath
Write-Host "core.hooksPath = $hooks"

# list hook file
if (Test-Path .githooks\post-commit) {
    Write-Host 'post-commit hook found:'
    Get-Content .githooks\post-commit | Select-Object -First 10 | ForEach-Object {"  $_"}
} else {
    Write-Warning 'no .githooks/post-commit found in repo.'
}
