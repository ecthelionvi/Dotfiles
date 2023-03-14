-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

-- Modules
local modules = {
  "lsp",
  "noice",
  "remaps",
  "lualine",
  "plugins",
  "project",
  "commands",
  "nvim-tree",
  "functions",
  "telescope",
  "which-key",
  "formatters",
  "treesitter",
  "toggleterm",
  "autocommands",
}

-- Options
local options = {
  tabstop = 2,
  cmdheight = 0,
  shiftwidth = 2,
  timeoutlen = 300,
  maxfuncdepth = 1000,
  fillchars = "eob: ",
  relativenumber = true,
}

local prefix = "rob."

local load = function(module)
  package.loaded[module] = nil
  return require(module)
end

for _, mod in ipairs(modules) do
  load(prefix .. mod)
end

for name, value in pairs(options) do
  vim.o[name] = value
end

return M