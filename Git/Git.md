# Git Stuff

## Configure ssh for github
To generate ssh keys see here (Linux)[../Linux/Bash.md##Setup-ssh-Key-connectivity] or (Windows)[]
With ssh key add. Works only for github, when you need to access github enterprise servers this needs adjustment.
```
Host github.com
  IdentityFile ~/.ssh/githubkey
```
### CodeCommit
ssh config for AWS code commit
```
Host git-codecommit.*.amazonaws.com
  User ABCEDEUserKey
  IdentityFile ~/.ssh/privateKey
```
So that the ssh key gets used when cloning repositories.
Create new GPG key without gui prompts, see also (Docs)[https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key]
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
Installation, also see [installation](https://github.com/cli/cli#linux--bsd)
more documentation, [here](https://cli.github.com/)
```
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo apt update && sudo apt install gh -y
```
list repos
```
gh repo list
```
## Rewriting history
Checkout the commit you want keep, if you want to wipe everythin checkout the
initial commit. Then reset the HEAD to this commit and force push it. 
```
git checkout 1a2b3c
git reset --hard origin/master
git commit -am "rewriting history"
git push --force origin HEAD:master
```