-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

-- Require
require("rob.noice")
require("rob.remaps")
require("rob.plugins")
require("rob.functions")
require("rob.which-key")
require("rob.autocommands")

-- Settings
vim.opt.cmdheight = 0
vim.opt.timeoutlen = 300
vim.opt.maxfuncdepth = 1000
vim.opt.relativenumber = true
lvim.builtin.terminal.size = 12
vim.opt.fillchars = { eob = " " }
lvim.builtin.telescope.theme = nil
lvim.builtin.project.show_hidden = true
lvim.builtin.terminal.direction = 'horizontal'
lvim.builtin.nvimtree.setup.filters.dotfiles = true

-- Lualine
local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_x = {
  components.diagnostics,
  components.lsp,
  components.filetype,
}

-- Telescope
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "yank_history")
end
--lvim.builtin.telescope.defaults.layout_config.preview_width = 59

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = { "--fast" }, },
}

-- |||||||||||||||||||||||||||||||||| Defaults |||||||||||||||||||||||||||||||| --

-- General
vim.opt.tabstop = 2
lvim.leader = "space"
vim.opt.shiftwidth = 2
lvim.log.level = "info"
lvim.colorscheme = "lunar"
vim.opt.relativenumber = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.format_on_save.enabled = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.treesitter.auto_install = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

return M
