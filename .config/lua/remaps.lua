-- |||||||||||||||||||||||||||||||||| Remaps |||||||||||||||||||||||||||||||||| --

local M = {}

vim.g.mapleader = " "

local modes = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  operator_pending_mode = generic_opts_any,
  term_mode = { silent = true },
}

local generic_opts_any = {noremap = true, silent = true}

local keymaps = {
  [modes.insert_mode] = {},
  [modes.term_mode] = {
    ["<esc>"] = {
      cmd = "<C-\\><C-n>",
    },
    ["<leader>q"] = {
      cmd = "<cmd>q!<cr>",
    },
    ["<leader>gg"] = {
      cmd = "<cmd>q!<cr>",
    },
    ["<leader>\\"] = {
      cmd = "<cmd>ToggleTerm()<cr>",
    },
  },
  [modes.command_mode] = {
    ["<up>"] = {
      cmd = "wildmenumode() ? '<left>' : '<up>'",
      opts = {expr = true}
    },
    ["<down>"] = {
      cmd = "wildmenumode() ? '<right>' : '<down>'",
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
    ["<m-a>"] = {
      cmd = "VGo1G",
    },
    ["cn"] = {
      cmd = "y/\\V<C-R>=escape(@\", '/')<CR><CR>``cgn",
      opts = {silent = false}
    },
    ["cN"] = {
      cmd = "y/\\V<C-R>=escape(@\", '/')<CR><CR>``cgN",
      opts = {silent = false}
    },
    ["Q"] = {
      cmd = ":lua require('functions').clear_history()<cr>",
    },
    ["<m-t>"] = {
      cmd = ":lua require('functions').toggle_color_column()<cr>",
    },
    ["<leader>rn"] = {
      cmd = "y:%s/<C-R>=escape(@\",'/\') <CR>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
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
    ["<m-a>"] = {
      cmd = "VGo1G",
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
    ["<m-bs>"] = {
      cmd = [[<c-^>'"zz]],
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
    ["<leader>\\"] = {
      cmd = ":ToggleTerm()<cr>",
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
    ["<leader>x"] = {
      cmd = ":silent exec '!(chmod +x % &)'<cr>",
    },
    ["<c-bs>"] = {
      cmd = ":lua require('functions').trim()<cr>",
    },
    ["fl"] = {
      cmd = ":lua require('functions').SwapWithNext()<cr>",
    },
    ["fh"] = {
      cmd = ":lua require('functions').SwapWithPrev()<cr>",
    },
    ["Q"] = {
      cmd = ":lua require('functions').clear_history()<cr>",
    },
    ["<tab>"] = {
      cmd = ":lua require('functions').moveToNextPairs()<cr>",
    },
    ["<m-tab>"] = {
      cmd = ":lua require('functions').moveToPrevPairs()<cr>",
    },
    ["<m-t>"] = {
      cmd = ":lua require('functions').toggle_color_column()<cr>",
    },
    ["<leader>rn"] = {
      cmd = ":%s/\\<<C-r><C-w>\\>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
    },
  },
}

-- |||||||||||||||||||||||||||||||| Which-Key ||||||||||||||||||||||||||||||||| --

-- Which-Key
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

lvim.builtin.which_key.mappings.s.p = {}
lvim.builtin.which_key.mappings.b.e = {}
lvim.builtin.which_key.mappings['T'] = {}
lvim.builtin.which_key.mappings['w'] = {}
lvim.builtin.which_key.mappings.l.p = { "<cmd>LspStop<cr>", "Stop" }
lvim.builtin.which_key.mappings.l.o = { "<cmd>LspStart<cr>", "Start" }
lvim.builtin.which_key.mappings.g.d = { "<cmd>DiffviewOpen<cr>", "Diffview" }
lvim.builtin.which_key.mappings.b.p = { "<cmd>BufferLinePick<cr>", "Pick Open" }
lvim.builtin.which_key.mappings["f"] = {
  function()
    require("lvim.core.telescope.custom-finders").find_project_files {}
  end,
  "Find File",
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings.b.k = { "<cmd>BufferLinePickClose<cr>", "Pick Close" }
lvim.builtin.which_key.mappings.s.y = { "<cmd>Telescope yank_history<cr>", "Yank History" }

function M.set_keymaps(mode, key, val)
  if type(val) == "table" then
    opt = val.opts or generic_opts[mode] or generic_opts_any
    val = val.cmd
  end
  if val then
    vim.api.nvim_set_keymap(mode, key, val, opt)
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
