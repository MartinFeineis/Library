# Security
## Fix ssh key permissions
This solve the "WARNING: UNPROTECTED PRIVATE KEY FILE"
```powershell
# Take ownership and restrict to your user only
$keyFile = "C:\path\to\key-file"
$acl = Get-Acl $keyFile

# Disable inheritance and remove existing permissions
$acl.SetAccessRuleProtection($true, $false)
$acl.Access | ForEach-Object { $acl.RemoveAccessRule($_) }

# Grant full control to your user only
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    $env:USERNAME, "FullControl", "Allow"
)
$acl.AddAccessRule($rule)
Set-Acl $keyFile $acl
```
## GPOs
```powershell
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Value 1

New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun"
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -Value "services.msc"
```

### Within AD
```powershell
Import-Module GroupPolicy
New-GPO -Name "Restrict Service Management" -Comment "GPO to restrict starting or stopping services"
New-GPLink -Name "Restrict Service Management" -Target "OU=SessionHosts,DC=yourdomain,DC=com"
Set-GPRegistryValue -Name "Restrict Service Management" -Key "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ValueName "DisallowRun" -Type DWORD -Value 1
```



