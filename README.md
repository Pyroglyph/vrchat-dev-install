# The VRChat Development Environment Installer
> I should come up with a catchier name...

A completely automated script that sets up a development pipeline for creating content for VRChat!

## Features
- Downloads and installs Blender

- Downloads and installs Unity 5.6.3p1

- Downloads the latest VRChat SDK and places it in the Unity Projects folder, ready for use

_Did I mention that this is all automatic?_

## How to Use
1. Open the Command Prompt/PowerShell as an Administrator (just press Ctrl+X, then A).

2. Copy-paste this into the prompt you just opened:

#### `Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Pyroglyph/vrchat-dev-install/master/vrchat-dev-install.ps1'))`

3. The script will download and run. You don't need to do anything else!
