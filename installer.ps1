# UX-CLIENT Installer - PowerShell
$ErrorActionPreference = "Stop"

$INSTALL_DIR = "$env:LOCALAPPDATA\UX-CLIENT"
$JAVA_URL = "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jre_x64_windows_hotspot_21.0.5_11.zip"
$LAUNCHER_URL = "https://github.com/UxuiderGrosse/ux-client/releases/latest/download/UX-CLIENT.jar"

Write-Host ""
Write-Host "  ██╗   ██╗██╗  ██╗      ██████╗██╗     ██╗███████╗███╗   ██╗████████╗" -ForegroundColor Green
Write-Host "  ██║   ██║╚██╗██╔╝     ██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝" -ForegroundColor Green
Write-Host "  ██║   ██║ ╚███╔╝      ██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║   " -ForegroundColor Green
Write-Host "  ██║   ██║ ██╔██╗      ██║     ██║     ██║██╔══╝  ██║╚██╗██║   ██║   " -ForegroundColor Green
Write-Host "  ╚██████╔╝██╔╝ ██╗     ╚██████╗███████╗██║███████╗██║ ╚████║   ██║   " -ForegroundColor Green
Write-Host "   ╚═════╝ ╚═╝  ╚═╝      ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   " -ForegroundColor Green
Write-Host ""
Write-Host "  Industrial Engine v4.0 - Installer" -ForegroundColor DarkGreen
Write-Host "  ─────────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""

# Step 1: Create install directory
Write-Host "  [1/4] Creating install directory..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $INSTALL_DIR | Out-Null
New-Item -ItemType Directory -Force -Path "$INSTALL_DIR\java" | Out-Null
Write-Host "        $INSTALL_DIR" -ForegroundColor DarkGray

# Step 2: Download Java 21 JRE
Write-Host "  [2/4] Downloading Java 21 JRE..." -ForegroundColor Cyan
$javaZip = "$INSTALL_DIR\java.zip"
try {
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($JAVA_URL, $javaZip)
    Write-Host "        Extracting Java..." -ForegroundColor DarkGray
    Expand-Archive -Path $javaZip -DestinationPath "$INSTALL_DIR\java" -Force
    Remove-Item $javaZip
    # Find java.exe in extracted folder
    $javaExe = Get-ChildItem -Path "$INSTALL_DIR\java" -Recurse -Name "java.exe" | Select-Object -First 1
    $JAVA_PATH = "$INSTALL_DIR\java\$javaExe"
    Write-Host "        Java installed: $JAVA_PATH" -ForegroundColor DarkGray
} catch {
    Write-Host "        Java download failed - checking system Java..." -ForegroundColor Yellow
    $JAVA_PATH = "java"
}

# Step 3: Download UX-CLIENT.jar
Write-Host "  [3/4] Downloading UX-CLIENT launcher..." -ForegroundColor Cyan
$jarPath = "$INSTALL_DIR\UX-CLIENT.jar"
try {
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($LAUNCHER_URL, $jarPath)
    Write-Host "        Launcher downloaded!" -ForegroundColor DarkGray
} catch {
    Write-Host "        Could not download launcher from GitHub." -ForegroundColor Red
    Write-Host "        Please place UX-CLIENT.jar in: $INSTALL_DIR" -ForegroundColor Yellow
}

# Step 4: Create desktop shortcut + start menu
Write-Host "  [4/4] Creating shortcuts..." -ForegroundColor Cyan

# Create launcher .bat
$batContent = "@echo off`r`ntitle UX-CLIENT`r`n`"$JAVA_PATH`" -jar `"$INSTALL_DIR\UX-CLIENT.jar`"`r`n"
Set-Content -Path "$INSTALL_DIR\UX-CLIENT.bat" -Value $batContent

# Desktop shortcut (using WScript)
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\UX-CLIENT.lnk")
$shortcut.TargetPath = "$INSTALL_DIR\UX-CLIENT.bat"
$shortcut.WorkingDirectory = $INSTALL_DIR
$shortcut.WindowStyle = 7  # minimized (hides cmd flash)
$shortcut.Description = "UX-CLIENT | Industrial Engine"
$shortcut.Save()

# Start menu shortcut
$startMenu = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\UX-CLIENT.lnk"
$shortcut2 = $WshShell.CreateShortcut($startMenu)
$shortcut2.TargetPath = "$INSTALL_DIR\UX-CLIENT.bat"
$shortcut2.WorkingDirectory = $INSTALL_DIR
$shortcut2.WindowStyle = 7
$shortcut2.Save()

Write-Host "        Desktop shortcut created!" -ForegroundColor DarkGray
Write-Host "        Start Menu entry created!" -ForegroundColor DarkGray

Write-Host ""
Write-Host "  ─────────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "  UX-CLIENT is now installed. Launch from:" -ForegroundColor White
Write-Host "   - Desktop shortcut" -ForegroundColor Green
Write-Host "   - Start Menu > UX-CLIENT" -ForegroundColor Green
Write-Host ""
Write-Host "  Launching now..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
Start-Process -FilePath "$INSTALL_DIR\UX-CLIENT.bat"
