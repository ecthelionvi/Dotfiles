-- |||||||||||||||||||||||||||||||||| Remaps |||||||||||||||||||||||||||||||||| --

local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Macro
map("n", "Q", "@q", opts)

-- Undo
map("n", "U", "<c-r>", opts)

-- Visual Backspace
map("x", "<bs>", '"_x', opts)

-- Movement
map({ "n", "x" }, "J", "}", opts)
map({ "n", "x" }, "K", "{", opts)
map({ "n", "x" }, "H", "^", opts)
map({ "n", "x" }, "L", "$", opts)

-- Visual-Arrows
map("x", "<up>", "<nop>", opts)
map("x", "<down>", "<nop>", opts)
map("x", "<left>", "<nop>", opts)
map("x", "<right>", "<nop>", opts)

-- Page-Up/Down
map("n", "<m-j>", "<c-d>zz", opts)
map("n", "<m-k>", "<c-u>zz", opts)

-- C-Yank
map({ "n", "x" }, "c", '"_c', opts)

-- Append
map("n", "<leader>j", "mzJ`z", opts)

-- Command Mode
map("n", ";", ":", { noremap = true })

-- Terminal-ESC
map("t", "<esc>", "<C-\\><C-n>", opts)

-- New-Buffer
map("n", "<m-t>", "<cmd>enew<cr>", opts)

-- Trim
map("n", "<c-bs>", "<cmd>Trim<cr>", opts)

-- Text-Object-Line
map("o", "il", "<Plug>(inner_line)", opts)
map("o", "al", "<Plug>(inner_line)", opts)
map("x", "il", "<Plug>(inner_line)o", opts)
map("x", "al", "<Plug>(inner_line)o", opts)

-- Swap
map("n", "zh", "<cmd>NeoSwapPrev<cr>", opts)
map("n", "zl", "<cmd>NeoSwapNext<cr>", opts)

-- Open-File
map("n", "gf", "<cmd>e <cfile><cr>", opts)

-- Newline
map("n", "<cr>", "<cmd>normal! o<cr>", opts)
map("n", "<s-cr>", "<cmd>normal! O<cr>", opts)

-- Jump-Brackets
map("n", "<tab>", "<cmd>MoveNext<cr>", opts)
map("n", "<s-tab>", "<cmd>MovePrev<cr>", opts)

-- Accelerated-JK
map("n", "j", "<Plug>(accelerated_jk_gj)", opts)
map("n", "k", "<Plug>(accelerated_jk_gk)", opts)

-- Select-All
map("x", "<leader>a", "<esc>", opts)
map("n", "<leader>a", "<cmd>SelectAll<cr>", opts)

-- Clear-History
map({ "n", "x" }, "Z", "<cmd>ClearHistory<cr>", opts)

-- Search-Movement
map("n", "n", "'Nn'[v:searchforward]", { expr = true })
map("n", "N", "'nN'[v:searchforward]", { expr = true })

-- Buffer-Navigation
map("n", "<m-h>", "<cmd>BufferLineCyclePrev<cr>", opts)
map("n", "<m-l>", "<cmd>BufferLineCycleNext<cr>", opts)

-- Change-Name
map("n", "cn", "*``cgn", opts)
map("n", "cN", "*``cgN", opts)
map("x", "cn", "y/\\V<c-r>=escape(@\", '/')<cr><cr>``cgn", opts)
map("x", "cN", "y/\\V<c-r>=escape(@\", '/')<cr><cr>``cgN", opts)

-- Highlight
map("n", "<esc>", "<cmd>nohlsearch<cr><cmd>ClearHover<cr>", opts)

-- Chmod-X
map("n", "<leader>x", "<cmd>silent exec '!(chmod +x % &)'<cr>", opts)

-- Visual-Comment
map("x", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", opts)

-- Toggle-Diagnostics-Float
map("n", "gk", function() require('rob.utils').toggle_lsp_buf_hover() end, opts)
map("n", "gl", function() require('rob.utils').toggle_diagnostic_hover() end, opts)

-- Wildmenu-Navigation
map("c", "<up>", function() return vim.fn.wildmenumode() and '<left>' or '<up>' end, { expr = true })
map("c", "<down>", function() return vim.fn.wildmenumode() and '<right>' or '<down>' end, { expr = true })

-- Rename
map("n", "<leader>rn",
  ":%s/\\<<c-r><c-w>\\>//g | norm g``<left><left><left><left><left><left><left><left><left><left><left><left><left>",
  { noremap = true })

map("x", "<leader>rn",
  "y:%s/<c-r>=escape(@\",'/\')<cr>//g | norm g``<left><left><left><left><left><left><left><left><left><left><left><left><left>",
  { noremap = true })

return M