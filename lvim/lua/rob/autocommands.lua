-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Quit
autocmd("FileType", {
  group = augroup("q-map", { clear = true }),
  pattern = { "qf", "help", "man", "noice" },
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "q",
      "<cmd>q!<CR>",
      { noremap = true, silent = true }
    )
  end,
})

-- Comment
autocmd("FileType", {
  group = augroup("comment", { clear = true }),
  pattern = "*",
  callback = function()
    vim.schedule(function()
    vim.opt.formatoptions =
        vim.opt.formatoptions - { "c", "r", "o" }
      end)
  end,
})

-- Startup
autocmd("VimEnter", {
  group = augroup("clear-history", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.functions").clear_history()
    end)
  end
})

-- Toggle-Color-Column
autocmd("BufWinEnter", {
  group = augroup("toggle-color-column", { clear = true }),
  callback = function()
    vim.schedule(function()
      if not require("rob.functions").excluded_filetype() then
        require("rob.functions").toggle_color_column()
      else
        vim.fn.clearmatches()
      end
    end)
  end
})

-- Auto-Save
autocmd({ "InsertLeave", "TextChanged" }, {
  group = augroup("autosave", { clear = true }),
  callback = function()
    vim.schedule(function()
      if vim.bo.modified then require("rob.functions").auto_save() end
    end)
  end
})

return M