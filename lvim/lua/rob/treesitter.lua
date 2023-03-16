-- ||||||||||||||||||||||||||||||| Treesitter ||||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ensure_installed = { "vim", "regex" }

return M