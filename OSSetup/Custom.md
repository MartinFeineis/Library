# Linux OS Setup
## ZSH
Install, verify `zsh` location and change it to default shell
```bash
sudo apt-get install zsh
whereis zsh
chsh -s /usr/bin/zsh wolle
```
### Oh-my-zsh
Documentation is [here](https://github.com/ohmyzsh/ohmyzsh) Install `Oh-my-zsh` first because it comes with its own `.zshrc` file
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### Syntax highlighting
More [here](https://github.com/zsh-users/zsh-syntax-highlighting)
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Spaceship prompt
To make things look nice, more info [here](https://github.com/spaceship-prompt/spaceship-prompt)
```bash
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```
### ZSH Completions
more info [here](https://github.com/zsh-users/zsh-completions)
```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```
### ZSH autosuggestions
See Documentation [here](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Network Drives 
add aliases to mount nfs fileshares
```
nasghoul:/volume1/public  /mnt/pubnas  nfs  _netdev,nofail,x-systemd.automount,x-systemd.idle-timeout=600,timeo=50,retrans=2  0  0
nasghoul:/volume1/work    /mnt/worknas nfs  _netdev,nofail,x-systemd.automount,x-systemd.idle-timeout=600,timeo=50,retrans=2  0  0
```

## Install Nerdfonts
check [here](https://www.nerdfonts.com/font-downloads) 
```bash
curl https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip -o /tmp/UbuntuMono.zip
[ ! -d "~/.local/share/fonts" ] && mkdir -p ~/.local/share/fonts
unzip /tmp/UbuntuMono.zip -d ~/.local/share/fonts 
fc-cache -f -v
```

## File display colors
Vivid to update (LS_COLORS)[https://github.com/sharkdp/vivid]
```
wget "https://github.com/sharkdp/vivid/releases/download/v0.10.1/vivid_0.10.1_amd64.deb"
sudo dpkg -i vivid_0.10.1_amd64.deb
echo 'export LS_COLORS="$(vivid -m 8-bit generate ayu)"' >> ~/.zshrc
```
## Install AWS-CLI
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
## CommandLine Tools
### Install lsd-rs 
[Github](https://github.com/lsd-rs/lsd)
```bash
sudo apt install lsd
```

### Install bat
Bat is more eye-friendly cat alternative, on [Github](https://github.com/sharkdp/bat). 
Replace the release number down there with the latest from the
Release Page [Release](https://github.com/sharkdp/bat/releases/).
```bash
BATCAT_VERSION=0.24.0
wget https://github.com/sharkdp/bat/releases/download/v"${BATCAT_VERSION}"/bat_"${BATCAT_VERSION}"_amd64.deb -O batcat.deb
sudo dpkg -i batcat.deb
echo "alias b=`which bat`" >> ~/.zshrc
#echo "alias b=`which batcat`" >> ~/.zshrc
```

<strike>

### fuzzyfind
On [fzf](https://github.com/junegunn/fzf)

</strike>

### autojump
On [autojump](https://github.com/wting/autojump). Autojump needs to be sourced.
```bash
sudo apt install autojump
echo "source /usr/share/autojump/autojump.sh" >> ~/.zshrc
```



### Auto Sugges

## [Superfile](https://superfile.dev/)
A terminal based file Explorer including picture preview
Needs Nerdfonts, install with `bash` and `curl`
```sh
bash -c "$(curl -sLo- https://superfile.dev/install.sh)"
spf
```
