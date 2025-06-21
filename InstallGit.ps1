<#
.SYNOPSIS
    Installs Git on Windows using the winget package manager.

.DESCRIPTION
    This script checks if Git is already installed and available in the system's PATH.
    If Git is not found, it uses the winget command-line tool to find and install the official Git package.
    The script requires PowerShell 5.1 or later and for the winget tool to be available.

.NOTES
    Author: Gemini
    Version: 1.0
    Run this script with administrator privileges for best results.
#>

# Function to check if a command exists
function Test-CommandExists {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Command
    )
    $CommandPath = Get-Command $Command -ErrorAction SilentlyContinue
    return [bool]$CommandPath
}

# Check if Git is already installed
Write-Host "Checking if Git is already installed..."
if (Test-CommandExists -Command "git") {
    Write-Host "Git is already installed. Version details:" -ForegroundColor Green
    git --version
    exit
} else {
    Write-Host "Git is not found. Proceeding with installation." -ForegroundColor Yellow
}

# Check if winget is available
if (-not (Test-CommandExists -Command "winget")) {
    Write-Host "Error: winget command-line tool is not available on this system." -ForegroundColor Red
    Write-Host "Please install the 'App Installer' from the Microsoft Store to use winget." -ForegroundColor Red
    exit 1
}

# Install Git using winget
try {
    Write-Host "Starting the installation of Git via winget..."
    winget install --id Git.Git -e --source winget

    # Verify installation
    Write-Host "Verifying installation..."
    if (Test-CommandExists -Command "git") {
        Write-Host "Git has been successfully installed." -ForegroundColor Green
        git --version
    } else {
        Write-Host "Installation might have completed, but 'git' is not in the PATH." -ForegroundColor Yellow
        Write-Host "Please restart your PowerShell session to access the 'git' command." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "An error occurred during the installation of Git." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
