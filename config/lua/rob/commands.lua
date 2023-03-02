local M = {}

-- Commands
local command = vim.api.nvim_create_user_command
command("Trim", "lua require('rob.functions').trim()", {})
command("SwapNext", "lua require('rob.functions').swap_next()", {})
command("SwapPrev", "lua require('rob.functions').swap_prev()", {})
command("LazyGitKeymap", "lua require('rob.functions').lazy()", {})
command("SelectAll", "lua require('rob.functions').select_all()", {})
command("MoveNext", "lua require('rob.functions').move_next_pair()", {})
command("MovePrev", "lua require('rob.functions').move_prev_pair()", {})
command("ClearHistory", "lua require('rob.functions').clear_history()", {})
command("Backspace", "lua require('rob.functions').backspace_improved()", {})

return M