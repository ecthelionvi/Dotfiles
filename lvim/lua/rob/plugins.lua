-- ||||||||||||||||||||||||||||||||| Plugins |||||||||||||||||||||||||||||||||| --

local M = {}

local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opts = { noremap = true, silent = true }

local need = function(module)
  return require(module)
end

lvim.plugins = {

  -- Repeat
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  -- Accerlated-JK
  {
    "rhysd/accelerated-jk",
    event = "VeryLazy",
  },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  -- Noice
  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },

  -- Vim-Be-Good
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
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

  -- Notify
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        timeout = 500,
      })        
    end
  },

  -- Cutlass
  {
    "gbprod/cutlass.nvim",
    event = "VeryLazy",
    config = function()
      require("cutlass").setup({
        exclude = { "ns", "nS" },
      })
    end
  },

  -- Mini
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
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

  -- Python-Indent
  {
    "Vimjas/vim-python-pep8-indent",
    event = "BufRead",
  },

  -- Better-Escape
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- Stay-In-Place
  {
    "gbprod/stay-in-place.nvim",
    event = "VeryLazy",
    config = function()
      require("stay-in-place").setup()
    end
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = "BufRead",
    config = function()
      require("nvim-surround").setup()
    end
  },

  -- Treesitter-Context
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        throttle = true,
        max_lines = 0,
        patterns = {
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },

  -- CamelCaseMotion
  {
    "bkad/CamelCaseMotion",
    event = "VeryLazy",
    map("n", "w", "<Plug>CamelCaseMotion_w",
      opts),
    map("n", "b", "<Plug>CamelCaseMotion_b",
      opts),
    map("n", "e", "<Plug>CamelCaseMotion_e",
      opts),
    map("n", "ge", "<Plug>CamelCaseMotion_ge",
      opts),
  },

  -- Hop
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      map("n", "S", "<cmd>HopWord<cr>", opts)
      map("n", "s", "<cmd>HopChar2<cr>", opts)
    end,
  },

  -- TreeSJ
  {
    'Wansmer/treesj',
    event = "VeryLazy",
    dependencies = { 'nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
      })
    end,
    map("n", "zz", "<cmd>TSJToggle<cr>", opts)
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  -- Symbols-Outline
  {
    "simrat39/symbols-outline.nvim",
    event = "VeryLazy",
    config = function()
      require('symbols-outline').setup()
      map("n", "<m-s>", "<cmd>SymbolsOutline<cr>",
        opts)
      map("x", "<m-s>", "<cmd>SymbolsOutline<cr>",
        opts)
    end
  },

  -- Quick-Fix
  {
    "romainl/vim-qf",
    event = "VeryLazy",
    config = function()
      autocmd("filetype", {
        group = augroup("quickfix", { clear = true }),
        pattern = "qf",
        callback = function()
          vim.g.qf_auto_resize = 0
          map("n", "dd", "<cmd>.Reject<cr>", { buffer = 0 })
          map("n", "bd", "<cmd>Keep ''<cr>", { buffer = 0 })
        end
      })
    end
  },

  -- Yanky
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
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
      map({ "n", "x" }, "y", "<Plug>(YankyYank)", opts)
      map("n", "<c-n>", "<Plug>(YankyCycleForward)", opts)
      map("n", "<c-p>", "<Plug>(YankyCycleBackward)", opts)
      map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", opts)
      map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", opts)
      map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", opts)
      map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", opts)
    end
  },

  -- Undotree
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1,
          map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", opts)
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
      map("n", "<c-a>", require("dial.map").inc_normal(), opts)
      map("n", "<c-x>", require("dial.map").dec_normal(), opts)
      map("x", "<c-a>", require("dial.map").inc_visual(), opts)
      map("x", "<c-x>", require("dial.map").dec_visual(), opts)
      map("x", "g<c-a>", require("dial.map").inc_gvisual(), opts)
      map("x", "g<c-x>", require("dial.map").dec_gvisual(), opts)
    end
  },

  --Rnvimr
  {
    "ecthelionvi/rnvimr",
    event = "VeryLazy",
    config = function()
      vim.g.rnvimr_bw_enable = 1
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_presets = { { width = 0.800, height = 0.800 } }
      map("n", "<leader>.", "<cmd>RnvimrToggle<cr>",
        opts)
    end
  },

  -- Nvim-Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
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

  -- Copilot
  {
    "github/copilot.vim",
    event = "BufRead",
    config = function()
      vim.g.copilot_filetypes = {
        lazy = false,
        TelescopePrompt = false,
        TelescopeResults = false,
      }
      vim.cmd("imap <silent><script><expr> <s-cr> copilot#Accept('\\<CR>')")
    end
  },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      autocmd("filetype", {
        pattern = "harpoon",
        callback = function()
          map("n", "m", "<nop>", { buffer = 0 })
        end
      })
      map("n", "m", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
      map("n", "\\", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
    end
  },

  -- Substitute
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup({
        on_substitute = require("yanky.integration").substitute(),
        map("n", "cxx", "<cmd>lua require('substitute.exchange').line()<cr>", opts),
        map("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", opts),
        map("n", "cc", "<cmd>lua require('substitute.exchange').cancel()<cr>", opts),
        map("n", "cx", "<cmd>lua require('substitute.exchange').operator()<cr>", opts),
      })
    end
  },

  -- Code-Runner
  {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require('code_runner').setup {
        mode = "term",
        focus = true,
        --filetype_path = "", -- No default path defined
        filetype = {
          javascript = "node",
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
          cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
          python = "python -u",
          sh = "bash",
          rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        },
        --project_path = "", -- No default path defined
        --project = {},
        map("n", "<leader>r", function()
          return require('rob.functions').has_crunner_buffers()
        end, { noremap = true, silent = true, expr = true, })
      }
    end,
  },
}

return M