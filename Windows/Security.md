# Security
## GPOs
```
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Value 1

New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun"
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -Value "services.msc"
```

### Within AD
```
Import-Module GroupPolicy
New-GPO -Name "Restrict Service Management" -Comment "GPO to restrict starting or stopping services"
New-GPLink -Name "Restrict Service Management" -Target "OU=SessionHosts,DC=yourdomain,DC=com"
Set-GPRegistryValue -Name "Restrict Service Management" -Key "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ValueName "DisallowRun" -Type DWORD -Value 1
```



