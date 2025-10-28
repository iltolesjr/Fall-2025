<#
Unified runner for ITEC-1475 Labs 3-8 (Hostname, Software Managers, Lennox Server)
Features:
- Interactive and non-interactive (CLI) modes
- DryRun to preview exact ssh commands and remote shell commands
- Optional HostnameMap to supply new hostnames for targets (format: ip:hostname,ip2:hostname2)
- AutoYes switch to bypass prompts (use with care)

Usage examples (DryRun, using the IPs you provided):
  pwsh -File .mcp/run-labs-3-8.ps1 -DryRun -Targets "10.14.75.236,10.14.75.255" -SshUser ubuntu -Choice 4 -HostnameMap "10.14.75.236:itec-deb-01,10.14.75.255:itec-deb-02"

Non-interactive (real run, using key):
  pwsh -File .mcp/run-labs-3-8.ps1 -Targets "10.14.75.236" -SshUser ubuntu -KeyPath "C:\Users\you\.ssh\id_rsa" -Choice 1 -HostnameMap "10.14.75.236:itec-deb-01"

Security:
- This script does not store passwords. If no key is provided, ssh will prompt for password per-host.
- Avoid using -AutoYes without verifying commands first.
#>

param(
  [switch]$DryRun,
  [string]$Targets,
  [string]$SshUser,
  [string]$KeyPath,
  [ValidateSet('1','2','3','4')][string]$Choice,
  [string]$HostnameMap,
  [string]$AdminUser,
  [switch]$AutoYes
)

# --- Helpers -----------------------------------------------------------------
function Require-Command {
  param([string]$Name)
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    Write-Error "Required command '$Name' not available in PATH. Install or add it to PATH and retry."
    exit 2
  }
}

function Invoke-Remote {
  param(
    [string]$Host,
    [string[]]$Commands
  )
  $joined = $Commands -join ' && '
  # Escape double-quotes for passing as single argument to ssh
  $remoteShell = "bash -lc \"$($joined.replace('\"','\\\"'))\""
  $sshArgs = @()
  if ($sshAuthArgs) { $sshArgs += $sshAuthArgs }
  $sshArgs += "-o StrictHostKeyChecking=no"
  $sshArgs += "-o UserKnownHostsFile=/dev/null"
  $sshCommand = "ssh $($sshArgs -join ' ') $sshUser@$Host $remoteShell"

  if ($DryRun) {
    Write-Host "[DRYRUN] Host: $Host" -ForegroundColor Cyan
    Write-Host "[DRYRUN] ssh command:" -ForegroundColor DarkCyan
    Write-Host "  $sshCommand`n"
  } else {
    Write-Host "Running on $Host..." -ForegroundColor Green
    # Use Start-Process to stream output to console
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = 'ssh'
    $psi.Arguments = "$($sshArgs -join ' ') $sshUser@$Host $remoteShell"
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError  = $true
    $psi.UseShellExecute = $false
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $psi
    $p.Start() | Out-Null
    $out = $p.StandardOutput.ReadToEnd()
    $err = $p.StandardError.ReadToEnd()
    $p.WaitForExit()
    Write-Host $out
    if ($err) { Write-Host $err -ForegroundColor Red }
    if ($p.ExitCode -ne 0) { Write-Host "Remote command exited with code $($p.ExitCode)" -ForegroundColor Yellow }
  }
}

# --- Command groups ----------------------------------------------------------
function Get-HostnameLabCommands {
  param([string]$NewHostname)
  return @(
    # show current hostname and /etc/hosts
    'echo "--- before ---"; hostnamectl; cat /etc/hosts || true',
    # set persistent hostname
    "sudo hostnamectl set-hostname $NewHostname",
    # backup and add mapping: attempt to detect the VM's primary IPv4 and map that
    'sudo cp /etc/hosts /etc/hosts.bak || true',
    # find primary IPv4: try hostname -I first, fallback to parsing ip output; final fallback is 127.0.1.1
    'VM_IP=$(hostname -I 2>/dev/null | awk "{print \$1}"); if [ -z "$VM_IP" ]; then VM_IP=$(ip -4 addr show scope global | grep -oP "(?<=inet\s)\d+(?:\.\d+){3}" | head -n1); fi; if [ -z "$VM_IP" ]; then VM_IP=127.0.1.1; fi; echo "$VM_IP $NewHostname" | sudo tee -a /etc/hosts',
    'echo "--- after ---"; hostnamectl; cat /etc/hosts'
  )
}

