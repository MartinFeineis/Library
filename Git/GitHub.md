# Github

## Codespaces
If the dotfiles repository for codespaces contains an install script then the dotfiles do 
not get sym linked see [docs](https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles)

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
