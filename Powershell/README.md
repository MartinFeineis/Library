# Powershell snippets
## Shutdown the Computer
```shutdown /s /t 0```
## Restart the Computer
Restarts the Computer with Other(plenned) reason```shutdown /r /d p:0:0```
## SSH Sessions with Posh
This starts a new SSH Session through Powershell to a linux computer
```
New-SSHSession -Computername <IP or DNS> -Port 443 -KeyFile C:\path\to\key\file -Credential <username>
Get-SSHSession
Invoke-SSHCommand -SessionId 0 -Command "ls -lah"
Remove-SSHSession -Index 0 -Verbose
```
## Installing the Linux Support thing for Windows
https://docs.microsoft.com/en-us/windows/wsl/install-win10
It can be started by typing ```bash``` in Powershell
```
Install Ubuntu WSLInvoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFileUbuntu.appx -UseBasicParsing
Rename-Item Ubuntu.appx Ubuntu.zip
Expand-Archive Ubuntu.zip Ubuntu
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
cd Ubuntu
.\ubuntu.exe
```
## Find Files
Finding Files and Displaying only the Filenpath and name one per Line
```
Get-ChildItem -Path *Filename* -Recurse | select FullName
```
## Compare aka diff two files
It has to explicitly taken the content of the files. If just two filenames are given, those are compared without regard of their actual content.
```
Compare-Object $(Get-Content .\first.txt) $(Get-Content .\second.txt)
```
## Chocolatey
Getting chocolatey up and running with Powershell V5
```
Find-Package -Provider chocolatey
```
## Active Directory 
Query for Computers with names like appsrv and display only the found names one per line
```
Get-ADComputer -Filter 'Name -like "appsrv*"' | select Name
```
