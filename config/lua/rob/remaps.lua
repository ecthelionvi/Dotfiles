-- |||||||||||||||||||||||||||||||||| Remaps |||||||||||||||||||||||||||||||||| --

local M = {}

vim.g.mapleader = " "

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
  [modes.insert_mode] = {
    ["<tab>"] = {
      cmd = "<c-tab>",
    },
  },
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
    ["<bs>"] = {
      cmd = '"_X',
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
    ["cn"] = {
      cmd = "y/\\V<C-R>=escape(@\", '/')<CR><CR>``cgn",
      opts = {silent = false}
    },
    ["cN"] = {
      cmd = "y/\\V<C-R>=escape(@\", '/')<CR><CR>``cgN",
      opts = {silent = false}
    },
    ["<leader>a"] = {
      cmd = ":lua require('rob.functions').select_all()<cr>",
    },
    ["Q"] = {
      cmd = ":lua require('rob.functions').clear_history()<cr>",
    },
    ["<leader>rn"] = {
      cmd = "y:%s/<C-R>=escape(@\",'/\')<CR>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
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
    ["<bs>"] = {
      cmd = '"_X',
    },
    ["<leader>j"] = {
      cmd = "mzJ`z",
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
    ["<leader>o"] = {
      cmd = "o",
    },
    ["<leader>O"] = {
      cmd = "O",
    },
    ["<m-j>"] = {
      cmd = "<c-d>zz",
    },
    ["<m-k>"] = {
      cmd = "<c-u>zz",
    },
    ["o"] = {
      cmd = "mzo<Esc>`z",
    },
    ["O"] = {
      cmd = "mzO<Esc>`z",
    },
    ["<cr>"] = {
      cmd = "mzo<Esc>`z",
    },
    ["<s-cr>"] = {
      cmd = "mzO<Esc>`z",
    },
    ["Z"] = {
      cmd = "mz:join<cr>`z",
    },
    ["gf"] = {
      cmd = ":e <cfile><cr>",
    },
    ["<c-s>"] = {
      cmd = ":silent! w<cr>",
    },
    [";"] = {
      cmd = ":",
      opts = {silent = false}
    },
    ["<esc>"] = {
      cmd = ":nohlsearch<cr>",
    },
    ["n"] = {
      cmd = "'Nn'[v:searchforward]",
      opts = {expr = true}
    },
    ["N"] = {
      cmd = "'nN'[v:searchforward]",
      opts = {expr = true}
    },
    ["<m-h>"] = {
      cmd = ":BufferLineCyclePrev<cr>",
    },
    ["<m-l>"] = {
      cmd = ":BufferLineCycleNext<cr>",
    },
    ["j"] = {
      cmd = "<Plug>(accelerated_jk_gj)",
    },
    ["k"] = {
      cmd = "<Plug>(accelerated_jk_gk)",
    },
    ["<leader>x"] = {
      cmd = ":silent exec '!(chmod +x % &)'<cr>",
    },
    ["<c-bs>"] = {
      cmd = ":lua require('rob.functions').trim()<cr>",
    },
    ["<leader>a"] = {
      cmd = ":lua require('rob.functions').select_all()<cr>",
    },
    ["fl"] = {
      cmd = ":lua require('rob.functions').swap_next()<cr>",
    },
    ["fh"] = {
      cmd = ":lua require('rob.functions').swap_prev()<cr>",
    },
    ["Q"] = {
      cmd = ":lua require('rob.functions').clear_history()<cr>",
    },
    ["<tab>"] = {
      cmd = ":lua require('rob.functions').move_next_pair()<cr>",
    },
    ["<s-tab>"] = {
      cmd = ":lua require('rob.functions').move_prev_pair()<cr>",
    },
    ["<leader>rn"] = {
      cmd = ":%s/\\<<C-r><C-w>\\>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
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
