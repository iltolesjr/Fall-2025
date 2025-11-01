# creates two ubuntu vms with multipass: lab-srv (server) and lab-cli (client)
# requires: admin pwsh, windows 10/11, virtualization enabled

$ErrorActionPreference = 'Stop'

function Ensure-Winget {
  try { winget --version | Out-Null } catch { throw 'winget not found. install winget (app installer) from microsoft store and rerun.' }
}

function Ensure-Multipass {
  try { multipass version | Out-Null; return }
  catch {
    Write-Host 'Installing Multipass via winget...'
    winget install --id Canonical.Multipass -e --accept-package-agreements --accept-source-agreements
  }
}

function Launch-VM($name, $cpus, $mem, $disk, $cloudInitPath) {
  if ((multipass list --format csv) -match "^$name,") {
    Write-Host "$name already exists. skipping launch."
  } else {
    multipass launch 22.04 --name $name --cpus $cpus --mem $mem --disk $disk --cloud-init $cloudInitPath
  }
}

Push-Location (Resolve-Path "$PSScriptRoot\..\..")
try {
  Ensure-Winget
  Ensure-Multipass

  $srvCI = "scripts/multipass/lab-server-cloud-init.yaml"
  $cliCI = "scripts/multipass/lab-client-cloud-init.yaml"

  if (-not (Test-Path $srvCI) -or -not (Test-Path $cliCI)) { throw 'cloud-init files not found.' }

  Write-Host 'Launching lab-srv...'
  Launch-VM -name 'lab-srv' -cpus 2 -mem '3G' -disk '15G' -cloudInitPath $srvCI

  Write-Host 'Launching lab-cli...'
  Launch-VM -name 'lab-cli' -cpus 2 -mem '2G' -disk '10G' -cloudInitPath $cliCI

  Start-Sleep -Seconds 5

  Write-Host "\nVM info:" -ForegroundColor Cyan
  multipass info lab-srv
  multipass info lab-cli

  Write-Host "\nConnect commands:" -ForegroundColor Cyan
  Write-Host 'multipass shell lab-srv'
  Write-Host 'multipass shell lab-cli'
}
finally {
  Pop-Location
}
