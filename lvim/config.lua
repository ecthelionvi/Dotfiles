-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

local load = function(module)
  package.loaded[module] = nil
  return require(module)
end

-- Modules
load("rob.lsp")
load("rob.noice")
load("rob.remaps")
load("rob.lualine")
load("rob.plugins")
load("rob.project")
load("rob.commands")
load("rob.nvim-tree")
load("rob.functions")
load("rob.telescope")
load("rob.which-key")
load("rob.formatters")
load("rob.treesitter")
load("rob.toggleterm")
load("rob.autocommands")

-- Options
vim.o.tabstop = 2
vim.o.cmdheight = 0
vim.o.shiftwidth = 2
vim.o.timeoutlen = 300
vim.o.maxfuncdepth = 1000
vim.o.fillchars = "eob: "
vim.o.relativenumber = true

return M
