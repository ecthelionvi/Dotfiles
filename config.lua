-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

-- Settings
vim.g.mapleader = " "
vim.opt.cmdheight = 0
vim.opt.timeoutlen = 300
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = " " }
lvim.builtin.telescope.theme = nil

-- |||||||||||||||||||||||||||||||||| Defaults |||||||||||||||||||||||||||||||| --

-- General
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
vim.opt.tabstop = 2
lvim.leader = "space"
vim.opt.shiftwidth = 2
lvim.colorscheme = "lunar"
vim.opt.relativenumber = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.format_on_save.enabled = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.treesitter.auto_install = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- ||||||||||||||||||||||||||||||||| Keybinds ||||||||||||||||||||||||||||||||| --

-- Easy
vim.keymap.set("n", ";", ":", { noremap = true })

-- Redo
vim.keymap.set("n", "U", "<c-r>", { noremap = true })

-- Disable-Arrows
vim.keymap.set("x", "<up>", "", { noremap = true })
vim.keymap.set("x", "<down>", "", { noremap = true })
vim.keymap.set("x", "<left>", "", { noremap = true })
vim.keymap.set("x", "<right>", "", { noremap = true })

-- Append
vim.keymap.set("n", "<c-j>", "mzJ`z", { noremap = true })

-- HJKL
vim.keymap.set({ "n", "x" }, "J", "}", { noremap = true })
vim.keymap.set({ "n", "x" }, "K", "{", { noremap = true })
vim.keymap.set({ "n", "x" }, "H", "^", { noremap = true })
vim.keymap.set({ "n", "x" }, "L", "$", { noremap = true })

-- Vertal-Movement
vim.keymap.set("n", "<m-j>", "<c-d>zz", { noremap = true })
vim.keymap.set("n", "<m-k>", "<c-u>zz", { noremap = true })

-- Swap-O
vim.keymap.set("n", "<leader>o", "o", { noremap = true })
vim.keymap.set("n", "<leader>O", "O", { noremap = true })
vim.keymap.set("n", "o", "mzo<Esc>`z", { noremap = true })
vim.keymap.set("n", "O", "mzO<Esc>`z", { noremap = true })
vim.keymap.set("n", "<cr>", "mzo<Esc>`z", { noremap = true })
vim.keymap.set("n", "<s-cr>", "mzO<Esc>`z", { noremap = true })

-- Better-Backspace
vim.keymap.set({ "n", "x" }, "<bs>", [["_X]], { noremap = true })

-- Visual Highlight
vim.keymap.set({ "n", "x" }, "<m-a>", "VGo1G", { noremap = true })

-- Save
vim.keymap.set("n", "<c-s>", "<cmd>silent! w<cr>", { noremap = true })

-- GF
vim.keymap.set("n", "gf", "<cmd>e <cfile><cr>", { noremap = true, silent = true })

-- N-Movement
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, noremap = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, noremap = true })

-- Terminal-Esc
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("t", "<leader>q", "<cmd>q!<cr>", { noremap = true, silent = true })
vim.keymap.set("t", "<leader>gg", "<cmd>q!<cr>", { noremap = true, silent = true })

-- Esc Highlighting
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { noremap = true, silent = true })

-- Trim
vim.keymap.set("n", "<c-bs>", "<cmd>lua trim()<cr>", { noremap = true, silent = true })

-- Clear Registers
vim.keymap.set({ "n", "x" }, "Q", "<cmd>lua clear_registers()<cr>", { noremap = true })

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

-- Chmod
vim.keymap.set("n", "<leader>x", [[<cmd>silent exec "!(chmod +x % &)"<cr>]], {noremap = true})

