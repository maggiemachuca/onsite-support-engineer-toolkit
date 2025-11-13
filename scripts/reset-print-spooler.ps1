# Reset Print Spooler Service
# Purpose: Resolves stuck print queues, printer offline issues, and spooler errors.

Write-Host "Stopping Print Spooler..." -ForegroundColor Cyan
Stop-Service -Name Spooler -Force

$spoolPath = "C:\Windows\System32\spool\PRINTERS"

if (Test-Path $spoolPath) {
    Write-Host "Clearing spool folder..." -ForegroundColor Yellow
    Remove-Item "$spoolPath\*" -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "Starting Print Spooler..." -ForegroundColor Green
Start-Service -Name Spooler

Write-Host "Print Spooler successfully reset." -ForegroundColor Green
