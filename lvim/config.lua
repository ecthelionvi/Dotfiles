-- |||||||||||||||||||||||||||||||||| Config |||||||||||||||||||||||||||||||||| --

local M = {}

-- Modules
reload("rob.lsp")
reload("rob.noice")
reload("rob.utils")
reload("rob.remaps")
reload("rob.lualine")
reload("rob.plugins")
reload("rob.project")
reload("rob.commands")
reload("rob.nvim-tree")
reload("rob.telescope")
reload("rob.which-key")
reload("rob.formatters")
reload("rob.treesitter")
reload("rob.toggleterm")
reload("rob.illuminate")
reload("rob.autocommands")

-- Options
vim.o.verbose = 0
vim.o.tabstop = 2
vim.o.cmdheight = 0
vim.o.shiftwidth = 2
vim.o.timeoutlen = 300
vim.o.maxfuncdepth = 1000
vim.o.fillchars = "eob: "
vim.g.color_column = true
vim.o.relativenumber = true
vim.opt.shortmess:append("FOW")

return M
