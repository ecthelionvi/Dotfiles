-- ||||||||||||||||||||||||||||||| Treesitter ||||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.treesitter.ensure_installed = { "vim", "regex" }
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter = {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v',
        ['@function.outer'] = 'V',
        ['@class.outer'] = '<c-v>',
      },
      include_surrounding_whitespace = true,
    },
  },
}

return M