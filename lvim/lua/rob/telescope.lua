-- |||||||||||||||||||||||||||||||| Telescope ||||||||||||||||||||||||||||||||| --

local M = {}

local actions = require("lvim.utils.modules").require_on_exported_call "telescope.actions"
lvim.builtin.telescope.defaults.mappings.n = { ["<leader>q"] = actions.close }
lvim.builtin.telescope.defaults.layout_config = { preview_width = 59 }
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "yank_history")
end
lvim.builtin.telescope.theme = nil

return M