--|||||||||||||||||||||||||||||||||| Plugins ||||||||||||||||||||||||||||||||||--

local M = {}

lvim.plugins = {
  {
    "tpope/vim-repeat",
    "folke/noice.nvim",
    "wellle/targets.vim",
    "tpope/vim-surround",
    "rcarriga/nvim-notify",
    "MunifTanjim/nui.nvim",
    "kdheepak/lazygit.nvim",
    "ThePrimeagen/vim-be-good",
    "Vimjas/vim-python-pep8-indent",
    "nvim-treesitter/nvim-treesitter-context",

    -- Trouble
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
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
        require("cutlass").setup({
          exclude = { "ns", "nS" },
        })
      end
    },

    -- Auto-Save
    {
      "ecthelionvi/auto-save.nvim",
      config = function()
        require("auto-save").setup()
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

    -- Copilot
    {
      "github/copilot.vim",
      config = function()
        vim.cmd [[
      let g:copilot_filetypes = {
        \ '': v:false,
        \ 'TelescopePrompt': v:false,
        \ 'TelescopeResults': v:false,
        \ 'lazy': v:false,
        \ }

      let g:copilot_no_tab_map = v:true
      inoremap <silent><script><expr> <s-cr> copilot#Accept("\<CR>")
      ]]
      end
    },

    -- Quick-Fix
    {
      "romainl/vim-qf",
      config = function()
        vim.api.nvim_create_autocmd("filetype", {
          group = vim.api.nvim_create_augroup("quickfix", { clear = true }),
          pattern = "qf",
          callback = function()
            local bufnr = vim.fn.bufnr("%")
            vim.api.nvim_buf_set_keymap(
              bufnr,
              "n",
              "dd",
              ":.Reject<cr>",
              { silent = true }
            )
            vim.api.nvim_buf_set_keymap(
              bufnr,
              "n",
              "bd",
              ":Keep ''<cr>",
              { silent = true }
            )
            vim.g.qf_auto_resize = 0
          end
        })
      end
    },

    -- Yanky
    { "ecthelionvi/yanky.nvim",
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
        vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", { noremap = true }, { silent = true })
        vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", { noremap = true }, { silent = true })
        vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { noremap = true }, { silent = true })
        vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", { noremap = true }, { silent = true })
        vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", { noremap = true }, { silent = true })
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { noremap = true }, { silent = true })
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { noremap = true }, { silent = true })
        vim.keymap.set("x", "P", ":lua require('substitute').visual()<cr>", { noremap = true }, { silent = true })
        vim.keymap.set("x", "p", ":lua require('substitute').visual()<cr>", { noremap = true }, { silent = true })
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

    -- Hop
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("hop").setup()
        vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      end,
    },

    -- TreeSJ
    {
      'Wansmer/treesj',
      requires = { 'nvim-treesitter' },
      config = function()
        require('treesj').setup()
      end,
      vim.keymap.set("n", "qq", ":TSJToggle<cr>", { noremap = true, silent = true })
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

    -- Harpoon
    {
      "ThePrimeagen/harpoon",
      config = function()
        vim.keymap.set("n", "m", [[:lua require('harpoon.mark').add_file()<cr>]],
          { noremap = true, silent = true })
        vim.keymap.set("n", "\\", [[:lua require('harpoon.ui').toggle_quick_menu()<cr>]],
          { noremap = true, silent = true })
      end
    },

    -- Symbols-Outline
    {
      "simrat39/symbols-outline.nvim",
      config = function()
        require('symbols-outline').setup()
        vim.keymap.set("n", "<m-s>", [[:lua require('functions').silent("SymbolsOutline")<cr>]],
          { noremap = true, silent = true })
        vim.keymap.set("v", "<m-s>", [[:lua require('functions').silent("SymbolsOutline")<cr>]],
          { noremap = true, silent = true })
      end
    },

    -- Undotree
    {
      "mbbill/undotree",
      config = function()
        vim.g.undotree_SetFocusWhenToggle = 1,
        vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { noremap = true, silent = true })
      end,
    },

    -- Substitute
    {
      "gbprod/substitute.nvim",
      config = function()
        require("substitute").setup({
        vim.keymap.set("n", "cxx", ":lua require('substitute.exchange').line()<cr>",
          { noremap = true, silent = true, }),
        vim.keymap.set("x", "X", ":lua require('substitute.exchange').visual()<cr>",
          { noremap = true, silent = true, }),
        vim.keymap.set("n", "cxc", ":lua require('substitute.exchange').cancel()<cr>",
          { noremap = true, silent = true, }),
        vim.keymap.set("n", "cx", ":lua require('substitute.exchange').operator()<cr>",
          { noremap = true, silent = true, }),
          on_substitute = function(event)
            require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
          end,
        })
      end
    },

    -- Code-Runner
    {
      "CRAG666/code_runner.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require('code_runner').setup {
          mode = "term",
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
          vim.api.nvim_set_keymap("n", "<leader>r", [[&filetype == "" ? ":RunClose<cr>" : ":RunCode<cr>"]],
            { expr = true, noremap = true, silent = true })
        }
      end,
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
        vim.keymap.set("n", "<c-a>", require("dial.map").inc_normal(), { noremap = true }, { silent = true })
        vim.keymap.set("n", "<c-x>", require("dial.map").dec_normal(), { noremap = true }, { silent = true })
        vim.keymap.set("x", "<c-a>", require("dial.map").inc_visual(), { noremap = true }, { silent = true })
        vim.keymap.set("x", "<c-x>", require("dial.map").dec_visual(), { noremap = true }, { silent = true })
        vim.keymap.set("x", "g<c-a>", require("dial.map").inc_gvisual(), { noremap = true }, { silent = true })
        vim.keymap.set("x", "g<c-x>", require("dial.map").dec_gvisual(), { noremap = true }, { silent = true })
      end
    },

    --Rnvimr
    {
      "ecthelionvi/rnvimr",
      config = function()
        vim.api.nvim_set_keymap("n", "<leader>.", [[&filetype == "" ? ":RnvimrToggle<cr>" : ":RnvimrToggle<cr>"]],
          { expr = true, noremap = true, silent = true })
      end
    },
  },
}

return M