-- Switch-Tabs
vim.keymap.set("n", "<m-h>", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<m-l>", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })

-- Dial
vim.keymap.set("n", "<c-a>", require("dial.map").inc_normal(), { noremap = true}, { silent = true })
vim.keymap.set("n", "<c-x>", require("dial.map").dec_normal(), { noremap = true}, { silent = true })
vim.keymap.set("x", "<c-a>", require("dial.map").inc_visual(), { noremap = true}, { silent = true })
vim.keymap.set("x", "<c-x>", require("dial.map").dec_visual(), { noremap = true}, { silent = true })
vim.keymap.set("x", "g<c-a>", require("dial.map").inc_gvisual(), { noremap = true}, { silent = true })
vim.keymap.set("x", "g<c-x>", require("dial.map").dec_gvisual(), { noremap = true}, { silent = true })

-- Search-Replace
vim.keymap.set("n", "cn", "*``cgn", { noremap = true })
vim.keymap.set("n", "cN", "#``cgN", { noremap = true })
vim.keymap.set('x', "cn", "y/\\V<C-R>=escape(@\", '/')<CR><CR>``cgn", { noremap = true, silent = true })
vim.keymap.set('x', "cN", "y/\\V<C-R>=escape(@\", '/')<CR><CR>``cgN", { noremap = true, silent = true })

-- Rnvimr
vim.keymap.set({ "n", "t" }, "<leader>.", "<cmd>RnvimrToggle<cr>", { noremap = true }, { silent = true })

-- Toggleterm
vim.keymap.set({ "n", "t" }, "<leader>\\", "<cmd>ToggleTerm()<cr>", { noremap = true }, { silent = true })

-- Wildmenu
vim.keymap.set("c", "<up>", [[wildmenumode() ? "\<left>" : "\<up>"]], { expr = true, noremap = true })
vim.keymap.set("c", "<down>", [[wildmenumode() ? "\<right>" : "\<down>"]], { expr = true, noremap = true })

-- Jump-Brackets
vim.keymap.set("n", "<tab>", "<esc><cmd>lua moveToNextPairs()<cr>", { noremap = true}, { silent = true })
vim.keymap.set("n", "<m-tab>", "<esc><cmd>lua moveToPrevPairs()<cr>", { noremap = true}, { silent = true })

-- Yanky
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", { noremap = true }, { silent = true })
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", { noremap = true }, { silent = true })
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { noremap = true }, { silent = true })
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)", { noremap = true }, { silent = true })
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", { noremap = true }, { silent = true })
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", { noremap = true }, { silent = true })
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)", { noremap = true }, { silent = true })
vim.keymap.set("x", "P", "<cmd>lua require('substitute').visual()<cr>", {noremap = true }, { silent = true })
vim.keymap.set("x", "p", "<cmd>lua require('substitute').visual()<cr>", {noremap = true } , { silent = true })

-- Color-Column
vim.keymap.set({ "n", "x" }, "<m-t>", "<cmd>lua toggle_color_column()<cr>", { noremap = true, silent = true })

