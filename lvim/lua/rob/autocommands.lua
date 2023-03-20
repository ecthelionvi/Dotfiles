-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto-Save
autocmd({ "InsertLeave", "TextChanged" }, {
  group = augroup("auto-save", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.utils").auto_save()
    end)
  end
})

-- Change-Directory .. Copilot .. Format-Options 
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup("format-options", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.utils").cwd_set_options()
    end)
  end,
})

-- Special-Keymaps
autocmd("FileType", {
  group = augroup("special-keymaps", { clear = true }),
  callback = function()
    vim.schedule(function()
     require("rob.utils").special_keymaps()
   end)
  end,
})

-- Apply-Color-Column
autocmd({ "BufWinEnter" }, {
  group = augroup("apply-color-column", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.utils").apply_color_column()
    end)
  end
})

return M