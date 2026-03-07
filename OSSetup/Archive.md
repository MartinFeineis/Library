# Decommissioned Installer Notes

## Install Colorls
This how to install it on Linux Mint 21.1 Vera, with gem 3.3.5 and ruby 3.0.2p107
```
sudo apt-get install -y build-essential
gem install --user-install colorls
echo "$PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin/" >> ~/.zshrc
```

## Colorls
Install buildtools, buildessentials, ruby and then a too complicated bash expression that should work independent of ruby version (famous last words).
```bash
sudo apt-get install build-essential bison openssl libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool
sudo apt install ruby ruby-dev gcc make
gem install colorls --user-install
alias colorls="`gem env | grep "USER INSTALLATION DIRECTORY" | awk '{ print $5 }'`/bin/colorls"
```
