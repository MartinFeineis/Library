# NeoVim
## Installation
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
mkdir ~/.config/nvim
echo "export PATH="$PATH:/opt/nvim-linux-x86_64/bin" >> ~/.zshrc
```

## PackageManagers
Lazy [lazy.nvim](https://github.com/folke/lazy.nvim)
Packer unmaintained [packer.nvim](https://github.com/wbthomason/packer.nvim?tab=readme-ov-file)

## File Explorer
NerdTree alternative [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)

## Appearances
WebDevIcons [nvim-web-icons](https://github.com/nvim-tree/nvim-web-devicons)
