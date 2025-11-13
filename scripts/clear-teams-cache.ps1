# Clear Microsoft Teams Cache
# Purpose: Fixes login issues, loading problems, and broken UI by resetting the Teams cache.
# Usage: Run locally or via RMM to resolve Teams performance issues.

Write-Host "Stopping Microsoft Teams..." -ForegroundColor Cyan
Get-Process Teams -ErrorAction SilentlyContinue | Stop-Process -Force

$paths = @(
    "$env:APPDATA\Microsoft\Teams",
    "$env:LOCALAPPDATA\Microsoft\Teams",
    "$env:LOCALAPPDATA\Microsoft\TeamsMeetingAddin",
    "$env:LOCALAPPDATA\Microsoft\TeamsPresenceAddin"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Write-Host "Clearing cache folder: $path" -ForegroundColor Yellow
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Cache cleared. Restarting Teams..." -ForegroundColor Green
Start-Process "C:\Users\$env:USERNAME\AppData\Local\Microsoft\Teams\Update.exe" "--processStart Teams.exe"
