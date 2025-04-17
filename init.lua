local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

-- Add a nvim specific bin directory for packages
-- installed in this config.
local bin_dir = vim.fn.stdpath("data") .. "/bin"
vim.fn.mkdir(bin_dir, "p")
if not string.find(vim.env.PATH, bin_dir) then
  vim.env.PATH = bin_dir .. ":" .. vim.env.PATH
end

load("config.options")
load("config.commands")
load("config.keymaps")
require("config.lazy")

vim.cmd.colorscheme("onedark")
