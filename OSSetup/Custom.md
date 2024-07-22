# This is how I setup my Work Environment
## Python Setup
### Install pyenv
### update-alternatives

## Install i3

## Install Terminator

## Install zsh
### Install zsh Plugins
#### Oh-my-zsh
#### Spaceship Theme
#### zsh-autosugest
#### zshrc File
add aliases to mount nfs fileshares

## Install Colorls
This how to install it on Linux Mint 21.1 Vera, with gem 3.3.5 and ruby 3.0.2p107
```
sudo apt-get install -y build-essential
gem install --user-install colorls
echo "$PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin/" >> ~/.zshrc
```

## Install Nerdfonts

## Install AWS-CLI
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
## CommandLine Tools
### Installing colorls
```
sudo apt-get install ruby2.3-dev
sudo gem install colorls
```
### Install bat
Bat is more eye-friendly cat alternative, on [Github](https://github.com/sharkdp/bat). 
Replace the release number down there with the latest from the
Release Page [Release](https://github.com/sharkdp/bat/releases/).
```
BATCAT_VERSION=0.24.0
wget https://github.com/sharkdp/bat/releases/download/v${BATCAT_VERSION}/bat_${BATCAT_VERSION}_amd64.deb
wget https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb
sudo dpkg -i bat_${BATCAT_VERSION}_amd64.deb
echo "alias b=`which batcat`" >> ~/.zshrc
```
### fuzzyfind
On [fzf](https://github.com/junegunn/fzf)
```
sudo apt-get install fzf
```
### autojump
On [autojump](https://github.com/wting/autojump). Autojump needs to be sourced.
```
sudo apt install autojump
echo "source /usr/share/autojump/autojump.sh" >> ~/.zshrc
```

## Pseudo stresstest forkbomb
```
t(){for ((i=1; i<=100; i++ )) { (curl www.URL.com > /dev/null  ; echo $i );next} & ; t }
```
Only blows your system without putting real stress on a server, but might get you banned or blocked.

# ZSH
Install, verify `zsh` location and change it to default shell
```
sudo apt-get install zsh
whereis zsh
chsh -s /usr/bin/zsh wolle
```
## Oh-my-zsh
Documentation is [here](https://github.com/ohmyzsh/ohmyzsh) Install `Oh-my-zsh` first because it comes with its own `.zshrc` file
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### Syntax highlighting
More [here](https://github.com/zsh-users/zsh-syntax-highlighting)
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Spaceship prompt
To make things look nice, more info [here](https://github.com/spaceship-prompt/spaceship-prompt)
```
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```
### ZSH Completions
more info [here](https://github.com/zsh-users/zsh-completions)
```
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```
### ZSH autosuggestions
See Documentation [here](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
## Colorls
Install buildtools, buildessentials, ruby and then a too complicated bash expression that should work independent of ruby version (famous last words).
```
sudo apt-get install build-essential bison openssl libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool
sudo apt install ruby ruby-dev gcc make
gem install colorls --user-install
alias colorls="`gem env | grep "USER INSTALLATION DIRECTORY" | awk '{ print $5 }'`/bin/colorls"
```

### Auto Sugges

