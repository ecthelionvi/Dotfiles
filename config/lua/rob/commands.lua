local M = {}

local cmd = vim.api.nvim_create_user_command

-- Trim
cmd("Trim", "lua require('rob.functions').trim()", {})

-- Swap
cmd("SwapNext", "lua require('rob.functions').swap_next()", {})
cmd("SwapPrev", "lua require('rob.functions').swap_prev()", {})

-- LazyGitKeymap
cmd("LazyGitKeymap", "lua require('rob.functions').lazy()", {})

-- Select-All
cmd("SelectAll", "lua require('rob.functions').select_all()", {})

-- Jump-Brackets
cmd("MoveNext", "lua require('rob.functions').move_next_pair()", {})
cmd("MovePrev", "lua require('rob.functions').move_prev_pair()", {})

-- Clear-History
cmd("ClearHistory", "lua require('rob.functions').clear_history()", {})

-- Backspace
cmd("Backspace", "lua require('rob.functions').backspace_improved()", {})

return M