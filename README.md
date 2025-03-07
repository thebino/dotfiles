# dotfiles

The files in this repositories are dotfiles and Manifest files managed by [comtrya](https://github.com/comtrya/comtrya).

> Comtrya allows to configure and **provision** the system with these files.


## 🔧 Installation
To install [comtrya](https://www.comtrya.dev/getting-started/installation) run the installation script or download it from their page.
```shell
curl -fsSL https://get.comtrya.dev | sh
```



## 🌱 Provisioning
Provisioning a specific manifest or a subset
```shell
comtrya -d https://github.com/thebino/dotfiles apply -m apps.nvim
```

Provisioning **all** manifests from the repository
```shell
comtrya -d https://github.com/thebino/dotfiles apply
```

### 🍏 from Scratch

To install a system from scratch, some prerequisites are required to start the provisioning.
```shell
xcode-select --install
```
Install [Homebrew](https://brew.sh/) on the system.

Install GnuPG and import the private key
```shell
comtrya -d https://github.com/thebino/dotfiles apply -m apps.gnupg
/opt/homebrew/bin/gpg --import private_key.asc
export GPG_TTY=$(tty)
```


## ⚠️ Configuration
 `{{ user.config_dir }}` on Mac is refering to `~/Library/Application Support/<appname>/` it might be necessary to use `{{ user.home_dir }}/.config` for some apps instead.



## 🔐 Encryption
Instead of the build-in encryption with [age](https://crates.io/crates/age) some configuration files are encrypted using GPG and are decrypted during the provisioning.

Encryption
```shell
$ gpg --output input.gpg --encrypt --armor input.txt
```

Decryption
```shell
$ gpg --output output.txt --decrypt input.gpg
```



## 📝 neovim

![nvim screen](docs/editor_nvim.png)

### Ui
 - **Theme** [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
 - **Syntax Highlighting** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
 - **Tabbar** at the top [barbar.nvim](https://github.com/nanozuki/tabby.nvim/) 
 - **Status** at the bottom [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
 - **Git blame** inline [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
 - **Cursor Highlighting** [cursorline](https://github.com/yamatsum/nvim-cursorline)
 - **Keybingings popup** [which-key.nvim](https://github.com/folke/which-key.nvim) `<leader>` shows popup with keybingings


### Files
 - **File Browser** [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) `_fe` open/close, `_e` focus
 - **Fuzy Finder** [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) `_ff` for files, `_fg` for live grep
 - **Git** [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) `_gl` lazygit in a floating window
 - **File Pinning** [harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2) `_ba` mark a file, `_bb` show marked files

### Typing
 - **Autopairs** [nvim-autopairs](https://github.com/windwp/nvim-autopairs) adds matching brachets
 - **Change parenthesses** [vim-surround](https://github.com/tpope/vim-surround) `cs '"` inside a \"
 - **Character motion** [flash.nvim](https://github.com/folke/flash.nvim) Press `s` and any characters
 - **Autocompletion** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) auto-completion `_s` shows popup with snippets


### Languages
 - **Debug adapters** [nvim-dap](https://github.com/mfussenegger/nvim-dap) Debug adapter `Space + d`
 - **Go** [go.nvim](https://github.com/ray-x/go.nvim) Go language features
 - **Rust** [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) Rust tools
 - **Rust** [crates.nvim](https://github.com/Saecki/crates.nvim) Manage crates.io dependencies
 - **Markdown** [glow.nvim](https://github.com/ellisonleao/glow.nvim) Markdown Preview
 - **Latex** [vimtex](https://github.com/lervag/vimtex) Software system for typesetting `_ll` start compile, `_lv` view pdf 

