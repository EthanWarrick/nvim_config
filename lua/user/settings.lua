-------------------------------- Status Column --------------------------------
-- This status column configuration consists of the sign column, the fold
--  column, and the line number column. The size of the sign and fold columns
--  are automatic. They are both only present if there is something to display
--  and are at minimum two and one characters wide, respectively. The size of
--  the line number column is wide enough to fit the max line number plus a
--  space. These were formatted using the functionality of status column. The
--  line number column shows the current line number for the current line and
--  relative line numbers for others. The current line number is preceeded by
--  zeros filling the whole line number column width. All line numbers are
--  aligned to the right.

vim.opt.statuscolumn = '%s%C%=%{%v:relnum?"%l":"%0"..(float2nr(log10(line("$")))+1).."l"%} '

-- Line Numbers
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.numberwidth = 1 -- Width for number column

-- Sign Column
vim.opt.signcolumn = "auto" -- Width for sign column

-- Fold Column
vim.opt.foldcolumn = "auto" -- Width for fold column
vim.opt.fillchars = { foldopen = "", foldclose = "" } -- Fold column characters
-------------------------------------------------------------------------------

------------------------------- Editor Behavior -------------------------------
vim.opt.mouse = "a" -- Turn on mouse mode

-- Project specific configuration files:
vim.g.editorconfig = true -- Enables .editorconfig files for project specific formatting
vim.opt.exrc = true -- Automatically execute trusted .nvim.lua and .nvimrc files in cwd

-- Default Tab Behavior
vim.opt.tabstop = 2 -- Tab size
vim.opt.shiftwidth = 2 -- Number of spaces for (auto)indent
vim.opt.expandtab = true -- Turn tab into spaces

-- Default User Interface Behavior
vim.opt.wrap = false -- Wrap text
vim.opt.breakindent = true -- Preserve indentation when wrapping text
vim.opt.cursorline = true -- Highlight the entire line containing the cursor
vim.opt.termguicolors = true -- Helps with displaying colors correctly

-- Searching Behavior
vim.opt.ignorecase = true -- Ignore capitalization when searching a file
vim.opt.smartcase = true -- Stop ignoring capitalization when searching a capital letter
vim.opt.hlsearch = true -- Highlight search term

-- Set command mode autocomplete behavior
--  Tab completes until the longest matching string, two tabs lists available commands,
--  then one more tab selects the first match from the list.
vim.opt.wildmode = "longest,longest,longest:full,full"

-- Show the following hidden characters
vim.opt.listchars = { trail = "-", nbsp = "+", tab = "▏ ", eol = "↴" }
vim.opt.list = false
-------------------------------------------------------------------------------
