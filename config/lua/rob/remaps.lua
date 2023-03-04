-- |||||||||||||||||||||||||||||||||| Remaps |||||||||||||||||||||||||||||||||| --

local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Undo
map("n", "U", "<c-r>", opts)

-- Movement
map({"n", "x"}, "J", "}", opts)
map({"n", "x"}, "K", "{", opts)
map({"n", "x"}, "H", "^", opts)
map({"n", "x"}, "L", "$", opts)

-- Visual-Arrows
map("x", "<up>", "<nop>", opts)
map("x", "<down>", "<nop>", opts)
map("x", "<left>", "<nop>", opts)
map("x", "<right>", "<nop>", opts)

-- Page-Up/Down
map("n", "<m-j>", "<c-d>zz", opts)
map("n", "<m-kt>", "<c-u>zz", opts)

-- Append
map("n", "<leader>j", "mzJ`z", opts)

-- Terminal-ESC
map("t", "<esc>", "<C-\\><C-n>", opts)

-- Command Mode
map("n", ";", ":", { noremap = true })

-- New-Buffer
map("n", "<m-t>", "<cmd>enew<cr>", opts)

-- Trim
map("n", "<c-bs>", "<cmd>Trim<cr>", opts)

-- Swap
map("n", "fh", "<cmd>SwapPrev<cr>", opts)
map("n", "fl", "<cmd>SwapNext<cr>", opts)

-- Open-File
map("n", "gf", "<cmd>e <cfile><cr>", opts)

-- Newline
map("n", "<cr>", "<cmd>normal! o<cr>", opts)
map("n", "<s-cr>", "<cmd>normal! O<cr>", opts)

-- Jump-Brackets
map("n", "<tab>", "<cmd>MoveNext<cr>", opts)
map("n", "<s-tab>", "<cmd>MovePrev<cr>", opts)

-- Highlight
map("n", "<esc>", "<cmd>nohlsearch<cr>", opts)

-- Accelerated-JK
map("n", "j", "<Plug>(accelerated_jk_gj)", opts)
map("n", "k", "<Plug>(accelerated_jk_gk)", opts)

-- Select-All
map("x", "<leader>a", "<esc>", opts)
map("n", "<leader>a", "<cmd>SelectAll<cr>", opts)

-- Backspace
map({"n", "x"}, "<bs>", "<cmd>Backspace<cr>", opts)

-- Clear-History
map({"n", "x"}, "Q", "<cmd>ClearHistory<cr>", opts)

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

-- Chmod-X
map("n", "<leader>x", "<cmd>silent exec '!(chmod +x % &)'<cr>", opts)

-- LSP
lvim.lsp.buffer_mappings.normal_mode['K'] = nil
lvim.lsp.buffer_mappings.normal_mode['gk'] = { vim.lsp.buf.hover, "Show hover" }

-- Wildmenu-Navigation
map("c", "<up>", function() return vim.fn.wildmenumode() and '<left>' or '<up>' end, { expr = true })
map("c", "<down>", function() return vim.fn.wildmenumode() and '<right>' or '<down>' end, { expr = true })

-- Rename
map("n", "<leader>rn", ":%s/\\<<c-r><c-w>\\>//g | norm g``<left><left><left><left><left><left><left><left><left><left><left><left><left>", { noremap = true })
map("x", "<leader>rn", "y:%s/<c-r>=escape(@\",'/\')<cr>//g | norm g``<left><left><left><left><left><left><left><left><left><left><left><left><left>", { noremap = true })

return M