-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Startup
autocmd("VimEnter", {
  group = augroup("clear-history", { clear = true }),
  callback = function()
    vim.schedule(function()
      vim.g.copilot_no_tab_map = true
      require("rob.functions").clear_history()
    end)
  end
})

-- Toggle-Color-Column
autocmd({ "BufEnter", "BufLeave", "BufWinEnter", "BufWinLeave" }, {
  group = augroup("toggle-color-column", { clear = true }),
  callback = function()
    vim.schedule(function()
      if require("rob.functions").excluded_types() then
        vim.fn.clearmatches()
      else
        require("rob.functions").toggle_color_column()
      end
    end)
    vim.o.fo = vim.o.fo:gsub("[cro]", "")
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

-- Quit
autocmd("FileType", {
  group = augroup("q-map", { clear = true }),
  pattern = { "qf", "help", "man", "noice" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>q!<CR>", { noremap = true, silent = true, buffer = 0 })
  end,
})

return M