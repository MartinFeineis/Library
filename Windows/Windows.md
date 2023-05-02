# Library for using Windows
## Creating a Programs Folder
I created a new Folder called NewProgs in C:\ with the same permissions (ACLs) as _Progam Files_ where I store all my installed programs to keep track of them more easy and being able to find them easy when being logged in as a different user.
```
New-Item -ItemType Directory -Path C:\NewProgs
Get-Acl -Path "C:\Program Files" | Set-Acl -Path C:\NewProgs
$env:Path += ";C\NewProgs"
```
I recommend putting the last line in a startup script for powershell instead of permanently appending it to the path, this makes it easier keeping track of changes.
After installing Powershell core I wanted to link its profile with my own profile, so I did this:
```
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
```
$s = Get-WmiObject -class hp_biossettinginterface -Namespace "root\hp\instrumentedbios"
$s.SetBIOSSetting('Virtualization Technology (VTx)','Enable')
```
