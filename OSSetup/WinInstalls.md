# Some CmdLine Installers
The versions are probably oudated
## Install Virtualbox
```powershell
New-Item -ItemType directory -Path "~\Downloads\VirtualBox"
Copy-Item -Path "~\Downloads\VirtualBox.exe" -Destination "~\Downloads\Virtualbox\current\virtualBox.exe" -Recurse -Force
cd ~\AppData\Local\Temp\VirtualBox
.\VirtualBox-5.2.14-r123301-MultiArch_amd64.msi
```

## Install ConEmu
```powershell
powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((new-object net.webclient).DownloadString('https://conemu.github.io/install.ps1'))"​​​​​​​
```

## Install AWS-CLI
```powershell
Invoke-WebRequest -Uri "https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi" -OutFile "~\Downloads\AWS-CLI.msi"
~\Downloads\AWS-CLI.msi /passive
```

## Install .Net4.7.2
```powershell
$dotnetPath = "E:\Software\microsoft\.NET\dotnet472"
New-Item -path dotnetPath -itemtype "directory"
Invoke-WebRequest -Uri "https://download.microsoft.com/download/A/1/D/A1D07600-6915-4CB8-A931-9A980EF47BB7/NDP47-DevPack-KB3186612-ENU.exe" -OutFile dotnetPath\dotnet472.exe
cd dotnetPath
.\dotnet472.exe /q
```
