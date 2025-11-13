param(
  [int]$intervalSec = 10,
  [string]$remote = 'origin',
  [string]$ref = 'HEAD'
)

Write-Host "auto push: watching repo every $intervalSec seconds. press Ctrl+C to stop." -ForegroundColor Cyan

function Get-GitStatusClean {
  $status = git status --porcelain 2>$null
  if ($LASTEXITCODE -ne 0) { return $false }
  return [string]::IsNullOrWhiteSpace($status)
}

while ($true) {
  if (-not (Get-GitStatusClean)) {
    try {
      git add -A | Out-Null
      $ts = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
      git commit -m "auto: $ts" | Out-Null
      git push $remote $ref | Out-Null
      Write-Host "pushed at $ts" -ForegroundColor Green
    } catch {
      Write-Warning "auto push failed: $($_.Exception.Message)"
    }
  }
  Start-Sleep -Seconds $intervalSec
}
