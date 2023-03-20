-- |||||||||||||||||||||||||||||||||| Utils ||||||||||||||||||||||||||||||||||| --

local M = {}

local fn = vim.fn
local cmd = vim.cmd
local enabled_bufs = {}
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
function M.jump_brackets(dir)
  local pattern = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  dir = dir == "prev" and "b" or "n"
  local result = fn.eval("searchpos('" .. pattern .. "', '" .. dir .. "')")
  local lnum, col = result[1], result[2]
  fn.setpos('.', { 0, lnum, col, 0 })
end

-- Code-Runner
function M.crunner_bufs()
  local crunner_bufs = vim.tbl_filter(function(buffer)
    return string.match(fn.bufname(buffer), 'crunner')
  end, vim.api.nvim_list_bufs())
  return #crunner_bufs > 0 and "<cmd>RunClose<cr>" or "<cmd>RunCode<cr>"
end

-- Cwd-Set-Options
function M.cwd_set_options()
  if M.cwd_excluded() then return end
  vim.g.copilot_no_tab_map = true
  vim.o.fo = vim.o.fo:gsub("[cro]", "")
  if fn.isdirectory(fn.expand('%:h')) then fn.chdir(fn.expand('%:h')) end
end

-- Cwd-Excluded
function M.cwd_excluded()
  local excluded_ft = { 'harpoon' }
  return vim.tbl_contains(excluded_ft, vim.bo.filetype) or not vim.bo.modifiable
end

-- Backspace
function M.backspace_improved()
  local command = "x"
  local curr_pos = vim.api.nvim_win_get_cursor(0)
  local curr_line = vim.api.nvim_get_current_line()
  if curr_pos[2] == 0 and curr_line:sub(1, 1) == "" then command = "X" end
  cmd(string.format('silent! normal! "_%s', fn.mode() == 'v' and 'x' or command))
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

-- Quit-Keymap
function M.special_keymaps()
  local included_filetypes = { "qf", "help", "man", "noice" }
  if vim.tbl_contains(included_filetypes, vim.bo.filetype) then
    map("n", "q", "<cmd>q!<CR>", { noremap = true, silent = true, buffer = 0 })
  end
  if string.match(fn.bufname("%"), 'lazygit') then
    map("t", "<esc>", "<esc>", { noremap = true, silent = true, buffer = 0 })
    map("t", "<leader>gg", "<esc>:q!<cr>", { noremap = true, silent = true, buffer = 0 })
  end
end

-- Toggle-Color-Column
function M.toggle_color_column()
  if M.excluded_bufs() then return end
  enabled_bufs[fn.bufnr('%')] = not enabled_bufs[fn.bufnr('%')]
  M.notify_color_column()
  M.apply_color_column()
end

-- Excluded-Buf
function M.excluded_bufs()
  local excluded_ft = { 'checkhealth', 'TelescopePrompt' }
  return vim.tbl_contains(excluded_ft, vim.bo.filetype) or not vim.bo.modifiable
end

-- Notify-Color-Column
function M.notify_color_column()
  vim.notify("ColorColumn " .. (enabled_bufs[fn.bufnr('%')] and "Enabled" or "Disabled"))
end

-- Apply-Color-Column
function M.apply_color_column()
  vim.cmd("silent! highlight ColorColumn guifg=#1a1b26 guibg=#ff9e64 | call clearmatches()")
  if not M.excluded_bufs() and enabled_bufs[fn.bufnr('%')] then fn.matchadd("ColorColumn", "\\%81v", 100) end
end

return M