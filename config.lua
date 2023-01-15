-- ||||||||||||||||||| /Users/rob/.config/lvim/config.lua ||||||||||||||||||||| --

local M = {}

-- Settings --
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
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.treesitter.auto_install = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- ||||||||||||||||||||||||||||||||| Keybinds ||||||||||||||||||||||||||||||||| --

-- Disable Q
lvim.keys.normal_mode["Q"] = ""
lvim.keys.visual_mode["Q"] = ""

-- Visual Movement
lvim.keys.visual_mode["J"] = ""
lvim.keys.visual_mode["K"] = ""
lvim.keys.visual_mode["J"] = "}"
lvim.keys.visual_mode["K"] = "{"
lvim.keys.visual_mode["H"] = ""
lvim.keys.visual_mode["L"] = ""
lvim.keys.visual_mode["H"] = "^"
lvim.keys.visual_mode["L"] = "$"

-- Yank in Selection
lvim.keys.normal_mode["Y"] = "yg$"

-- Search Navigation
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"

-- Redo
lvim.keys.normal_mode["U"] = "<C-r>"

-- Better Delete
lvim.keys.normal_mode["d"] = "d "
lvim.keys.normal_mode["X"] = "D"
lvim.keys.normal_mode["dd"] = "dd"
lvim.keys.normal_mode["xx"] = "dd"
lvim.keys.visual_block_mode["x"] = "d"

-- Swap O
lvim.keys.normal_mode["<leader>o"] = "o"
lvim.keys.normal_mode["<leader>O"] = "O"
lvim.keys.normal_mode["o"] = "mzo<Esc>`z"
lvim.keys.normal_mode["O"] = "mzO<Esc>`z"

-- Better Backspace
lvim.keys.normal_mode["<BS>"] = "x"
lvim.keys.visual_block_mode["<BS>"] = "x"

-- Vertal Movement
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"

-- Visual Highlight
lvim.keys.normal_mode["aa"] = "VGo1G"
lvim.keys.visual_block_mode["aa"] = "VGo1G"

