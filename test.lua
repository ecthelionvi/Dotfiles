function _G.run_command_with_cursor_word_and_input_c_o()
  local word = vim.fn.expand("<cword>")
    vim.api.nvim_input(":%s/\\V" .. word .. "\\>//gI<Left><Left><Left>")
end



function _G.run_command_with_cursor_word_and_input_c_o()
  local word = vim.api.nvim_call_function("expand", {"<cword>"})
  local new_word = vim.api.nvim_call_function("input", {"Replace " .. word .. " with: "})
  local pos = vim.api.nvim_win_get_cursor(0)

  -- Use the substitute command to replace all occurrences of the current word with the new word
  vim.api.nvim_command(":%s/\\V" .. word .. "\\>/" .. new_word .. "/g")

  -- Return the cursor to its original position
  vim.api.nvim_win_set_cursor(0, pos)
end


function _G.run_command_with_cursor_word_and_input_c_o()
  local word = vim.api.nvim_call_function("expand", {"<cword>"})
  local pos = vim.api.nvim_win_get_cursor(0)
  local buf = vim.api.nvim_get_current_buf()

  local new_word = vim.api.nvim_call_function("input", {"Replace " .. word .. " with: "})

  -- Use the substitute command to replace all occurrences of the current word with the new word
  vim.api.nvim_command(":%s/\\V" .. word .. "\\>/" .. new_word .. "/g")

  -- Return the cursor to its original position
  vim.api.nvim_win_set_cursor(0, pos)
end


function _G.run_command_with_cursor_word_and_input_c_o()
  local word = vim.api.nvim_call_function("expand", {"<cword>"})
  local pos = vim.api.nvim_win_get_cursor(0)
  --local new_word = vim.api.nvim_call_function("input", {"Replace " .. word .. " with: "})

  -- Use the substitute command to replace all occurrences of the current word with the new word
  --vim.api.nvim_input(":%s/\\V" .. word .. "\\>/" .. new_word .. "/g")

  vim.api.nvim_input(":%s/\\V" .. word .. "\\>//gI<Left><Left><Left>")
  
  vim.schedule(vim.api.nvim_win_set_cursor(0, pos))
  -- Return the cursor to its original position
  --vim.api.nvim_win_set_cursor(0, pos)
end