-- |||||||||||||||||||||||||||||||| Functions ||||||||||||||||||||||||||||||||| --

local M = {}

local fn = vim.fn
local cmd = vim.cmd
local map = vim.keymap.set
local timer = vim.loop.new_timer()

-- Select-All
function M.select_all()
  cmd("normal! VGo1G | gg0")
end

-- Trim
function M.trim()
  local save = fn.winsaveview()
  cmd("keeppatterns %s/\\s\\+$//e")
  fn.winrestview(save)
end

-- Auto-Save
function M.auto_save()
  if vim.bo.modified and fn.bufname("%") ~= "" and
      not timer:is_active() then
    timer:start(135, 0, vim.schedule_wrap(function()
      cmd("silent! wall")
    end))
  end
end

-- Jump-Brackets
function M.move_prev_pair()
  local backsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = fn.eval("searchpos('" .. backsearch .. "', 'b')")
  local lnum, col = search_result[1], search_result[2]
  fn.setpos('.', { 0, lnum, col, 0 })
end

function M.move_next_pair()
  local forwardsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = fn.eval("searchpos('" .. forwardsearch .. "', 'n')")
  local lnum, col = search_result[1], search_result[2]
  fn.setpos('.', { 0, lnum, col, 0 })
end

-- Code-Runner
function M.crunner_buffer()
  local crunner_buffers = vim.tbl_filter(function(buffer)
    return string.match(vim.api.nvim_buf_get_name(buffer), 'crunner')
  end, vim.api.nvim_list_bufs())
  return #crunner_buffers > 0 and "<cmd>RunClose<cr>" or "<cmd>RunCode<cr>"
end

-- Terminal-Esc
function M.terminal_esc(buffer)
  return string.match(fn.bufname("%"), "lazygit") and "<esc>" or "<C-\\><C-n>"
end

-- Toggle-Color-Column
function M.toggle_color_column()
  local bufnr = vim.api.nvim_get_current_buf()
  local ns_id = vim.api.nvim_create_namespace("ColorColumnToggle")
  local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {})
  local color_column_enabled = #extmarks > 0
  if not color_column_enabled then
    cmd("silent! highlight ColorColumn guifg=#1a1b26 guibg=#ff9e64")
    for i = 1, vim.api.nvim_buf_line_count(bufnr) do
      vim.api.nvim_buf_add_highlight(bufnr, ns_id, "ColorColumn", i - 1, 80, 81)
    end
  else
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  end
end

-- Clear-History
function M.clear_history()
  local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-\"*+#"
  for char in chars:gmatch(".") do fn.setreg(char, {}) end
  fn.histdel(":")
end

-- Swap
local entity_pattern = {}
entity_pattern.w = {}
entity_pattern.w._in = "\\w"
entity_pattern.w.out = "\\W"
entity_pattern.w.prev_end = "\\zs\\w\\W\\+$"
entity_pattern.k = {}
entity_pattern.k._in = "\\k"
entity_pattern.k.out = "\\k\\@!"
entity_pattern.k.prev_end = "\\k\\(\\k\\@!.\\)\\+$"

function M.swap_next(cursor_pos, type)
  type = type or "w"
  cursor_pos = cursor_pos or "follow"

  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local c = cursor[2]
  local line_before_cursor = line:sub(1, c + 1)

  local _in = entity_pattern[type]._in
  local out = entity_pattern[type].out

  local current_word_start = fn.match(line_before_cursor, _in .. "\\+$")
  local current_word_end = fn.match(line, _in .. out, current_word_start)
  if current_word_end == -1 then
    M.swap_prev()
    return
  end

  local next_word_start = fn.match(line, _in, current_word_end + 1)
  if next_word_start == -1 then
    M.swap_prev()
    return
  end
  local next_word_end = fn.match(line, _in .. out, next_word_start)
  next_word_end = next_word_end == -1 and #line - 1 or next_word_end

  local current_word = line:sub(current_word_start + 1, current_word_end + 1)
  local next_word = line:sub(next_word_start + 1, next_word_end + 1)

  local new_line = (current_word_start > 0 and line:sub(1, current_word_start) or "")
      .. next_word
      .. line:sub(current_word_end + 2, next_word_start)
      .. current_word
      .. line:sub(next_word_end + 2)

  local new_c = c
  if cursor_pos == "keep" then
    new_c = c + 1
  elseif cursor_pos == "follow" then
    new_c = c + next_word:len() + next_word_start - current_word_end
  elseif cursor_pos == "left" then
    new_c = current_word_start + 1
  elseif cursor_pos == "follow" then
    new_c = c + next_word:len() + next_word_start - current_word_end + current_word_start
  end

  vim.api.nvim_set_current_line(new_line)
  vim.api.nvim_win_set_cursor(0, { cursor[1], new_c - 1 })