-- Better Paste
lvim.keys.visual_block_mode["p"] = [["_dP]]

-- Terminal Esc
lvim.keys.term_mode["<esc>"] = [[<C-\><C-n>]]
lvim.keys.term_mode["<leader>q"] = "<cmd>q!<cr>"
lvim.keys.term_mode["<leader>\\"] = "<cmd>q!<cr>"

-- Trim
lvim.keys.normal_mode["<BS><BS>"] = "<cmd>lua trim()<cr>"

-- Esc Highlighting
lvim.keys.normal_mode["<esc>"] = [[<cmd>let @/ = ""<cr>]]

-- Yank Preserve Cursor
lvim.keys.visual_mode["y"] = "myy`y", { noremap = true }
lvim.keys.visual_mode["Y"] = "myY`y", { noremap = true }

-- Chmod
lvim.keys.normal_mode["<leader>x"] = "<cmd>!chmod +x %<cr>", { silent = true }

-- Dial
lvim.keys.normal_mode["<C-a>"] = "<Plug>(dial-increment)"
lvim.keys.normal_mode["<C-x>"] = "<Plug>(dial-decrement)"
lvim.keys.visual_mode["<C-a>"] = "<Plug>(dial-increment)"
lvim.keys.visual_mode["<C-x>"] = "<Plug>(dial-decrement)"
lvim.keys.visual_mode["g<C-a>"] = "g<Plug>(dial-increment)"
lvim.keys.visual_mode["g<C-x>"] = "g<Plug>(dial-decrement)"

-- Switch Tabs
lvim.keys.normal_mode["<M-l>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<M-h>"] = "<cmd>BufferLineCyclePrev<CR>"

-- Jump Brackets
lvim.keys.normal_mode["<Tab>"] = "<esc><cmd>lua moveToNextPairs()<cr>", { silent = true }
lvim.keys.normal_mode["<A-Tab>"] = "<esc><cmd>lua moveToPrevPairs()<cr>", { silent = true }

-- Which Key
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
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings.s.y = { "<cmd>Telescope yank_history<cr>", "Yank History" }
lvim.builtin.which_key.mappings.b.p = { "<cmd>BufferLinePick<cr>", "Pick which buffer to open" }
lvim.builtin.which_key.mappings.b.k = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" }

-- Yanky
lvim.keys.normal_mode["P"] = "<Plug>(YankyPutAfter)"
lvim.keys.normal_mode["p"] = "<Plug>(YankyPutBefore)"
lvim.keys.normal_mode["gp"] = "<Plug>(YankyGPutAfter)"
lvim.keys.normal_mode["gP"] = "<Plug>(YankyGPutBefore)"
lvim.keys.visual_block_mode["gp"] = "<Plug>(YankyGPutAfter)"
lvim.keys.normal_mode["<c-n>"] = "<Plug>(YankyCycleForward)"
lvim.keys.normal_mode["<c-p>"] = "<Plug>(YankyCycleBackward)"
lvim.keys.visual_block_mode["gP"] = "<Plug>(YankyGPutBefore)"
lvim.keys.visual_block_mode["p"] = "<cmd>lua require('substitute').visual()<cr>", { noremap = true }, { silent = true }
lvim.keys.visual_block_mode["P"] = "<cmd>lua require('substitute').visual()<cr>", { noremap = true }, { silent = true }

-- Rename
lvim.keys.normal_mode["<leader>rn"] = ":%s/\\<<C-r><C-w>\\>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>"
lvim.keys.visual_mode["<leader>rn"] = [[y:%s/<C-R>=escape(@",'/\') <CR>//g | norm g``<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]]

--|||||||||||||||||||||||||||||||||| Plugins ||||||||||||||||||||||||||||||||||--

lvim.plugins = {
  {
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "github/copilot.vim",
    "kevinhwang91/rnvimr",
    "ThePrimeagen/harpoon",
    "zirrostig/vim-schlepp",
    "kdheepak/lazygit.nvim",
    "ThePrimeagen/vim-be-good",
    "Vimjas/vim-python-pep8-indent",
    "christoomey/vim-tmux-navigator",

    ------------------------------------ Trouble -------------------------------------

    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },

    ------------------------------------ Diffview ------------------------------------

    {
      "sindrets/diffview.nvim",
      event = "BufRead",
    },

    -------------------------------------- Numb --------------------------------------

    {
      "nacro90/numb.nvim",
      event = "BufRead",
      config = function()
        require("numb").setup {
          show_numbers = true,
          show_cursorline = true,
        }
      end,
    },

    ------------------------------------ Cutlass -------------------------------------

    {
      "gbprod/cutlass.nvim",
      config = function()
        require("cutlass").setup({
          {
            cut_key = x,
            override_del = true,
            exclude = {},
          },
        })
      end
    },

    ------------------------------------ Auto-Save -----------------------------------

    {
      "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup()
      end,
    },

    --------------------------------- Better-Escape ----------------------------------

    {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    },

    ---------------------------------- Stay-In-Place ---------------------------------

    {
      "gbprod/stay-in-place.nvim",
      config = function()
        require("stay-in-place").setup()
      end
    },

    ------------------------------------- Yanky --------------------------------------

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
            sync_with_ring = true,
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

    ------------------------------------- Dial ---------------------------------------

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

    --------------------------------- Nvim-Colorizer ---------------------------------

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

    -------------------------------------- Hop ---------------------------------------

    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("hop").setup()
        vim.api.nvim_set_keymap("n", "s", "<cmd>HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "S", "<cmd>HopWord<cr>", { silent = true })
      end,
    },

    --------------------------------- Nvim-Lastplace ---------------------------------

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

    -------------------------------- Symbols-Outline ---------------------------------

    {
      "simrat39/symbols-outline.nvim",
      config = function()
        require('symbols-outline').setup()
        vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>SymbolsOutline<cr>", { silent = true })
        vim.api.nvim_set_keymap("v", "<C-s>", "<cmd>SymbolsOutline<cr>", { silent = true })
      end
    },

    ------------------------------------ TreeSJ --------------------------------------

    {
      'Wansmer/treesj',
      requires = { 'nvim-treesitter' },
      config = function()
        require('treesj').setup()
      end,
      vim.keymap.set("n", "qq", "<cmd>TSJToggle<cr>", { silent = true }, { noremap = true })
    },

    ------------------------------------ Undotree ------------------------------------

    {
      "mbbill/undotree",
      config = function()
        vim.api.nvim_set_keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { silent = true })
      end,
    },

    ----------------------------------- Code_Runner ----------------------------------

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
          end, { expr = true, silent = true, replace_keycodes = true })
        }
      end,
    },

    ------------------------------------ Legendary -----------------------------------

    {
      'mrjones2014/legendary.nvim',
      config = function()
        require('legendary').setup({
          keymaps = {
            { "$", "", opts = { noremap = true } },
            { "^", "", opts = { noremap = true } },
            { "{", "", opts = { noremap = true } },
            { "}", "", opts = { noremap = true } },
            { "K", "{", opts = { noremap = true } },
            { "J", "}", opts = { noremap = true } },
            { "H", "^", opts = { noremap = true } },
            { "L", "$", opts = { noremap = true } },
            { "<leader>.", "<cmd>RnvimrToggle<cr>", opts = { silent = true } },
            { "<C-a>", "mzJ`z", opts = { silent = true }, { noremap = true } },
            { "<leader>\\", "<cmd>ToggleTerm()<cr>", opts = { silent = true } },
            { "m", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts = { silent = true } },
            { "\\", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts = { silent = true } },
          },
        })
      end,
    },

    ----------------------------------- Substitute ------------------------------------

    {
      "gbprod/substitute.nvim",
      config = function()
        require("substitute").setup({
            on_substitute = function(event)
    require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
  end,
        })
        vim.keymap.set("n", "cxx", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
        vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })
        vim.keymap.set("n", "cxc", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
        vim.keymap.set("n", "cx", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
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

-------------------------------------- Trim --------------------------------------

function trim()
  local save = vim.fn.winsaveview()
  vim.cmd("keeppatterns %s/\\s\\+$//e")
  vim.fn.winrestview(save)
end

--------------------------------- Jump Brackets ----------------------------------

function moveToPrevPairs()
  local backsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = vim.fn.eval("searchpos('" .. backsearch .. "', 'b')")
  local lnum, col = search_result[1], search_result[2]
  vim.fn.setpos('.', { 0, lnum, col, 0 })
end

function moveToNextPairs()
  local forwardsearch = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  local search_result = vim.fn.eval("searchpos('" .. forwardsearch .. "', 'n')")
  local lnum, col = search_result[1], search_result[2]
  vim.fn.setpos('.', { 0, lnum, col, 0 })
end

----------------------------------- LSP Popup ------------------------------------

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

------------------------------------ Startup -------------------------------------

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("startup", { clear = true }),
  callback = function()
    vim.schedule(function()

      vim.cmd [[

      ""===============[ Easy ]=================""
      
      nnoremap ; :

      ""=============[ Schlepp ]================""

      vmap <silent><unique> <up>    <Plug>SchleppUp
      vmap <silent><unique> <down>  <Plug>SchleppDown
      vmap <silent><unique> <left>  <Plug>SchleppLeft
      vmap <silent><unique> <right> <Plug>SchleppRight

      ""==========[ Search-Replace ]============""

      nnoremap cn *``cgn
      nnoremap cN #``cgN
      vnoremap <expr> cn g:mc . "``cgn"
      vnoremap <expr> cN g:mc . "``cgN"
      let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"

      ""=============[ Wildmenu ]===============""

      cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
      cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"

      ""==========[ Search Movement ]===========""

      nnoremap  <silent><expr> n  'Nn'[v:searchforward] . ":call HLNext()\<CR>"
      nnoremap  <silent><expr> N  'nN'[v:searchforward] . ":call HLNext()\<CR>"

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