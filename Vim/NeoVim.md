# NeoVim
## Installation
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo "export PATH="$PATH:/opt/nvim-linux-x86_64/bin" >> ~/.zshrc
```

## PackageManagers
Lazy [lazy.nvim](https://github.com/folke/lazy.nvim)
```bash
mkdir ~/.config/nvim
echo 'require("config.lazy")' >> ~/.config/nvim/init.lua
```
next step
```bash
mkdir -p ~/.config/nvim/lua/config/
cat <<'EOF' ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins, uncomment this line after plugins
    -- { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
EOF 
```
Packer unmaintained [packer.nvim](https://github.com/wbthomason/packer.nvim?tab=readme-ov-file)

## File Explorer
NerdTree alternative [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)

## Appearances
WebDevIcons [nvim-web-icons](https://github.com/nvim-tree/nvim-web-devicons)
