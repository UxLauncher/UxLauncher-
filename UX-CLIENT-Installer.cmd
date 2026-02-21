@echo off
title UX-CLIENT Installer
color 0A
echo.
echo   ██╗   ██╗██╗  ██╗      ██████╗██╗     ██╗███████╗███╗   ██╗████████╗
echo   ██║   ██║╚██╗██╔╝     ██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝
echo   ██║   ██║ ╚███╔╝      ██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║
echo   ╚██████╔╝██╔╝ ██╗     ╚██████╗███████╗██║███████╗██║ ╚████║   ██║
echo    ╚═════╝ ╚═╝  ╚═╝      ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝
echo.
echo   Industrial Engine v4.0 - Installer
echo   ─────────────────────────────────────────────
echo.
echo   Downloading and installing UX-CLIENT...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Invoke-Expression (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/UxLauncher/UxLauncher-/main/installer.ps1')}"