end

function M.swap_prev(cursor_pos, type)
  type = type or "w"
  cursor_pos = cursor_pos or "follow"

  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local c = cursor[2]
  local line_before_cursor = line:sub(1, c + 1)

  local _in = entity_pattern[type]._in
  local out = entity_pattern[type].out
  local prev_end = entity_pattern[type].prev_end

  local current_word_start = fn.match(line_before_cursor, _in .. "\\+$")
  if current_word_start == -1 then
    M.swap_next()
    return
  end
  local current_word_end = fn.match(line, _in .. out, current_word_start)
  current_word_end = current_word_end == -1 and #line - 1 or current_word_end

  local prev_word_end = fn.match(line:sub(1, current_word_start), prev_end)
  if prev_word_end == -1 then
    M.swap_next()
    return
  end
  local prev_word_start = fn.match(line:sub(1, prev_word_end + 1), _in .. "\\+$")

  local current_word = line:sub(current_word_start + 1, current_word_end + 1)
  local prev_word = line:sub(prev_word_start + 1, prev_word_end + 1)

  local new_line = (prev_word_start > 0 and line:sub(1, prev_word_start) or "")
      .. current_word
      .. line:sub(prev_word_end + 2, current_word_start)
      .. prev_word
      .. line:sub(current_word_end + 2)

  local new_c = c
  if cursor_pos == "keep" then
    new_c = c + 1
  elseif cursor_pos == "follow" then
    new_c = c + prev_word_start - current_word_start + 1
  elseif cursor_pos == "left" then
    new_c = prev_word_start + 1
  elseif cursor_pos == "follow" then
    new_c = current_word:len() + current_word_start - prev_word_end + prev_word_start
  end

  vim.api.nvim_set_current_line(new_line)
  vim.api.nvim_win_set_cursor(0, { cursor[1], new_c - 1 })
end

-- Backspace
function M.backspace_improved()
  local command = "x"
  local curr_pos = vim.api.nvim_win_get_cursor(0)
  local curr_line = vim.api.nvim_get_current_line()
  if curr_pos[2] == 0 and curr_line:sub(1, 1) == "" then command = "X" end
  cmd(string.format('silent! normal! "_%s', fn.mode() == 'v' and 'x' or command))
end

-- Quit-Keymap
function M.special_keymaps()
  local included_filetypes = { "qf", "help", "man", "noice" }
  if vim.tbl_contains(included_filetypes, vim.bo.filetype) then
    map("n", "q", "<cmd>q!<CR>", { noremap = true, silent = true, buffer = 0 })
  end
  if string.match(fn.bufname("%"), 'lazygit') then
    map("t", "<leader>gg", "<esc>:q!<cr>", { noremap = true, silent = true, buffer = 0 })
  end
end

-- Cwd-Set-Options
function M.cwd_set_options()
  local excluded_file_types = { 'harpoon' }
  local excluded = vim.tbl_contains(excluded_file_types, vim.bo.filetype)
      or vim.bo.buftype == 'terminal' or not vim.bo.modifiable
  vim.g.copilot_no_tab_map = not excluded and true or nil
  vim.o.fo = not excluded and vim.o.fo:gsub("[cro]", "") or vim.o.fo
  if fn.isdirectory(fn.expand('%:h')) and not excluded then fn.chdir(fn.expand('%:h')) end
end

return M