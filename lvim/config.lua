-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

-- Require
require("rob.noice")
require("rob.remaps")
require("rob.plugins")
require("rob.commands")
require("rob.functions")
require("rob.which-key")
require("rob.autocommands")

-- |||||||||||||||||||||||||||||||||| Settings |||||||||||||||||||||||||||||||| --

-- Options
vim.opt.tabstop = 2
vim.opt.cmdheight = 0
vim.opt.shiftwidth = 2
vim.opt.timeoutlen = 300
vim.opt.maxfuncdepth = 1000
vim.opt.relativenumber = true

-- Copilot
vim.g.copilot_no_tab_map = true

-- Lvim
lvim.leader = "space"
lvim.log.level = "info"
lvim.colorscheme = "lunar"
lvim.format_on_save.enabled = false

-- Alpha
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- Project
lvim.builtin.project.show_hidden = true

-- ToggleTerm
lvim.builtin.terminal.size = 12
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"

-- Treesitter
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ensure_installed = { "vim" }

-- Which-Key
lvim.builtin.which_key.setup.ignore_missing = true
lvim.builtin.which_key.setup.layout.align = "center"

-- Lualine
local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_x = {
  components.lsp,
  components.filetype,
  components.diagnostics,
}

-- Telescope
lvim.builtin.telescope.theme = nil
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "yank_history")
end

-- Nvim-Tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.filters.dotfiles = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = { "--fast" }, },
}

return M
