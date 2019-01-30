# Azure for Powershell
## Install Azure Module on Windows Server 2016
```
Install-PackageProvider -Name NuGet
Install-Module Azure
```
At least that's what I had to do

## Install Powershell on Linux Mint 
```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
sudo apt-get update
sudo apt-get install powershell -y
```

## Azure ActiveDirectory
### Creating a new User in AzureAD
```
Connect-AzureAD
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "<Password123>"
New-AzureADUser -DisplayName "Honey" -UserPrincipalName "honey@martinandnga.com"  -PasswordProfile $PasswordProfile -AccountEnabled $true -MailNickName "Honey"
```
### Change a Users Password 
```
 Set-AzureADUserPassword -ObjectId (Get-AzureADUser -Filter "Displayname eq 'Honey'").ObjectId
 ```
## Creating a new Virtual Machine in Azure 
