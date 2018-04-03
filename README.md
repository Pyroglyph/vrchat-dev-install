# The VRChat Development Environment Installer
> I should come up with a catchier name...

A completely automated script to set up your VRChat content creation pipeline!

## Features
- Automatically installs Blender and Unity 5.6.3p1 if needed

- Downloads the latest VRChat SDK and places it in the default Unity Projects folder, ready for use

_Did I mention that this is completely automatic?_

## How to Use
1. Open the Command Prompt/PowerShell as an Administrator (just press Win+X, then A).

2. Copy-paste this into the prompt you just opened:

#### `PowerShell; Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Pyroglyph/vrchat-dev-install/master/vrchat-dev-install.ps1'))`

3. The script will download and run. You don't need to do anything else!

## Planned Features

- [ ] Auto-create a VRChat project with the SDK pre-installed

- [x] Check to see if Blender and/or Unity is already installed

- [ ] Progress bars for downloads (_because it's not fun to look at a console with no output :/_)

## Stuff you might want to know

This script downloads these files from the internet:

- Latest Blender Installer (from Chocolatey) : ~90MB

- Unity 5.6.3p1 Installer (from Unity) : ~600MB

- Latest VRChat SDK Package (from VRChat) : ~10MB

If you are on a metered connection, be careful!
