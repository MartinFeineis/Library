# Git Stuff
# Linux
## Configure ssh for github
To generate ssh keys see here [Linux](../Linux/Linux.md##setup-ssh-key-connectivity) or [Windows]()
With ssh key add. Works only for github, when you need to access github enterprise servers this needs adjustment.
```
Host github.com
  IdentityFile ~/.ssh/githubkey
```
## Tagging
```
git tag v1.0
git push --tags
```
### CodeCommit
ssh config for AWS code commit
```
Host git-codecommit.*.amazonaws.com
  User ABCEDEUserKey
  IdentityFile ~/.ssh/privateKey
```
So that the ssh key gets used when cloning repositories.
Create new GPG key without gui prompts, see also [Docs](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key)
```
gpg --default-new-key-algo rsa4096 --gen-key --passphrase '' --pinentry-mode=loopback
gpg --list-keys
gpg --armor --export KEYID1234567890ABCDEF
```
Add the exported Key in Github under `Settings` > `SSH and GPG Keys` at `New GPG Key` 
Configuring git to use the key for signing
```
git config --global user.email "me@email.com"
git config --global user.name "Martin Feineis"
git config --global user.signingkey KEYID1234567890ABCDEF
git config --global commit.gpgsign true
```
Config File at `~/.gitconfig'
```
[user]
	email = my-email@gmail.com
	name = Martin Feineis
	signingkey = KEYID1234567890ABCDEF
[commit]
	gpgsign = true
```
### gh cli
[Command reference](https://cli.github.com/manual/gh)
Installation, also see [installation](https://github.com/cli/cli#linux--bsd)
more documentation, [here](https://cli.github.com/)
```
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo apt update && sudo apt install gh -y
```
list repos
```
gh repo list
```
Create a public repository and set it up to sync with git in the current directory
```bash
gh repo create -s=. --public --remote=upstream
git remote add origin git@github.com:<owner>/<project>.git
git branch -M main
git push -u origin main
```
the `gh` command creates a repo with the source (`s`) at the current directory, makes it public and pushes it to github.
## Rewriting history
Checkout the commit you want keep, if you want to wipe everythin checkout the
initial commit. Then reset the HEAD to this commit and force push it. 
```
git checkout 1a2b3c
git reset --hard origin/master
git commit -am "rewriting history"
git push --force origin HEAD:master
```
# Windows
## Install git
```powershell
Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe" -OutFile "~\Downloads\git.exe"
.\Downloads\git.exe
```
## Generate SSH Key 
The `-N` flag needs to be double quoted in Powershell
```powershell
ssh-keygen -t rsa -b 2048 -C "HoneyLapGitHub" -f $HOME\.ssh\github -N '""'
```
## GPG for Git
```powershell
Invoke-WebRequest -Uri "https://files.gpg4win.org/gpg4win-4.2.0.exe" -OutFile "~\Downloads\gpg4win.exe"
   6 .\Downloads\gpg4win.exe
```
## GPG for Git
Install [GPG4win](https://www.gnupg.org/download/)
```sh
gpg --default-new-key-algo rsa4096 --gen-key --passphrase '' --pinentry-mode=loopback
gpg --list-keys
gpg --armor --export ABDCDEFHEXKEYID
git config --global user.signingkey D7412BCE5B0E2BEBB290D56005264B3CF6CE5B45
git config --global user.email "martifein@gmail.com"
git config --global user.name "Martin Feineis"
git config --global commit.gpgsign true
git config --global gpg.program (get-command -name gpg).Source
```
