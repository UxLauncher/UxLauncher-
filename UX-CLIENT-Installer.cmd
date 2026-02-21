@echo off
title UX-CLIENT Installer
color 0A
echo.
echo   Installing UX-CLIENT...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {$url='https://raw.githubusercontent.com/YOUR_GITHUB/ux-client/main/installer.ps1'; Invoke-Expression (New-Object Net.WebClient).DownloadString($url)}"
