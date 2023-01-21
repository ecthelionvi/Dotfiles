local M = {}

-- Startup
vim.api.nvim_create_autocmd("vimenter", {
  group = vim.api.nvim_create_augroup("clear_history", { clear = true }),
  callback = function()
    vim.schedule(function()
      require("functions").clear_history()
      vim.cmd[[
      let b:copilot_enabled
      let g:copilot_filetypes = {
        \ '': v:false,
        \ }
      }
      ]]
    end)
  end
})

-- LSP-Popup
lvim.lsp.on_attach_callback = function(client, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

return M