-- Harpoon
vim.keymap.set("n", "dd", function()
  if vim.o.filetype ~= "harpoon" then
    return [["_dd]]
  else
    return [[<cmd>silent! normal! "_dd<cr>]]
  end
end, { expr = true, noremap = true, silent = true })
vim.keymap.set("n", "m", "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "\\", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true, silent = true })

-- Rename
vim.keymap.set("n", "<leader>rn", ":%s/\\<<C-r><C-w>\\>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>", { noremap = true })
vim.keymap.set("x", "<leader>rn", [[y:%s/<C-R>=escape(@",'/\') <CR>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]], { noremap = true })


--|||||||||||||||||||||||||||||||||| Plugins ||||||||||||||||||||||||||||||||||--

lvim.plugins = {
  {
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "github/copilot.vim",
    "kevinhwang91/rnvimr",
    "ThePrimeagen/harpoon",
    "kdheepak/lazygit.nvim",
    "ThePrimeagen/vim-be-good",
    "Vimjas/vim-python-pep8-indent",
    "christoomey/vim-tmux-navigator",
    "nvim-treesitter/nvim-treesitter-context",

    -- Trouble
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
      lazy = true,
    },

    -- Diffview
    {
      "sindrets/diffview.nvim",
      event = "BufRead",
    },

    -- Numb
    {
      "nacro90/numb.nvim",
      event = "BufRead",
      config = function()
        require("numb").setup {
          show_numbers = true,
          show_cursorline = true,
        }
      end
    },

    -- Cutlass
    {
      "gbprod/cutlass.nvim",
      config = function()
        require("cutlass").setup()
      end
    },

    -- Auto-Save
    {
      "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup()
      end
    },

    -- Better-Escape
    {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    },

    -- Stay-In-Place
    {
      "gbprod/stay-in-place.nvim",
      config = function()
        require("stay-in-place").setup()
      end
    },

    -- Move
    {
      "echasnovski/mini.nvim",
      config = function()
        require("mini.move").setup({
          mappings = {
            left = '<m-left>',
            right = '<m-right>',
            down = '<m-down>',
            up = '<m-up>',

            line_left = '<m-left>',
            line_right = '<m-right>',
            line_down = '<m-down>',
            line_up = '<m-up>',
          },
        })
      end
    },

    -- Yanky
    { "gbprod/yanky.nvim",
      config = function()
        require("yanky").setup({
          ring = {
            history_length = 100,
            storage = "shada",
            sync_with_numbered_registers = true,
            cancel_event = "update",
          },
          picker = {
            select = {
              action = nil,
            },
            telescope = {
              mappings = nil,
            },
          },
          system_clipboard = {
            sync_with_ring = false,
          },
          highlight = {
            on_put = true,
            on_yank = true,
            timer = 500,
          },
          preserve_cursor_position = {
            enabled = true,
          },
        })
      end
    },

    -- Dial
    {
      "monaqa/dial.nvim",
      event = "BufRead",
      config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group {
          default = {
            augend.integer.alias.hex,
            augend.constant.alias.alpha,
            augend.integer.alias.decimal,
            augend.date.alias["%m/%d/%Y"],
            augend.constant.new {
              elements = { "and", "or" },
              word = true,
              cyclic = true,
            },
            augend.constant.new {
              elements = { "&&", "||" },
              word = false,
              cyclic = true,
            },
            augend.constant.new {
              elements = { "true", "false" },
              word = true,
              cyclic = true,
            },
            augend.constant.new {
              elements = { "True", "False" },
              word = true,
              cyclic = true,
            },
          },
        }

      end
    },

    -- Nvim-Colorizer
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
          RGB = true,
          RRGGBB = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
        })
      end,
    },

    -- Nvim-Lastplace
    {
      "ethanholz/nvim-lastplace",
      event = "BufRead",
      config = function()
        require("nvim-lastplace").setup({
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", },
          lastplace_open_folds = true,
        })
      end,
    },

    -- Code-Runner
    {
      "CRAG666/code_runner.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require('code_runner').setup {
          mode = "toggle",
          focus = true,
          filetype_path = "", -- No default path defined
          filetype = {
            javascript = "node",
            java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
            c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
            cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
            python = "python -u",
            sh = "bash",
            rust = "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
          },
          project_path = "", -- No default path defined
          project = {},
          vim.keymap.set("n", "<leader>r", function()
            if vim.o.buftype == "terminal" then
              return "<cmd>RunClose<cr>"
            else
              return "<cmd>RunCode<cr>"
            end
          end, { expr = true, noremap = true, silent = true })
        }
      end,
    },

    -- TreeSJ
    {
      'Wansmer/treesj',
      requires = { 'nvim-treesitter' },
      config = function()
        require('treesj').setup()
      end,
      vim.keymap.set("n", "qq", "<cmd>TSJToggle<cr>", { noremap = true, silent = true })
    },

    -- Hop
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("hop").setup()
        vim.keymap.set("n", "S", "<cmd>HopWord<cr>", { noremap = true, silent = true })
        vim.keymap.set("n", "s", "<cmd>HopChar2<cr>", { noremap = true, silent = true })
      end,
    },

    -- Symbols-Outline
    {
      "simrat39/symbols-outline.nvim",
      config = function()
        require('symbols-outline').setup()
        vim.keymap.set("n", "<m-s>", "<cmd>SymbolsOutline<cr>", { noremap = true, silent = true })
        vim.keymap.set("v", "<m-s>", "<cmd>SymbolsOutline<cr>", { noremap = true, silent = true })
      end
    },

    -- Undotree
    {
      "mbbill/undotree",
      config = function()
        vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { noremap = true, silent = true })
      end,
    },

    -- Substitute
    {
      "gbprod/substitute.nvim",
      config = function()
        require("substitute").setup({
          on_substitute = function(event)
            require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
          end,
        })
        vim.keymap.set("n", "cxx", "<cmd>lua require('substitute.exchange').line()<cr>",
          { noremap = true, silent = true, })
        vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>",
          { noremap = true, silent = true, })
        vim.keymap.set("n", "cxc", "<cmd>lua require('substitute.exchange').cancel()<cr>",
          { noremap = true, silent = true, })
        vim.keymap.set("n", "cx", "<cmd>lua require('substitute.exchange').operator()<cr>",
          { noremap = true, silent = true, })
      end
    },
  },
}

-- |||||||||||||||||||||||||||||| Plugin Settings ||||||||||||||||||||||||||||| --

-- ToggleTerm
lvim.builtin.terminal.size = 12
lvim.builtin.terminal.direction = 'horizontal'

-- Nvimtree
lvim.builtin.nvimtree.setup.filters.dotfiles = true

-- Telescope
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "yank_history")
end

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = { "--fast" }, },
}

