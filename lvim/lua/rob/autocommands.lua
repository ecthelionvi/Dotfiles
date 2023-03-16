-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto-Save
autocmd({ "InsertLeave", "TextChanged" }, {
  group = augroup("auto-save", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.functions").auto_save()
    end)
  end
})

-- Change-Directory .. Copilot .. Format-Options 
autocmd("BufEnter", {
  group = augroup("format-options", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.functions").cwd()
      vim.g.copilot_no_tab_map = true
      vim.o.fo = vim.o.fo:gsub("[cro]", "")
    end)
  end,
})

-- Special-Keymaps
autocmd("FileType", {
  group = augroup("special-keymaps", { clear = true }),
  callback = function()
    vim.schedule(function()
     require("rob.functions").special_keymaps()
   end)
  end,
})

-- Toggle-Color-Column
autocmd({ "BufWinEnter", "BufWinLeave" }, {
  group = augroup("toggle-color-column", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.functions").toggle_color_column()
    end)
  end
})

return M