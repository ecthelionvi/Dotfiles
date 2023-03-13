-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

local load = function(module)
  package.loaded[module] = nil
  return require(module)
end

-- Load
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

-- |||||||||||||||||||||||||||||||||| Settings |||||||||||||||||||||||||||||||| --

-- Options
vim.opt.tabstop = 2
vim.opt.cmdheight = 0
vim.opt.shiftwidth = 2
vim.opt.timeoutlen = 300
vim.opt.maxfuncdepth = 1000
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = " " }

return M
