# Neovim Configuration

My lua-based neovim configuration based on the starter code from [VonHeikemen](https://github.com/VonHeikemen/nvim-starter/tree/05-modular).

## Requirements

* Neovim v0.8 or greater.
* git.
* A `C` compiler. Can be `gcc`, `tcc` or `zig`.
* [make](https://www.gnu.org/software/make/), the build tool.
* python and pip
* [npm cli](https://docs.npmjs.com/cli/v8/commands/npm). Javascript package manager.
* [nodejs](https://nodejs.org/es/). Javascript runtime. Required by the language servers listed above.
* (optional) [ripgrep](https://github.com/BurntSushi/ripgrep). Improves project wide search speed.
* (optional) [fd](https://github.com/sharkdp/fd). Improves file search speed.
* (optional) A patched font to display icons. I hear [nerdfonts](https://www.nerdfonts.com/) has a good collection.

## Installation

* Backup your existing configuration if you have one.

* If you don't know the path of the Neovim configuration folder use this command.

```sh
nvim --headless -c 'echo stdpath("config") | quit'
```

* Now clone this repository in that location.

```sh
git clone https://github.com/EthanWarrick/nvim_config /tmp/nvim-config-path
```

> Do not execute this command as is. Replace `/tmp/nvim-config-path` with the correct path from the previous step.

* Next time you start Neovim all plugins will be downloaded automatically. After this process is done `nvim-treesitter` will install language parsers for treesitter. And, `mason.nvim` will download packages listed in the configuration. Use the command `:Mason` to check the download process of language servers. 

> If you are replacing an existing neovim config, you may need to delete the contents of `~/.local/share/nvim` and `~/.local/state/nvim`. Do this if you are receiving numerous errors immediately after installation. This file may contain unwanted runtime files from your previous config.

## Keybindings
[See here.](docs/keymaps.md)

## Plugin list
| Name | Description  |
| --- | --- |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments |
| [catppuccin]() | Colorscheme |
| [clangd_extensions.nvim]() | Extensions for the clangd LSP |
| [conform.nvim]() | Auto formatting |
| [fzf]() | Fuzzy Finder Command Line Tool |
| [fzf-lua]() | Fzf integration for nvim |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Shows indicators in gutter based on file changes detected by git |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Shows indent guides in current file |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [lazygit.nvim]() | Opens Lazygit within a neovim terminal floating window |
| [local-highlight.nvim]() | Highlights all occurances of the word under cursor |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Pretty statusline |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable package manager for Neovim |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Integrates nvim-lspconfig and mason.nvim |
| [neodev.nvim]() | Lua LSP control specifically for neovim configuration |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Neovim's LSP client  |
| [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) | File explorer |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Configures treesitter parsers. Provides modules to manipulate code |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Creates textobjects based on treesitter queries |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Helper functions to show icons |
| [oil.nvim]() | Netrw replacement - provides `ls` style file explorer/editor |
| [onedark.vim](https://github.com/navarasu/onedark.nvim) | Colorscheme based on Atom's default theme |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Collection of modules. Used internaly by other plugins |
| [targets.vim](https://github.com/wellle/targets.vim) | Creates new textobjects |
| [tint.nvim]() | Shade non-focused windows darker |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration into Neovim/Vim |
| [vim-grip]() | Provides keymaps to control the grip cmdline tool |
| [vim-repeat](https://github.com/tpope/vim-repeat) | Add "repeat" support for plugins |
| [vim-surround](https://github.com/tpope/vim-surround) | Add, remove, change "surroundings" |
| [vim-tmux-navigator]() | Provides keymaps to interface neovim windows with tmux |

### Disabled Plugins
| Name | Description  |
| --- | --- |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Pretty tabline |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | nvim-cmp source. Suggest words in the current buffer |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | nvim-cmp source. Show suggestions based on file system paths |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | nvim-cmp source. Show suggestions based on installed snippets |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | nvim-cmp source. Show suggestions based on LSP servers queries |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Collection of snippets |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Extension for telescope. Allows fzf-like syntax in searches |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Manage terminal windows easily |
| [vim-bbye](https://github.com/moll/vim-bbye) | Close buffers without closing the current window |
| [which-key.nvim]() | Shows live keymap suggestions |

## Mason package list
| Name | Description  |
| --- | --- |
| [clangd]() | C/C++ LSP |
| [lua-language-server]() | Lua LSP  |
| [marksman]() | Markdown LSP |
| [python-lsp-server]() | Python LSP |
| [ruff]() | Python Linter |
| [ruff-lsp]() | Ruff as LSP Diagnostics |
| [stylua]() | Lua Formatter |
| [typescript-language-server]() | Javascript/Typescript LSP |

## Motions vs Text-Objects
> **_NOTE:_**  This section is based on my current understanding of
vi/vim/neovim and may contradict official documentation.

This topic is somewhat relevant when trying to make keymaps. Motions and
text-objects often correspond, but this does not make them the same.
Essentially, motions *move* the cursor while text-objects define some *area* of
text. Typing `w` in **Normal Mode** performs a motion - it moves the cursor to
the next word. Typing `yw` performs the yank operator on the *text-object* `w`
representing the area of text from the initial cursor position to the next word.
In this way both the `w` motion and text-object correspond to each other - both
essentially mean 'from here to the next word'. They differ because because the
motion just moves the cursor and the text-object is the data structure
specifying an area of text passed to the operator.

Another way to consider this is with modes. Motions are performed in **Normal
Mode** and text-objects are given in **Operator-Pending Mode**. As a reminder,
operators are commands like `y` (yank) and `d` (delete) while **Operator-Pending
Mode** is the mode entered after an operator is performed. **Operator-Pending
Mode** is specifically for supplying text-objects on which the given operator is
performed. Operators are specifically distinguished from other vim commands
because they initiate **Operator-Pending Mode** and perform their function on a
text-object. Alternatively, non-operator vim commands include anything not
operating on a text object. The command `i` (enter insert mode) isn't an
operator because is isn't performed on a group of text. The command `r` isn't an
operator because it only changes a single character.

**Visual Mode** is kind of a special case that seems to except both motions and
text objects. I believe that, actually, **Visual Mode** just has additional,
corresponding keymappings to represent the selection one would expect.
The selections made in **Visual Mode** can be passed to an operator as the
needed text-object.

All of this is to say that three keymappings are needed to implement custom
keymaps emulating the standard vim motion/text-object functionality. 

1. **Normal Mode** keymap: This is to provide the motion functionality - where
you want the cursor to end up.
2. **Operator-Pending Mode** keymap: This is to provide the text selection
passed to an operator performed from normal mode.
3. **Visual Mode** keymap: This is select the desired text within visual mode.

These keymappings likely will need to be setup to perform specific commands or
functions to make the desired movement and grab the desired text. A useful way
to make text selections in **Operator-Pending Mode** is mapping to the `:normal`
command followed by some visual mode selection. This allows for full text
selection with some predefined visual mode sequence.
