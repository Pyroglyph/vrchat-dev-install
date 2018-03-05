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
    If (choco -noop -NOT -LIKE "Chocolatey")
    {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))
    }


    # Install Blender and Unity
    Write-Output "`n======================`n= Installing Blender =`n======================`n"
    choco install -y blender
    Write-Output "`n======================`n=  Installing Unity  =`n======================`n"
    choco install -y unity --version 5.6.3p1


    # Download and install the latest VRCSDK
    Write-Output "`n======================`n= Downloading VRCSDK =`n======================`n"
    (New-Object System.Net.WebClient).DownloadFile("https://www.vrchat.net/download/sdk", "%TEMP%/VRCSDK.unityPackage")

    If (-NOT (Test-Path -Path "~/Documents/Unity Projects"))
    {
        New-Item -Path "~/Documents/Unity Projects" -ItemType Directory
    }

    Remove-Item -Path "~/Documents/Unity Projects/VRCSDK.unityPackage"
    Move-Item -Path "%TEMP%/VRCSDK.unityPackage" -Destination "~/Documents/Unity Projects/VRCSDK.unityPackage"


    # We're done!
    Write-Output "`n`n`nFinished successfully!"
}
