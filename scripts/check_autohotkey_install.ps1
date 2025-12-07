<#
.SYNOPSIS
Checks whether AutoHotkey (v1) is installed and available on PATH.
#>
$ahk = Get-Command AutoHotkey.exe -ErrorAction SilentlyContinue

if ($ahk) {
    Write-Host "AutoHotkey appears to be installed." -ForegroundColor Green
    Write-Host "Path: $($ahk.Source)" -ForegroundColor DarkGray
    exit 0
}
else {
    Write-Warning "AutoHotkey.exe was not found on PATH. Install AutoHotkey v1 from https://www.autohotkey.com/ before running clipboard_collector.ahk."
    exit 1
}
