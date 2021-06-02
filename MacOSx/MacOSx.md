# Setting up MacOsX
install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Install zsh tmux and vim
```
brew install cmake python3 zsh vim tmux
chsh -s /usr/local/bin/zsh
```

# Install spaceship theme
also zsh-completions
```
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 
brew install zsh-completions
```

# Install vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
compile ycm
```
cd ~/.vim/bundle/youcompleteme
./install.sh
```

# Install colorls
add alias to `.zshrc`
```
gem install colorls --user-install
alias colorls="$HOME/.gem/ruby/2.6.0/bin/colorls"
```

# Install NerdFonts
```
brew tap homebrew/cask-fonts
brew install --cask font-ubuntu-nerd-font
```

## Do no write DSStore Files
```
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
```
