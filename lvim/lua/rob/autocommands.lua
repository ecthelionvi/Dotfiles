-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Close-Nvim-Tree
autocmd("BufDelete", {
  group = augroup("nvim-tree", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.utils").close_nvim_tree()
    end)
  end,
})

-- Quit-Nvim-Tree
autocmd({ "QuitPre" }, {
  group = "nvim-tree",
  callback = function() 
    pcall(function() vim.cmd("NvimTreeClose") end)
  end
})

-- Special-Keymaps
autocmd("FileType", {
  group = augroup("special-keymaps", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.utils").hide_filetype()
      require("rob.utils").special_keymaps()
    end)
  end,
})

-- Change-Directory .. Copilot .. Format-Options
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup("format-options", { clear = true }),
  callback = function()
    vim.schedule(function()
     pcall(function() require("rob.utils").cwd_set_options() end)
    end)
  end,
})

return M
