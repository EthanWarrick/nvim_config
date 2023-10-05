vim.opt.number = true -- Show line numbers
vim.opt.mouse = 'a' -- Turn on mouse mode
vim.opt.ignorecase = true -- Ignore capitalization when searching a file
vim.opt.smartcase = true -- Stop ignoring capitalization when searching a capital letter
vim.opt.hlsearch = false -- Highlight search term
vim.opt.wrap = true -- Wrap text
vim.opt.breakindent = true -- Preserve indentation when wrapping text
vim.opt.tabstop = 2 -- Tab size
vim.opt.shiftwidth = 2 -- Number of spaces for (auto)indent
vim.opt.expandtab = true -- Turn tab into spaces
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true -- Highlight the entire line containing the cursor
vim.opt.colorcolumn = '81' -- Highlight a vertical column for visual character limit

vim.opt.termguicolors = true

vim.g.editorconfig = true -- Enables .editorconfig files for project specific formatting
