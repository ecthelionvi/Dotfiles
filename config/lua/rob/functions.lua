local M = {}

-- Lazygit
function M.lazy()
local bufnr = vim.fn.bufnr("%")
vim.api.nvim_buf_set_keymap(
  bufnr,
  "t",
  "<leader>gg",
  "<esc>:q!<cr>",
  { silent = true }
)
end

-- Trim
function M.trim()
  local save = vim.fn.winsaveview()
  vim.cmd("keeppatterns %s/\\s\\+$//e")
  vim.fn.winrestview(save)
end

-- Highlight
function M.select_all()
  local mode = vim.api.nvim_get_mode()
  if mode['mode'] == 'n' then
    vim.api.nvim_command("normal! VGo1G")
  elseif mode['mode'] == 'v' then
    vim.api.nvim_command("normal! ggVG")
  end
end

-- Toggle-Color-Column
function M.toggle_color_column()
  local matches = vim.fn.getmatches()
  if #matches > 0 then
    vim.cmd("silent! call clearmatches()")
  else
    vim.cmd[[silent! highlight ColorColumn guifg=#565f89 guibg=#565f89]]
    vim.fn.matchadd("ColorColumn", "\\%81v", 100)
  end
end

-- Excluded-Filetypes
function M.is_excluded_filetype()
  local ft = vim.bo.filetype
  local excluded_file_types = { 'help', 'alpha', 'lazy', 'lazygit', 'rnvimr' }
  for _, excluded_ft in ipairs(excluded_file_types) do
    if string.match(ft, excluded_ft) then
      return true
    end
  end
  return false
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

  local current_word_start = vim.fn.match(line_before_cursor, _in .. "\\+$")
  local current_word_end = vim.fn.match(line, _in .. out, current_word_start)
  if current_word_end == -1 then
    M.swap_prev()
    return
  end

  local next_word_start = vim.fn.match(line, _in, current_word_end + 1)
  if next_word_start == -1 then
    M.swap_prev()
    return
  end
  local next_word_end = vim.fn.match(line, _in .. out, next_word_start)
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

  local current_word_start = vim.fn.match(line_before_cursor, _in .. "\\+$")
  if current_word_start == -1 then
    M.swap_next()
    return
  end
  local current_word_end = vim.fn.match(line, _in .. out, current_word_start)
  current_word_end = current_word_end == -1 and #line - 1 or current_word_end

  local prev_word_end = vim.fn.match(line:sub(1, current_word_start), prev_end)
  if prev_word_end == -1 then
   M.swap_next()
    return
  end
  local prev_word_start = vim.fn.match(line:sub(1, prev_word_end + 1), _in .. "\\+$")

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

-- Jump-Brackets
function M.move_next_pair()
  local forwardsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = vim.fn.eval("searchpos('" .. forwardsearch .. "', 'n')")
  local lnum, col = search_result[1], search_result[2]
  vim.fn.setpos('.', { 0, lnum, col, 0 })
end

function M.move_prev_pair()
  local backsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = vim.fn.eval("searchpos('" .. backsearch .. "', 'b')")
  local lnum, col = search_result[1], search_result[2]
  vim.fn.setpos('.', { 0, lnum, col, 0 })
end

-- Clear-History
function M.clear_history()
  local regs = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
    'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '/', '-', '"', '*', '+',
    '#',}
  for i, r in ipairs(regs) do
    vim.fn.setreg(r, {})
  end
  vim.fn.histdel(":")
end

return M