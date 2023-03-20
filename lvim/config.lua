-- |||||||||||||||||||||||||||||||||| Config |||||||||||||||||||||||||||||||||| --

local M = {}

-- Modules
require("rob.lsp")
require("rob.noice")
require("rob.utils")
require("rob.remaps")
require("rob.lualine")
require("rob.plugins")
require("rob.project")
require("rob.commands")
require("rob.nvim-tree")
require("rob.telescope")
require("rob.which-key")
require("rob.formatters")
require("rob.treesitter")
require("rob.toggleterm")
require("rob.autocommands")

-- Options
vim.o.tabstop = 2
vim.o.cmdheight = 0
vim.o.shiftwidth = 2
vim.o.timeoutlen = 300
vim.o.maxfuncdepth = 1000
vim.o.fillchars = "eob: "
vim.g.color_column = true
vim.o.relativenumber = true

return M