-- ||||||||||||||||||||||||||||||||| Commands ||||||||||||||||||||||||||||||||| --

local M = {}

local cmd = vim.api.nvim_create_user_command

-- Trim
cmd("Trim", "lua require('rob.utils').trim()", {})

-- Select-All
cmd("SelectAll", "lua require('rob.utils').select_all()", {})

-- Clear-History
cmd("ClearHistory", "lua require('rob.utils').clear_history()", {})

-- Jump-Brackets
cmd("MoveNext", "lua require('rob.utils').jump_brackets('next')", {})
cmd("MovePrev", "lua require('rob.utils').jump_brackets('prev')", {})

-- Clear-Hover
cmd("ClearHover", "lua require('rob.utils').close_hover_windows()", {})

-- Toggle-Relative-Number
cmd("ToggleRelativeNumber", "lua require('rob.utils').toggle_relative_number()", {})

return M
