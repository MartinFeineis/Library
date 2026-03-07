# Decommissioned Installer Notes

## Install Colorls
This how to install it on Linux Mint 21.1 Vera, with gem 3.3.5 and ruby 3.0.2p107
```
sudo apt-get install -y build-essential
gem install --user-install colorls
echo "$PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin/" >> ~/.zshrc
```
