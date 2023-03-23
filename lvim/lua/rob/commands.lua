-- ||||||||||||||||||||||||||||||||| Commands ||||||||||||||||||||||||||||||||| --

local M = {}

local cmd = vim.api.nvim_create_user_command

-- Trim
cmd("Trim", "lua require('rob.utils').trim()", {})

-- Swap
cmd("SwapNext", "lua require('rob.utils').swap_next()", {})
cmd("SwapPrev", "lua require('rob.utils').swap_prev()", {})

-- Select-All
cmd("SelectAll", "lua require('rob.utils').select_all()", {})

-- Clear-History
cmd("ClearHistory", "lua require('rob.utils').clear_history()", {})

-- Jump-Brackets
cmd("MoveNext", "lua require('rob.utils').jump_brackets('next')", {})
cmd("MovePrev", "lua require('rob.utils').jump_brackets('prev')", {})

-- Backspace
cmd("Backspace", "lua require('rob.utils').backspace_improved()", {})

return M