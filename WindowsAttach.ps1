$scriptDir = $PSScriptRoot
$iconPath = Join-Path -Path $scriptDir -ChildPath "icon.ico"

if (-not (Test-Path $iconPath)) {
    Write-Host "Warning: 'icon.ico' not found. Using default icon." -ForegroundColor Yellow
    $iconPath = "wt.exe"
}

$userProfilePath = [System.Environment]::GetFolderPath('UserProfile')
$shortcutPath = Join-Path -Path $userProfilePath -ChildPath "nm-toolbox.lnk"

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)

$shortcut.TargetPath = "wt.exe"
$shortcut.Arguments = "docker exec -it nm-toolbox zsh"
$shortcut.Description = "Launches a zsh shell in the nm-toolbox container."
$shortcut.IconLocation = $iconPath
$shortcut.Save()

Write-Host "Success! Shortcut 'nm-toolbox.lnk' has been created in your user directory ($userProfilePath)."
Write-Host "You can now find it there, right-click it, and choose 'Pin to taskbar'."
