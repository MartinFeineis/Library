# Azure for Powershell
[portal](https://portal.azure.com)
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
[admin](https://admin.microsoft.com)  
[entraId](https://entra.microsoft.com)  

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


## Resource deployment
```
$resourceGroupName = "string"
$deploymentName = "string"
$location = "centralus"

New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "C:\Users\<path>\azuredeploy.json"
```

## Getting Started
Create __Resources Group__
create __Vnet__ (Firewall Manager costs 20$/day)
Create __HostPool__ Domain to join choose __entraID__
Free trial can't request quota increase!
Application Groups host Desktops and other Applications
VMs in Session host need to be assigned to users
Create Workspace in AVD Dashboard
1. Host Pool
2. Session Hosts (VMs etc)
3. Create EntraID Users
    3.1 give "Desktop Virtualization User" to user in "Azure role assignments" 
    3.2 Admin???
4. Assign Sessions to User in Host Pool
5. Create Workspace in AVD

[RDP Properties](https://learn.microsoft.com/en-us/azure/virtual-desktop/customize-rdp-properties?tabs=portal)