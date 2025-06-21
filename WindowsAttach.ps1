$userProfilePath = [System.Environment]::GetFolderPath('UserProfile')
$shortcutPath = Join-Path -Path $userProfilePath -ChildPath "Dev Container.lnk"

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)

$shortcut.TargetPath = "wt.exe"
$shortcut.Arguments = "docker exec -it nm-toolbox zsh"
$shortcut.Description = "Launches a zsh shell in the nm-toolbox container."
$shortcut.IconLocation = "C:\Windows\System32\imageres.dll, 2"
$shortcut.Save()

Write-Host "Success! Shortcut 'Dev Container.lnk' has been created in your user directory ($userProfilePath)."
Write-Host "You can now find it there, right-click it, and choose 'Pin to taskbar'."
