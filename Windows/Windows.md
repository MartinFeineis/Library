# Library for using Windows
## Creating a Programs Folder
I created a new Folder called NewProgs in C:\ with the same permissions (ACLs) as _Progam Files_ where I store all my installed programs to keep track of them more easy and being able to find them easy when being logged in as a different user.
```powershell
$progPath = "C:\mybins"
New-Item -ItemType Directory -Path $proPath
Get-Acl -Path "C:\Program Files" | Set-Acl -Path $progPath
$env:Path += ";$progPath"
```
I recommend putting the last line in a startup script for powershell instead of permanently appending it to the path, this makes it easier keeping track of changes.
After installing Powershell core I wanted to link its profile with my own profile, so I did this:
```powershell
$p = Split-Path $PROFILE
$l = Split-Path $PROFILE -Leaf
New-Item -ItemType SymbolicLink -Path $p -Name $l -Value "C:\Users\me\<path>\MyFunctions.ps1"
```
The File MyFunctions.ps1 contains all the settings I want to have across my different powershells and therefore everything is available where I want to have it without duplication.
## Moving Windows on Windows 10
A lot of times I work on several screens, and when detaching my Laptop from them not all Windows move properly over to the main display. You can move it over with the following for steps:    
```
1. klicking on the Icon in the taskbar  
2. Pressing Alt+Space a the same time  
3. pressing M Button on the keyboard  
4. using arrow keys (left or right) to move the window into the current Desktop  
```
## Enable Virtualization
In Powershell 5 on HP Laptops
```powershell
$s = Get-WmiObject -class hp_biossettinginterface -Namespace "root\hp\instrumentedbios"
$s.SetBIOSSetting('Virtualization Technology (VTx)','Enable')
```
In an elevated Powershell 7
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
## ssh on Windows
For some reason private ssh keys need to have an empty new Line at the end of the file
## GPG for Git
Install [GPG4win](https://www.gnupg.org/download/)
```sh
gpg --default-new-key-algo rsa4096 --gen-key --passphrase '' --pinentry-mode=loopback
gpg --list-keys
gpg --armor --export ABDCDEFHEXKEYID
git config --global user.signingkey D7412BCE5B0E2BEBB290D56005264B3CF6CE5B45
git config --global user.email "martifein@gmail.com"
git config --global user.name "Martin Feineis"
git config --global commit.gpgsign true
git config --global gpg.program "C:\Program Files (x86)\GnuPG\bin\gpg.exe"
```
## WindowsOptionalFeature and WindowsCapabilities
From ChatGPT
* WindowsCapability deals with the installation and removal of specific Windows apps and features, often associated with Microsoft's built-in software.

* WindowsOptionalFeature deals with enabling or disabling optional system features and functionalities that may be hardware or software-related, but not part of the core Windows OS.
WindowsCapability CmdLets:
```powershell
PS C:\Users\Wolle> get-command -name *capability*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Find-RoleCapability                                2.2.5      PowerShellGet
Function        Find-RoleCapability                                1.0.0.1    PowerShellGet
Cmdlet          Add-WindowsCapability                              3.0        Dism
Cmdlet          Export-WindowsCapabilitySource                     3.0        Dism
Cmdlet          Get-PSSessionCapability                            7.3.6.500  Microsoft.PowerShell.Core
Cmdlet          Get-WindowsCapability                              3.0        Dism
Cmdlet          New-PSRoleCapabilityFile                           7.3.6.500  Microsoft.PowerShell.Core
Cmdlet          Remove-WindowsCapability                           3.0        Dism
```
WindowsOptionalFeature Cmdlets:
```powershell
PS C:\Users\Wolle> get-command -name *optionalfeature*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Disable-WindowsOptionalFeature                     3.0        Dism
Cmdlet          Enable-WindowsOptionalFeature                      3.0        Dism
Cmdlet          Get-WindowsOptionalFeature                         3.0        Dism
Application     OptionalFeatures.exe
```