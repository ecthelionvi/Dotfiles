local M = {}

-- Startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("clear-history", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("rob.functions").clear_history()
    end)
  end
})

-- Colorcolumn
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("color-column", { clear = true }),
  callback = function()
    vim.schedule(function()
      if not require("rob.functions").is_excluded_filetype() then
        require("rob.functions").toggle_color_column()
      else
      vim.fn.clearmatches()
      end
    end)
  end
})


return M