function Get-SoftwareManagersCommands {
  return @(
    '# start: create workspace',
    'mkdir -p ~/software-managers-lab && cd ~/software-managers-lab',
    '# system updates (non-interactive)',
    'sudo apt-get update -y',
    '# install snap and flatpak and docker (conservative set)',
    'sudo apt-get install -y snapd flatpak apt-transport-https ca-certificates curl gnupg lsb-release',
    '# enable snap (snapd) and add flathub (if flatpak available)',
    'sudo systemctl enable --now snapd.socket || true',
    'sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true',
    '# create a small test artifact',
    'echo "lab test" > testfile.txt; tar -czf software-managers-test.tgz testfile.txt'
  )
}

function Get-LennoxServerCommands {
  param([string]$NewAdminUser)
  $cmds = @(
    '# update & essential tools',
    'sudo apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y',
    'sudo apt-get install -y nginx fail2ban htop ufw'
  )
  # basic firewall
  $cmds += @(
    'sudo ufw allow OpenSSH',
    'sudo ufw allow 80/tcp',
    'sudo ufw --force enable',
    'sudo systemctl enable --now nginx'
  )
  if ($NewAdminUser -and $NewAdminUser.Trim() -ne '') {
    $cmds += @("sudo adduser --disabled-password --gecos \"New Admin,,,\" $NewAdminUser || true",
               "echo '\"$NewAdminUser ALL=(ALL) NOPASSWD:ALL\"' | sudo tee /etc/sudoers.d/$NewAdminUser || true",
               'sudo chmod 0440 /etc/sudoers.d/' + $NewAdminUser)
  }
  return $cmds
}

# --- Sanity checks -----------------------------------------------------------
Require-Command -Name 'ssh'

# --- Normalize inputs -------------------------------------------------------
if ($Targets) {
  $targets = $Targets -split '\s*,\s*' | Where-Object { $_ -ne '' }
} else {
  $targetsRaw = Read-Host "Enter target host(s) (comma-separated IPs/FQDNs) or press Enter to abort"
  if ([string]::IsNullOrWhiteSpace($targetsRaw)) { Write-Host 'No targets provided. Exiting.'; exit 0 }
  $targets = $targetsRaw -split '\s*,\s*' | Where-Object { $_ -ne '' }
}

if (-not $SshUser) {
  $sshUser = Read-Host "SSH username to use on targets (e.g. itec or ubuntu)"
  if ([string]::IsNullOrWhiteSpace($sshUser)) { Write-Host 'No SSH user provided. Exiting.'; exit 0 }
} else { $sshUser = $SshUser }

if ($KeyPath) {
  if (-not (Test-Path $KeyPath)) { Write-Host "Key file not found at $KeyPath"; exit 1 }
  $sshAuthArgs = "-i `"$KeyPath`""
} else {
  if ($PSBoundParameters.ContainsKey('Targets') -and $PSBoundParameters.ContainsKey('SshUser')) {
    Write-Host 'Non-interactive mode: no key provided; ssh will prompt for password when required.'
    $sshAuthArgs = ''
  } else {
    Write-Host "Choose authentication method:`n  1) Private key file (recommended) `n  2) Password (ssh will prompt)"
    $authChoice = Read-Host "Enter 1 or 2"
    if ($authChoice -eq '1') {
      $keyPath = Read-Host "Path to private key file (e.g. C:\Users\you\.ssh\id_rsa)"
      if (-not (Test-Path $keyPath)) { Write-Host "Key file not found at $keyPath"; exit 1 }
      $sshAuthArgs = "-i `"$keyPath`""
    } else { $sshAuthArgs = '' }
  }
}

if (-not $Choice) {
  Write-Host "Which lab would you like to run on the target hosts?`n 1) Hostname  2) Software managers  3) Lennox  4) All"
  $choice = Read-Host "Enter 1,2,3 or 4"
} else { $choice = $Choice }

# build hostname map if provided
$hostnameMapTable = @{}
if ($HostnameMap) {
  foreach ($pair in ($HostnameMap -split '\s*,\s*')) {
    if ($pair -match '^(.*?):(.*)$') { $hostnameMapTable[$matches[1]] = $matches[2] }
  }
}

