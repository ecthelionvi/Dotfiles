-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

-- Settings
vim.opt.cmdheight = 0
vim.opt.timeoutlen = 300
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = " " }
lvim.builtin.telescope.theme = nil

local remaps = require("remaps")
local plugins = require("plugins")
local functions = require("functions")
local autocommands = require("autocommands")

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
