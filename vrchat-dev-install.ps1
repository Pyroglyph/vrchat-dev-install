# VRChat Development Environment Installer

# If you're seeing this and you're not sure why, you might have missed the instructions.
# Here they are: https://www.github.com/Pyroglyph/vrc-dev-install

param
(
    # When this flag is set, we have already tried (and failed) to get admin rights.
    [switch] $notAdmin
)

# The self-elevator will relaunch the script with the notAdmin flag if it fails to gain admin rights.
If ($notAdmin)
{
    Write-Error "Error: Failed to acquire administrator rights.`n`nYou must be logged in as an administrator to install the VRChat Development Environment!`n"
}

# This bit self-elevates the script because we need admin access to install things.
If (-NOT ([Security.Principal.WindowsPrincipal]`
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Script launched without admin rights. Attempting to self-elevate..."
    $arguments = "& '" + $MyInvocation.MyCommand.Definition + " -notAdmin'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}
Else
{
    # We have the right permissions: full speed ahead!


    # Install Chocolatey (if it isn't already)
    If (-NOT (Get-Command choco -errorAction SilentlyContinue))
    {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))
    }


    # Install Blender
    Write-Output "`n======================`n= Installing Blender =`n======================`n"
    choco install -y blender


    # Install Unity
    # (I would have used Chocolatey again but they don't have the right version of Unity)
    Write-Output "`n======================`n=  Installing Unity  =`n======================`n"
    Write-Output "Downloading... (this might take a while)"
    (New-Object System.Net.WebClient).DownloadFile("https://beta.unity3d.com/download/9c92e827232b/Windows64EditorInstaller/UnitySetup64-5.6.3p1.exe", "$env:TEMP/UnitySetup64-5.6.3p1.exe")
    Write-Output "Installing..."
    & "$env:TEMP/UnitySetup64-5.6.3p1.exe" /S


    # Download and install the latest VRCSDK
    # (most of this is just testing for and removing old files)
    Write-Output "`n======================`n= Downloading VRCSDK =`n======================`n"
    $UnityProjectsPath = [Environment]::GetFolderPath("MyDocuments") + "/Unity Projects"

    If (Test-Path -Path "$env:TEMP/VRCSDK.unityPackage")
    {
        Remove-Item -Path "$env:TEMP/VRCSDK.unityPackage"
    }
    
    Write-Output "Downloading..."
    (New-Object System.Net.WebClient).DownloadFile("https://www.vrchat.net/download/sdk", "$env:TEMP/VRCSDK.unityPackage")

    If (-NOT (Test-Path -Path $UnityProjectsPath))
    {
        New-Item -Path $UnityProjectsPath -ItemType Directory
    }

    If (Test-Path -Path "$UnityProjectsPath/VRCSDK.unityPackage")
    {
        Remove-Item -Path "$UnityProjectsPath/VRCSDK.unityPackage"
    }

    Move-Item -Path "$env:TEMP/VRCSDK.unityPackage" -Destination "$UnityProjectsPath/VRCSDK.unityPackage"


    # We're done!
    Write-Output "`n`n`nFinished successfully!"
}
