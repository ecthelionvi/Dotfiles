-- |||||||||||||||||||||||||||||||| Telescope ||||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.telescope.defaults.path_display = { "truncate" }
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "yank_history")
end


function M.construct_command_fd(base_command, exclusions)
  local command = vim.deepcopy(base_command)
  for _, exclusion in ipairs(exclusions) do
    table.insert(command, '--exclude')
    table.insert(command, exclusion)
  end
  return command
end

function M.construct_command_rg(base_command, exclusions)
  local command = vim.deepcopy(base_command)
  for _, exclusion in ipairs(exclusions) do
    table.insert(command, '--glob')
    table.insert(command, '!' .. exclusion .. '/')
  end
  return command
end

M.base_exclusions = {
  'node_modules', '.git', '.fig', 'Library', 'fish',
  '__pycache__', '.cache', '.zsh_sessions', '.DS_Store',
  '.localized', '.cursor', 'cursor_tutor', '.vscode', '.viminfo',
  '.rustup', '.nox', '.npm', '.python_history', '.coverage',
  '.gitignore', 'Movies', 'Music', 'Pictures', 'Applications (Parallels)',
  '.cargo', '.cups', '.ssh', 'Parallels', '.Trash', '.hushlogin',
  '.pytest_cache', '.dat', 'mason', '.fig.dotfiles.bak', '.pyenv',
}

lvim.builtin.telescope.pickers.find_files.find_command = M.construct_command_fd(
  { 'fd', '--type', 'f', '--hidden' },
  M.base_exclusions
)

lvim.builtin.telescope.defaults.vimgrep_arguments = M.construct_command_rg(
  { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden' },
  M.base_exclusions
)

return M
