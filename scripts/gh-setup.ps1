<#
.SYNOPSIS
  One-shot helper to configure GitHub CLI auth, ensure SSH key presence, upload it, optionally create a repo, and set remote.

.PARAMETER User
  Your GitHub username (used for remote URL and repo creation).

.PARAMETER Repo
  Repository name (default: current folder name) if creating or fixing remote.

.PARAMETER Visibility
  Repo visibility when creating (public|private). Default private.

.PARAMETER Create
  Switch: create the repo if it does not already exist on GitHub.

.PARAMETER ForceUploadKey
  Switch: re-upload / add the public key even if a matching fingerprint appears to exist.

.PARAMETER KeyTitle
  Title to use for the SSH key in GitHub (default: hostname + '-ed25519').

.PARAMETER DryRun
  Show actions without executing network changes.

.NOTES
  Requires: GitHub CLI (gh), git, OpenSSH client. Run in PowerShell.
#>
param(
  [Parameter(Mandatory=$true)] [string]$User,
  [string]$Repo = (Split-Path -Leaf (Get-Location)),
  [ValidateSet('public','private')] [string]$Visibility = 'private',
  [switch]$Create,
  [switch]$ForceUploadKey,
  [string]$KeyTitle = "$([System.Environment]::MachineName)-ed25519",
  [switch]$DryRun
)

function Step($msg) { Write-Host "==> $msg" -ForegroundColor Cyan }
function Warn($msg) { Write-Warning $msg }
function Info($msg) { Write-Host $msg -ForegroundColor DarkGray }

# 1. Check gh
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Warn "GitHub CLI (gh) not found. Install via: winget install --id GitHub.cli -e"
  return
}

# 2. Auth status
Step "Checking gh auth";
$auth = gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
  Step "Running gh auth login (follow prompts: choose SSH AND HTTPS if offered—SSH is needed for pushes)"
  if (-not $DryRun) { gh auth login } else { Info "[DryRun] gh auth login" }
} else { Info "Already authenticated." }

# 3. Ensure ~/.ssh exists
$sshDir = Join-Path $HOME '.ssh'
if (-not (Test-Path $sshDir)) { New-Item -ItemType Directory -Path $sshDir | Out-Null }

# 4. Ensure ED25519 key
$keyPriv = Join-Path $sshDir 'id_ed25519'
$keyPub  = Join-Path $sshDir 'id_ed25519.pub'
if (-not (Test-Path $keyPriv)) {
  Step "Generating ED25519 key"
  if (-not $DryRun) { ssh-keygen -t ed25519 -C "$User@github" -f $keyPriv -N '' } else { Info "[DryRun] ssh-keygen -t ed25519 ..." }
} else { Info "Key already present: $keyPriv" }

# 5. Start agent & add key
Step "Ensuring ssh-agent running"
try {
  Get-Service ssh-agent -ErrorAction Stop | Set-Service -StartupType Automatic | Out-Null
  Start-Service ssh-agent -ErrorAction SilentlyContinue | Out-Null
} catch { Warn "Unable to start ssh-agent service (may require admin). Proceeding." }
if (-not $DryRun) { ssh-add $keyPriv 2>$null | Out-Null }

# 6. Upload key via gh (only if not already there OR forced)
Step "Checking uploaded SSH keys"
$pubKey = Get-Content $keyPub -Raw
$fingerprint = (ssh-keygen -lf $keyPub).Split()[1]
$keysJson = gh ssh-key list --json title,key | ConvertFrom-Json
$exists = $false
foreach ($k in $keysJson) {
  if ($k.key -eq $pubKey.Trim()) { $exists = $true; break }
}
if ($exists -and -not $ForceUploadKey) {
  Info "SSH key already uploaded (matching content). Skipping." }
else {
  Step "Uploading SSH key as '$KeyTitle'"
  if (-not $DryRun) { $pubKey | gh ssh-key add -t $KeyTitle } else { Info "[DryRun] gh ssh-key add -t $KeyTitle" }
}

# 7. Create repo if requested
$repoFull = "$User/$Repo"
$remoteUrl = "git@github.com:$repoFull.git"
$needCreate = $false
if ($Create) {
  Step "Checking if repo $repoFull exists"
  gh repo view $repoFull 2>$null
  if ($LASTEXITCODE -ne 0) { $needCreate = $true }
  if ($needCreate) {
    Step "Creating repo $repoFull ($Visibility)"
    if (-not $DryRun) { gh repo create $repoFull --$Visibility --disable-wiki --source . --remote origin --push } else { Info "[DryRun] gh repo create $repoFull" }
  } else { Info "Repo already exists." }
}

# 8. Ensure git remote
if (Test-Path .git) {
  $current = git remote get-url origin 2>$null
  if (-not $current) {
    Step "Setting origin to $remoteUrl"
    if (-not $DryRun) { git remote add origin $remoteUrl }
  } elseif ($current -ne $remoteUrl) {
    Step "Updating origin remote"
    if (-not $DryRun) { git remote set-url origin $remoteUrl }
  } else { Info "Remote already correct." }
} else {
  Step "Initializing git repo"
  if (-not $DryRun) { git init; git add .; git commit -m "Initial commit" | Out-Null }
  Step "Adding origin $remoteUrl"
  if (-not $DryRun) { git remote add origin $remoteUrl }
}

# 9. Test push (optional safe check)
Step "Testing push (dry-run style)"
if (-not $DryRun) {
  git fetch origin 2>$null | Out-Null
  git add .github 2>$null
  git commit -m "chore: verify ssh push" 2>$null | Out-Null
  git push -u origin HEAD 2>$null
  if ($LASTEXITCODE -eq 0) { Write-Host "Push OK via SSH" -ForegroundColor Green } else { Warn "Push failed; inspect errors above." }
} else { Info "[DryRun] would commit + push" }

Step "Done"