# --- Main loop --------------------------------------------------------------
foreach ($host in $targets) {
  Write-Host "\n=== Processing $host ===" -ForegroundColor Magenta
  switch ($choice) {
    '1' {
      if ($hostnameMapTable.ContainsKey($host)) { $newHost = $hostnameMapTable[$host] } else { $newHost = Read-Host "New hostname to set on $host (e.g. itec-deb-01)" }
      if ([string]::IsNullOrWhiteSpace($newHost)) { Write-Host 'No hostname entered. Skipping host.'; continue }
      $cmds = Get-HostnameLabCommands -NewHostname $newHost
      Write-Host "About to change hostname on $host to $newHost" -ForegroundColor Yellow
      if (-not $AutoYes.IsPresent) { $ok = Read-Host "Type YES to proceed with hostname change on $host" } else { $ok = 'YES' }
      if ($ok -ne 'YES') { Write-Host 'User aborted hostname change.'; continue }
      Invoke-Remote -Host $host -Commands $cmds
    }
    '2' {
      Write-Host "Running Software Managers steps on $host" -ForegroundColor Yellow
      $cmds = Get-SoftwareManagersCommands
      if (-not $AutoYes.IsPresent) { $ok = Read-Host "Type YES to proceed (will install packages)" } else { $ok = 'YES' }
      if ($ok -ne 'YES') { Write-Host 'User aborted software manager steps.'; continue }
      Invoke-Remote -Host $host -Commands $cmds
    }
    '3' {
      if ($AdminUser) { $adminUserEffective = $AdminUser } else { $adminUserEffective = Read-Host "Optional: new admin username to create on $host (leave blank to skip user creation)" }
      $cmds = Get-LennoxServerCommands -NewAdminUser $adminUserEffective
      Write-Host "Preparing Lennox Server Setup tasks on $host" -ForegroundColor Yellow
      if (-not $AutoYes.IsPresent) { $ok = Read-Host "Type YES to proceed (this will update and may install services)" } else { $ok = 'YES' }
      if ($ok -ne 'YES') { Write-Host 'User aborted Lennox server steps.'; continue }
      Invoke-Remote -Host $host -Commands $cmds
    }
    '4' {
      # Hostname step
      if ($hostnameMapTable.ContainsKey($host)) { $newHost = $hostnameMapTable[$host] } else { $newHost = Read-Host "New hostname to set on $host (for Hostname lab)" }
      if (-not [string]::IsNullOrWhiteSpace($newHost)) {
        $cmds = Get-HostnameLabCommands -NewHostname $newHost
        Write-Host "Hostname step: will set $newHost on $host" -ForegroundColor Yellow
        if (-not $AutoYes.IsPresent) { $ok = Read-Host "Type YES to run hostname step" } else { $ok = 'YES' }
        if ($ok -eq 'YES') { Invoke-Remote -Host $host -Commands $cmds } else { Write-Host 'Skipped hostname step.' }
      } else { Write-Host 'No hostname given; skipping hostname step.' }

      # Software managers step
      if (-not $AutoYes.IsPresent) { $ok2 = Read-Host "Type YES to run software managers step (will install packages)" } else { $ok2 = 'YES' }
      if ($ok2 -eq 'YES') { Invoke-Remote -Host $host -Commands (Get-SoftwareManagersCommands) } else { Write-Host 'Skipped software managers step.' }

      # Lennox setup
      if ($AdminUser) { $adminUser = $AdminUser } else { $adminUser = Read-Host "Optional: new admin username to create on $host (leave blank to skip user creation)" }
      if (-not $AutoYes.IsPresent) { $ok3 = Read-Host "Type YES to run Lennox server setup" } else { $ok3 = 'YES' }
      if ($ok3 -eq 'YES') { Invoke-Remote -Host $host -Commands (Get-LennoxServerCommands -NewAdminUser $adminUser) } else { Write-Host 'Skipped Lennox server setup.' }
    }
    default { Write-Host "Unknown choice: $choice" -ForegroundColor Red }
  }
}

Write-Host "\nAll done. If you used -DryRun, review the previewed ssh commands carefully before running for real." -ForegroundColor Cyan
