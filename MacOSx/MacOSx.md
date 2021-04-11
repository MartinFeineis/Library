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
