-- |||||||||||||||||||||||||||||||||| Utils ||||||||||||||||||||||||||||||||||| --

local M = {}

local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

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

-- Toggle-Hover
function M.toggle_lsp_buf_hover()
  if M.close_hover_windows() then return end
  vim.lsp.buf.hover()
end

-- Toggle-Diagnostic-Float
function M.toggle_diagnostic_hover()
  if M.close_hover_windows() then return end
  local config = lvim.lsp.diagnostics.float
  config.scope = "line"
  vim.diagnostic.open_float(0, config)
end

-- Cwd-Set-Options
function M.cwd_set_options()
  local dir = fn.expand('%:h')
  vim.g.copilot_no_tab_map = true
  vim.o.fo = vim.o.fo:gsub("[cro]", "")
  if fn.isdirectory(dir) then fn.chdir(dir) end
end

-- Hide_Filetype
function M.hide_filetype()
  local ft = { "lazy", "harpoon",
    "NvimTree", "toggleterm", "TelescopePrompt" }
  if vim.tbl_contains(ft, vim.bo.filetype)
  then
    api.nvim_buf_set_option(0, 'filetype', '')
  end
end

-- Dashboard
function M.dashboard()
  local ft = vim.bo.filetype
  if M.count_buffers() == 0 and ft == "alpha" then
    return
  end
  cmd("Alpha")
end

-- Count-Buffers
function M.count_buffers()
  return vim.tbl_count(vim.tbl_filter(function(bufnr)
    return fn.buflisted(bufnr) == 1
  end, api.nvim_list_bufs()))
end

-- Close
function M.close_buffer()
  local bufnr = fn.bufnr("%")
  return M.count_buffers() == 1 and
      cmd('Alpha | bd ' .. bufnr) or cmd('BufferKill')
end

-- Close-Hover-Windows
function M.close_hover_windows()
  local win_ids = api.nvim_list_wins()
  local floating_wins = vim.tbl_filter(function(win_id)
    local win_config = api.nvim_win_get_config(win_id)
    return win_config.relative ~= ''
  end, win_ids)
  if vim.tbl_isempty(floating_wins) then return false end
  vim.tbl_map(function(bufnr)
    local buftype = api.nvim_buf_get_option(bufnr, 'buftype')
    local filetype = api.nvim_buf_get_option(bufnr, 'filetype')
    if buftype == 'nofile' and filetype ~= 'alpha' then
      api.nvim_buf_delete(bufnr, { force = true })
    end
  end, api.nvim_list_bufs())
  return true
end

-- Special-Keymaps
function M.special_keymaps()
  local bt = vim.bo.buftype
  local ft = vim.bo.filetype
  local bn = fn.bufname("%")

  if bt:match("acwrite") then
    map("n", "|", "<nop>", opts)
  end
  if bn:match("lazygit") then
    map("t", "<esc>", "<esc>", opts)
  end
  if bn:match("ranger") then
    map("t", "<esc>", "<cmd>clo!<cr>", opts)
  end
  if bt:match("nofile") and ft ~= "alpha" then
    map("n", "<esc>", "<cmd>clo!<cr>", opts)
  end
  if bn:match("NvimTree_") then
    map("n", "<leader>k", "<cmd>NvimTreeToggle<cr>", opts)
    map("n", "<leader>q", "<cmd>NvimTreeToggle<cr>", opts)
  end
  if vim.tbl_contains({ "qf", "help", "man", "noice" }, ft) then
    map("n", "q", "<cmd>clo!<cr>", opts)
  end
end

-- Code-Runner
function M.code_runner()
  local crunner_bufs = vim.tbl_filter(function(buffer)
    return string.match(fn.bufname(buffer), 'crunner')
  end, api.nvim_list_bufs())
  return #crunner_bufs > 0 and "<cmd>RunClose<cr>" or "<cmd>RunCode<cr>"
end

-- Jump-Brackets
function M.jump_brackets(dir)
  local pattern = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  dir = dir == "prev" and "b" or "n"
  local result = fn.eval("searchpos('" .. pattern .. "', '" .. dir .. "')")
  local lnum, col = result[1], result[2]
  fn.setpos('.', { 0, lnum, col, 0 })
end

-- Toggle-Diagnostics
function M.toggle_lsp_diagnostics()
  local bufnr = api.nvim_get_current_buf()
  local diagnostics_hidden = pcall(api.nvim_buf_get_var, bufnr, 'diagnostics_hidden')
      and api.nvim_buf_get_var(bufnr, 'diagnostics_hidden')
  api.nvim_buf_set_var(bufnr, 'diagnostics_hidden', not diagnostics_hidden)
  if diagnostics_hidden then vim.diagnostic.show() return end
  vim.diagnostic.hide()
end

-- Clear-History
function M.clear_history()
  local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-\"*+#"
  for char in chars:gmatch(".") do fn.setreg(char, {}) end 
  vim.cmd("messages clear")
  fn.histdel(":")
end

-- Close-Nvim-Tree
function M.close_nvim_tree()
  if M.count_buffers() == 0 and vim.tbl_count(vim.tbl_filter(function(win_id)
        return api.nvim_buf_get_name(api.nvim_win_get_buf(win_id)):match('NvimTree_')
      end, api.nvim_list_wins())) > 0 then
    cmd('NvimTreeToggle')
  end
end

return M