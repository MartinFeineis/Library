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
Run this, and only this as Administrator/root
```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
Run the following as regular User so you don't need to be Administrator to use wsl
this installs Ubuntu 18-04. Look here for current supported distros and manual download Links [wsl](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
```
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
Rename-Item Ubuntu.appx Ubuntu.zip
Expand-Archive Ubuntu.zip Ubuntu
cd Ubuntu
.\ubuntu1804.exe
```
## File Actions
### Find Files
Finding Files and Displaying only the Filenpath and name one per Line
```
Get-ChildItem -Path *Filename* -Recurse | select FullName
```
### Search in Files
Search for a string within a Folder and its subfolders
```
Get-ChildItem -Recurse | Get-Content -ErrorAction SilentlyContinue | Select-String -pattern "error" | Out-File Errors.log
```  
Recurse through a directory structure and search each files for `pattern` then store each match in a hash-table/dictionary with
the Filename as key and a number per match.
```
$w = @{}
foreach( $file in Get-ChildItem -Recurse ){
    $ma = Get-Content -Path $file -ErrorAction SilentlyContinue | Select-String -pattern "pattern"
    $ma
    $i = 0
    foreach ( $match in $ma ){
        $i += 1
        $file.Name + "_" + $i
        $w.Add( $file.Name + "_" + $i, $match )
    }
}
```
Create a range object and search through a filetree for a string that contains elements of that range  
```
$a = 1..22
$a | ForEach-Object { @{(Get-Content .\NoErrorFiles.log | Select-String ('5/' + $_ + '/19') | Measure-Object).Count = '5/'+$_+'/19'}}
```
## Compare aka diff two files
It has to explicitly taken the content of the files. If just two filenames are given, those are compared without regard of their actual content.
```
Compare-Object $(Get-Content .\first.txt) $(Get-Content .\second.txt)
```
### Compare Errors from to Error Log files
The following creates a table named "TableName" and add the 3 columns Date,Error1 and Error2 to it. Then it populates the table with the findings of the Files.  
```
$table = New-Object SYStem.Data.DataTable "TableName"

$col1 = New-Object system.Data.DataColumn Date,([string])
$col2 = New-Object system.Data.DataColumn Error1,([string])  
$col3 = New-Object system.Data.DataColumn Error2,([string]) 
 
$table.Columns.Add($col1)
$table.Columns.Add($col2)
$table.Columns.Add($col3)

1..28 | ForEach-Object { $row=$table.NewRow(); $row.Date=('5/'+$_+'/19');  $row.Error1=(Get-Content .\Errorlogs1.log | Select-String ('5/' + $_ + '/19') | Measure-Object).Count; $row.Error2=(Get-Content .\Errorlogs2.log | Select-String ('5/' + $_ + '/19') | Measure-Object).Count;  $table.Rows.Add($row)}                                             

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
On a Windows 2016 Server the RSAT Tools need to be installed, you can find it with the Powershell Commands below.
```
Get-WindowsOptionalFeature -Online -FeatureName *RSAT*
Enable-WindowsOptionalFeature -Online -FeatureName RSAT-ADDS-Tools-Feature -All
Get-WindowsFeature RSAT*
Install-WindowsFeature RSAT-AD-Powershell
```
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
```
$GAwesome = (Get-ADPrincipalGroupMembership -Identity ((Get-ADUser -filter "Name -like 'Guy Awesome'").ObjectGUID)).Name
```
I had some problems using the Get-ADGRoupMember cmdlet with an ObjectGUID for the -Idetity Parameter. Working around that I could use the Get-ADGroup cmdlet in the following way.
```
(Get-ADGroup '534867fb-57b0-471f-85bf-b30a8900009a1' -Properties members).Members
```
Get everything about a User
```
Get-ADUser -Identity<Username> -Properties *
```
Getting a list of all locked out accounts
```
(Get-ADUser -Filter * -Properties lockedOut,GivenName | Where {$_.LockedOut -eq $True}).Name
```
Get Alls Users in a company
```
Get-ADUser -Filter * -SearchBase "OU=<users>,OU=<company>,DC=<domain>,DC=com" | Measure-Object
Get-ADUser -Filter * -SearchBase "OU=Users-Disabled,OU=Users,OU=<company>,DC=<domain>,DC=com" -Properties LastLogonDate | select Name,LastLogonDate | Sort-Object -Property LastLogonDate
```

#### Adsisearcher
When the `RSAT-AD-Powershell` module is not available `adsisearcher` can help.
```
(([adsisearcher]"samaccountname=ME988789").FindAll() | select -ExpandProperty properties).memberof | sort
```
### Getting all Users currently logged in to a machine/server
```
$ gwmi Win32_LoggedOnUser | select Antecedent
query users
```
### Add-ADGRoupMember
To add a user to an Active Directory Group user as in the [Microsoft Docs](https://docs.microsoft.com/en-us/powershell/module/addsadministration/add-adgroupmember?view=win10-ps)
```
Add-ADGroupMember -Identity anygroup -Members anyuser
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

## Firewall Rules with Powershell
```
Get-NetFirewallRule
Remove-NetFirewallRule
New-NetFirewallRule -name "Allow inbound 8080" -DisplayName "Allow inbound 8080" -protocol tcp -Enabled true -RemoteAddress 123.456.789.012 -profile domain -action allow -remoteport 8080 -localport 8080
```
The _name_ parameter has to be unique to the Firewall Rule, the _DisplayName_ can be the same across several Firewall Rules, and therefore used to group Rules together.
### Connection Security Rules
Connection Security Rules can be found at Control Panel > System and Security > Windows Defender Firewall > Advanced Settings > Connection Security Rules
```
New-NetIPsecRule -IPsecRuleName "Rule Name" -DisplayName "Rule Display Name" -Enabled True -LocalAddress <Ip-Address> -LocalPort <Ports> -Protocol TCP
```
Notes:
* The IpSecRuleName must be unique
* Ports can be
    * A Single Port e.g. 80
    * A range of Ports e.g. "80-443"
    * A list of Ports e.g. 80,443,8080   

## Select-String
Find in all Files starting with TMP the regex Pattern and print only the found Matches. Searching for content within the matching Files.
```Select-String -Path "C:\<Path>\TMP*" -Pattern "regex" | ForEach-Object {$_.Matches[0].Value}```
## Windows Event Log
### All Sources
To get a list of all available Sources, run the following. You can substitue Application with System,Setup,Forwarded Events or Security also you need Administrator Rights to access Security Logs.

```
$Sources=(Get-Eventlog -LogName Application).Source
[System.Collections.ArrayList]$SourceNames= @{}

foreach ($source in $Sources) {
    if ($SourceNames -notcontains $source) {
        [void]$SourceNames.add($source)
    }
}
$SourceNames
```

The _[void]_ prevents `$SourceNames` from containing the index numbers of its content.
## PSReadline
Using PSReadline for better (bash-like) history. [Docs](https://docs.microsoft.com/en-us/powershell/module/psreadline/?view=powershell-7.2)
