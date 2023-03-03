-- |||||||||||||||||||||||||||||||||| Remaps |||||||||||||||||||||||||||||||||| --

local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local modes = {
  term_mode = "t",
  insert_mode = "i",
  normal_mode = "n",
  visual_mode = "v",
  command_mode = "c",
  visual_block_mode = "x",
  operator_pending_mode = "o",
}

local generic_opts = {
  term_mode = { silent = true },
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  command_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  operator_pending_mode = generic_opts_any,
}

local generic_opts_any = {noremap = true, silent = true}

local keymaps = {
  [modes.term_mode] = {
    ["<esc>"] = {
      cmd = [[<C-\><C-n>]],
    },
  },
  [modes.command_mode] = {
    ["<up>"] = {
      cmd = function() return vim.fn.wildmenumode() and '<left>' or '<up>' end,
      opts = {expr = true}
    },
    ["<down>"] = {
      cmd = function() return vim.fn.wildmenumode() and '<right>' or '<down>' end,
      opts = {expr = true}
    }
  },
  [modes.visual_block_mode] = {
    ["J"] = {
      cmd = "}",
    },
    ["K"] = {
      cmd = "{",
    },
    ["H"] = {
      cmd = "^",
    },
    ["L"] = {
      cmd = "$",
    },
    ["<up>"] = {
      cmd = "",
    },
    ["<down>"] = {
      cmd = "",
    },
    ["<left>"] = {
      cmd = "",
    },
    ["<right>"] = {
      cmd = "",
    },
    ["<leader>a"] = {
      cmd = "<cmd>SelectAll<cr>",
    },
    ["<bs>"] = {
      cmd = "<cmd>Backspace<cr>",
    },
    ["Q"] = {
      cmd = "<cmd>ClearHistory<cr>",
    },
    ["cn"] = {
      cmd = "y/\\V<c-r>=escape(@\", '/')<cr><cr>``cgn",
      opts = {silent = false}
    },
    ["cN"] = {
      cmd = "y/\\V<c-r>=escape(@\", '/')<cr><cr>``cgN",
      opts = {silent = false}
    },
    ["<leader>rn"] = {
      cmd = "y:%s/<c-r>=escape(@\",'/\')<cr>//g | norm g``<left><left><left><left><left><left><left><left><left><left><left><left><left>",
      opts = {silent = false}
    },
  },
  [modes.normal_mode] = {
    ["J"] = {
      cmd = "}",
    },
    ["K"] = {
      cmd = "{",
    },
    ["H"] = {
      cmd = "^",
    },
    ["L"] = {
      cmd = "$",
    },
    ["U"] = {
      cmd = "<c-r>",
    },
    ["cn"] = {
      cmd = "*``cgn",
    },
    ["cN"] = {
      cmd = "#``cgN",
    },
    ["<m-j>"] = {
      cmd = "<c-d>zz",
    },
    ["<m-k>"] = {
      cmd = "<c-u>zz",
    },
    ["<leader>j"] = {
      cmd = "mzJ`z",
    },
    ["<m-t>"] = {
      cmd = "<cmd>enew<cr>",
    },
    ["<c-bs>"] = {
      cmd = "<cmd>Trim<cr>",
    },
    [";"] = {
      cmd = ":",
      opts = {silent = false}
    },
    ["fl"] = {
      cmd = "<cmd>SwapNext<cr>",
    },
    ["fh"] = {
      cmd = "<cmd>SwapPrev<cr>",
    },
    ["<leader>a"] = {
      cmd = "<cmd>SelectAll<cr>",
    },
    ["<tab>"] = {
      cmd = "<cmd>MoveNext<cr>",
    },
    ["<s-tab>"] = {
      cmd = "<cmd>MovePrev<cr>",
    },
    ["<bs>"] = {
      cmd = "<cmd>Backspace<CR>",
    },
    ["gf"] = {
      cmd = "<cmd>e <cfile><cr>",
    },
    ["<c-s>"] = {
      cmd = "<cmd>silent! w<cr>",
    },
    ["<cr>"] = {
      cmd = "<cmd>normal! o<cr>",
    },
    ["<s-cr>"] = {
      cmd = "<cmd>normal! O<cr>",
    },
    ["<esc>"] = {
      cmd = "<cmd>nohlsearch<cr>",
    },
    ["Q"] = {
      cmd = "<cmd>ClearHistory<cr>",
    },
    ["n"] = {
      cmd = "'Nn'[v:searchforward]",
      opts = {expr = true}
    },
    ["N"] = {
      cmd = "'nN'[v:searchforward]",
      opts = {expr = true}
    },
    ["j"] = {
      cmd = "<Plug>(accelerated_jk_gj)",
    },
    ["k"] = {
      cmd = "<Plug>(accelerated_jk_gk)",
    },
    ["<m-h>"] = {
      cmd = "<cmd>BufferLineCyclePrev<cr>",
    },
    ["<m-l>"] = {
      cmd = "<cmd>BufferLineCycleNext<cr>",
    },
    ["<leader>x"] = {
      cmd = "<cmd>silent exec '!(chmod +x % &)'<cr>",
    },
    ["<leader>rn"] = {
      cmd = ":%s/\\<<c-r><c-w>\\>//g | norm g``<left><left><left><left><left><left><left><left><left><left><left><left><left>",
      opts = {silent = false}
    },
  },
}

-- ||||||||||||||||||||||||||||||||||| LSP |||||||||||||||||||||||||||||||||||| --

lvim.lsp.buffer_mappings.normal_mode['K'] = nil
lvim.lsp.buffer_mappings.normal_mode['gk'] = { vim.lsp.buf.hover, "Show hover" }

-- |||||||||||||||||||||||||||||||| Functions ||||||||||||||||||||||||||||||||| --

function M.set_keymaps(mode, key, val)
  if type(val) == "table" then
    opt = val.opts or generic_opts[mode] or generic_opts_any
    val = val.cmd
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

function M.load(keymaps)
  for mode, mappings in pairs(keymaps) do
    for mapping, data in pairs(mappings) do
      M.set_keymaps(mode, mapping, data)
    end
  end
end

M.load(keymaps)

return M