-- ||||||||||||||||||||||||||||||||| Functions |||||||||||||||||||||||||||||||| --

-- Trim
function trim()
  local save = vim.fn.winsaveview()
  vim.cmd("keeppatterns %s/\\s\\+$//e")
  vim.fn.winrestview(save)
end

-- Toggle-Color_Column
flag = false
function toggle_color_column()
  if flag then
    vim.cmd("silent! call clearmatches()")
    flag = false
  else
    vim.cmd [[silent! highlight ColorColumn guifg=#565f89 guibg=#565f89]]
    vim.fn.matchadd("ColorColumn", "\\%81v", 100)
    flag = true
  end
end

-- Jump-Brackets
function moveToNextPairs()
  local forwardsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = vim.fn.eval("searchpos('" .. forwardsearch .. "', 'n')")
  local lnum, col = search_result[1], search_result[2]
  vim.fn.setpos('.', { 0, lnum, col, 0 })
end

function moveToPrevPairs()
  local backsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = vim.fn.eval("searchpos('" .. backsearch .. "', 'b')")
  local lnum, col = search_result[1], search_result[2]
  vim.fn.setpos('.', { 0, lnum, col, 0 })
end

-- Clear-Registers
function clear_registers()
  local regs = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
    'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '/', '-', '"', '*', '+', '#', }
  for i, r in ipairs(regs) do
    vim.fn.setreg(r, {})
  end
end

-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

-- LSP-Popup
lvim.lsp.on_attach_callback = function(client, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

-- Legacy
vim.api.nvim_create_autocmd("vimenter", {
  group = vim.api.nvim_create_augroup("legacy", { clear = true }),
  callback = function()
    vim.schedule(function()
      clear_registers()
      vim.cmd [[
      ""===============[ Swap ]=================""

      let s:k_version = 201
      if &cp || (exists('g:loaded_swap_words')
        \ && (g:loaded_swap_words >= s:k_version)
        \ && !exists('g:force_reload_vim_tip_swap_word'))
        finish
      endif
      let g:swap_word_loaded = s:k_version

      nnoremap <silent> fl :call <sid>SwapWithNext('follow', 'w')<cr>
      nnoremap <silent> fh :call <sid>SwapWithPrev('follow', 'w')<cr>

      let s:k_entity_pattern = {}
      let s:k_entity_pattern.w = {}
      let s:k_entity_pattern.w.in = '\w'
      let s:k_entity_pattern.w.out = '\W'
      let s:k_entity_pattern.w.prev_end = '\zs\w\W\+$'
      let s:k_entity_pattern.k = {}
      let s:k_entity_pattern.k.in = '\k'
      let s:k_entity_pattern.k.out = '\k\@!'
      let s:k_entity_pattern.k.prev_end = '\k\(\k\@!.\)\+$'


      function! s:SwapWithNext(cursor_pos, type)
        let s = getline('.')
        let l = line('.')
        let c = col('.')-1
        let in  = s:k_entity_pattern[a:type].in
        let out = s:k_entity_pattern[a:type].out

        let crt_word_start = match(s[:c], in.'\+$')
        let crt_word_end  = match(s, in.out, crt_word_start)
        if crt_word_end == -1
          :normal fh
          return
        endif
        let next_word_start = match(s, in, crt_word_end+1)
        if next_word_start == -1
          :normal fh
          return
        endif
      let next_word_end  = match(s, in.out, next_word_start)
      let crt_word = s[crt_word_start : crt_word_end]
      let next_word = s[next_word_start : next_word_end]

      let s2 = (crt_word_start>0 ? s[:crt_word_start-1] : '')
        \ . next_word
        \ . s[crt_word_end+1 : next_word_start-1]
        \ . crt_word
        \ . (next_word_end==-1 ? '' : s[next_word_end+1 : -1])
      call setline(l, s2)
      if     a:cursor_pos == 'keep'   | let c2 = c+1
      elseif a:cursor_pos == 'follow' | let c2 = c + strlen(next_word) + (next_word_start-crt_word_end)
      elseif a:cursor_pos == 'left'   | let c2 = crt_word_start+1
      elseif a:cursor_pos == 'right'  | let c2 = strlen(next_word) + next_word_start - crt_word_end + crt_word_start
      endif
      call cursor(l,c2)
    endfunction

    function! s:SwapWithPrev(cursor_pos, type)
      let s = getline('.')
      let l = line('.')
      let c = col('.')-1
      let in  = s:k_entity_pattern[a:type].in
      let out = s:k_entity_pattern[a:type].out
      let prev_end = s:k_entity_pattern[a:type].prev_end

      let crt_word_start = match(s[:c], in.'\+$')
        if crt_word_start == -1
          :normal fl
          return
        endif
      let crt_word_end  = match(s, in.out, crt_word_start)
      let crt_word = s[crt_word_start : crt_word_end]

      let prev_word_end = match(s[:crt_word_start-1], prev_end)
      let prev_word_start = match(s[:prev_word_end], in.'\+$')
        if prev_word_end == -1
          :normal fl
          return
        endif
      let prev_word = s[prev_word_start : prev_word_end]

      let s2 = (prev_word_start>0 ? s[:prev_word_start-1] : '')
        \ . crt_word
        \ . s[prev_word_end+1 : crt_word_start-1]
        \ . prev_word
        \ . (crt_word_end==-1 ? '' : s[crt_word_end+1 : -1])
      call setline(l, s2)
      if     a:cursor_pos == 'keep'   | let c2 = c+1
      elseif a:cursor_pos == 'follow' | let c2 = prev_word_start + c - crt_word_start + 1
      elseif a:cursor_pos == 'left'   | let c2 = prev_word_start+1
      elseif a:cursor_pos == 'right'  | let c2 = strlen(crt_word) + crt_word_start - prev_word_end + prev_word_start
      endif
      call cursor(l,c2)
    endfunction]]
    end)
  end
})

return M
