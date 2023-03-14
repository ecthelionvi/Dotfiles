-- |||||||||||||||||||||||||||||||| Telescope ||||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.telescope.theme = nil
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "yank_history")
end
lvim.builtin.telescope.defaults.layout_config = { preview_width = 59 }


return M