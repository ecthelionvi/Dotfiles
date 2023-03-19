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
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup("format-options", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.functions").cwd_set_options()
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

return M