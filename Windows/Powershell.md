# Powershell snippets
## Shutdown the Computer
```shutdown /s /t 0``` or the ```Stop-Computer``` Cmdlet works, too.
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
Install Ubuntu WSL
https://docs.microsoft.com/en-us/windows/wsl/install-win10
It can be started by typing ```bash``` in Powershell 
```
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing
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
And Install it
```
Find-Package -Provider chocolatey -name openssl | Install-Package
```
## Active Directory 
### Get-ADComputer
Query for Computers with names like appsrv and display only the found names one per line
```
Get-ADComputer -Filter 'Name -like "appsrv*"' | select Name
```
Get all Computer start contain xyz but do not start with abc
```
Get-ADComputer -Filter {(Name -like "*xyz*") -and  (Name -notlike "abc*")} | select Name
```
### Get-ADUser
Get all Groups a User is Member of and store them in a variable
$GAwesome = (Get-ADPrincipalGroupMembership -Identity ((Get-ADUser -filter "Name -like 'Guy Awesome'").ObjectGUID)).Name
### Add-ADGRoupMember
To add a user to an Active Directory Group user as in the [Microsoft Docs](https://docs.microsoft.com/en-us/powershell/module/addsadministration/add-adgroupmember?view=win10-ps)
```
Add-ADGroupMember -Identity google -Members mfeineis
```
## Copy Files Remotely
### Copy Files from a Remote Machine
Copy Files from a to/from a remote Server by instatiating a new PSSession and then use the ```-ToSession/-FromSession``` Flag
use the -Recurse Flag to copy more than one File. I did not try to copy it directly from the remote machine to the other remote machine. I assume this wouldn't work due to the second hop Problem.
```
$ASession = New-PSSession -ComputerName <Remote-Name> -Credential (Get-Credential)
Copy-Item "E:\<path_name>*" -Destination "<local-path>" -Recurse -FromSession $ASession

$BSession = New-PSSession -ComputerName <Remote-Name> -Credential (Get-Credential)
Copy-Item "<local-path>\Test.z*" -Destination "<remote-path>" -Recurse -ToSession $BSession
```

## Get all commands from Module
```
 (Get-Module (get-command -name <cmdlet>).source).ExportedCommands
```
This command gets the Module containing the <cmdlet> and then gets all the commands in that Module
