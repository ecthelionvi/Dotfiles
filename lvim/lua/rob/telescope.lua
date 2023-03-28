-- |||||||||||||||||||||||||||||||| Telescope ||||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.telescope.theme = nil
lvim.builtin.telescope.defaults.path_display = { "tail" }
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "yank_history")
end
lvim.builtin.telescope.defaults.layout_config = { preview_width = 59 }
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git", ".npm", ".ssh", ".cups", ".cache", ".cargo", ".pyenv", ".vscode",
  ".rustup", ".android", ".DS_Store", ".localized", "site", "mason", "Caches",
  "Movies", "Library", "ftplugin", "sessions", "Reminders", "LaunchAgents",
  "node_modules", "nvim-lspconfig", "Mobile Documents", "com.apple.ProtectedCloudStorage",
}

return M