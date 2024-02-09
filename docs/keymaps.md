# Keybindings

### Mode Reference
| Abbreviation | Mode |
| --- | --- |
| n | Normal |
| v | Visual and Select |
| s | Select |
| x | Visual |
| o | Operator-pending |
| i | Insert |
| l | Insert, Command-line, Lang-Arg |
| c | Command-line |
| t | Terminal |

#### Leader key: `Space`.

| Mode | Keymap | Description | Detail |
| --- | --- | --- | --- |

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>h` | Go to first non empty character in line |
| Normal | `<leader>l` | Go to last non empty character in line |
| Normal | `<leader>a` | Select all text |
| Normal | `gy` | Copy selected text to clipboard |
| Normal | `gp` | Paste clipboard content |
| Normal | `<leader>w` | Save file |
| Normal | `<leader>bq` | Close current buffer |
| Normal | `<leader>bc` | Close current buffer while preserving the window layout |
| Normal | `<leader>bl` | Go to last active buffer |
| Normal | `<leader>?` | Search oldfiles history |
| Normal | `<leader><space>` | Search open buffers |
| Normal | `<leader>ff` | Find file in current working directory |
| Normal | `<leader>fg` | Search pattern in current working directory. Interactive "grep search" |
| Normal | `<leader>fd` | Search diagnostics in current file |
| Normal | `<leader>fs` | Search pattern in current file |
| Normal | `<leader>e` | Open file explorer |
| Normal | `<Ctrl-g>` | Toggle the builtin terminal |
| Normal | `K` | Displays hover information about the symbol under the cursor |
| Normal | `gd` | Jump to the definition |
| Normal | `gD` | Jump to declaration |
| Normal | `gi` | Lists all the implementations for the symbol under the cursor |
| Normal | `go` | Jumps to the definition of the type symbol |
| Normal | `gr` | Lists all the references |
| Normal | `gs` | Displays a function's signature information |
| Normal | `<F2>` | Renames all references to the symbol under the cursor |
| Normal | `<F3>` | Format code in current buffer |
| Normal | `<F4>` | Selects a code action available at the current cursor position |
| Visual | `<F4>` | Selects a code action available in the selected text |
| Normal | `gl` | Show diagnostics in a floating window |
| Normal | `[d` | Move to the previous diagnostic |
| Normal | `]d` | Move to the next diagnostic |

### Autocomplete keybindings

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<Up>` | Move to previous item |
| Insert | `<Down>` | Move to next item |
| Insert | `<Ctrl-p>` | Move to previous item |
| Insert | `<Ctrl-n>` | Move to next item |
| Insert | `<Ctrl-u>` | Scroll up in documentation window |
| Insert | `<Ctrl-d>` | Scroll down in documentation window |
| Insert | `<Ctrl-e>` | Cancel completion |
| Insert | `<C-y>` | Confirm completion |
| Insert | `<Enter>` | Confirm completion |
| Insert | `<Ctrl-f>` | Go to next placeholder in snippet |
| Insert | `<Ctrl-b>` | Go to previous placeholder in snippet |
| Insert | `<Tab>` | If completion menu is open, go to next item. Else, open completion menu |
| Insert | `<Shift-Tab>` | If completion menu is open, go to previous item |

