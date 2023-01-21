--|||||||||||||||||||||||||||||||||| Plugins ||||||||||||||||||||||||||||||||||--

local M = {}

lvim.plugins = {
  {
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "github/copilot.vim",
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
        vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", { noremap = true }, { silent = true })
        vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", { noremap = true }, { silent = true })
        vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { noremap = true }, { silent = true })
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { noremap = true }, { silent = true })
        vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", { noremap = true }, { silent = true })
        vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", { noremap = true }, { silent = true })
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { noremap = true }, { silent = true })
        vim.keymap.set("x", "P", "<cmd>lua require('substitute').visual()<cr>", { noremap = true }, { silent = true })
        vim.keymap.set("x", "p", "<cmd>lua require('substitute').visual()<cr>", { noremap = true }, { silent = true })
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

    -- Undotree
    {
      "mbbill/undotree",
      config = function()
        vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { noremap = true, silent = true })
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
      "kevinhwang91/rnvimr",
      config = function()
        vim.keymap.set({ "n", "t" }, "<leader>.", "<cmd>RnvimrToggle<cr>", { noremap = true }, { silent = true })
      end
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
          vim.api.nvim_set_keymap("n", "<leader>r", [[&buftype == "terminal" ? ":RunClose<cr>" : ":RunCode<cr>"]],
            { expr = true, noremap = true })
        }
      end,
    },

    -- Harpoon
    {
      "ThePrimeagen/harpoon",
      config = function()
        vim.keymap.set("n", "m", "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true, silent = true })
        vim.keymap.set("n", "\\", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
          { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "dd", [[&filetype == "harpoon" ? ':silent! normal! "_dd<cr>' : '"_dd']],
          { expr = true, noremap = true, silent = true })
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

return M