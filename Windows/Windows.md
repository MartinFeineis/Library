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
## WindowsOptionalFeature and WindowsCapabilities
From ChatGPT
* WindowsCapability deals with the installation and removal of specific Windows apps and features, often associated with Microsoft's built-in software.

* WindowsOptionalFeature deals with enabling or disabling optional system features and functionalities that may be hardware or software-related, but not part of the core Windows OS.
### WindowsCapabilities:
#### WindowsCapability CmdLets:
A List of all Windows Capability Commands
```powershell
PS C:\Users\Wolle> get-command -module dism -name "*capability*"

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Add-WindowsCapability                              3.0        dism
Cmdlet          Export-WindowsCapabilitySource                     3.0        dism
Cmdlet          Get-WindowsCapability                              3.0        dism
Cmdlet          Remove-WindowsCapability                           3.0        dism
```
Find and Enable Windows Capability, (e.g. Display Projection app)
```powershell
Get-WindowsCapability -Online -Name "*display*"
Add-WindowsCapability -Online -Name "App.WirelessDisplay.Connect~~~~0.0.1.0"
```
### WindowsOptionalFeature
#### WindowsOptionalFeature Cmdlets:
A list of all Windows Optional Feature Commands
```powershell
PS C:\Users\Wolle> get-command -name *optionalfeature*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Disable-WindowsOptionalFeature                     3.0        Dism
Cmdlet          Enable-WindowsOptionalFeature                      3.0        Dism
Cmdlet          Get-WindowsOptionalFeature                         3.0        Dism
Application     OptionalFeatures.exe
```
### Windows Terminal application

See Documentation:[doc](https://aka.ms/terminal-documentation), [schema](https://aka.ms/terminal-profiles-schema)
