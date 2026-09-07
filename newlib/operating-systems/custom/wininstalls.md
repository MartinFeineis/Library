# Some CmdLine Installers
The versions are probably oudated
## Superfile explorer
[Github](https://github.com/yorukot/superfile)
```powershell
winget install --id yorukot.superfile
```

## Install lsd
[Github](https://github.com/lsd-rs/lsd/tree/main)
See aliases set in $PROFILE. LS_COLORS variable can be set to show custom themes, also in $PROFILES.
Vivid can be used on Linux to generate LS_COLORS scheme, savbed to a file and then copied to Windows.
```powershell
winget install --id lsd-rs.lsd
```

## Install ConEmu
```powershell
powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((new-object net.webclient).DownloadString('https://conemu.github.io/install.ps1'))"​​​​​​​
```

### Install AWS-CLI
```powershell
Invoke-WebRequest -Uri "https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi" -OutFile "~\Downloads\AWS-CLI.msi"
~\Downloads\AWS-CLI.msi /passive
```

