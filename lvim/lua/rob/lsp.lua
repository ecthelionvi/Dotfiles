-- |||||||||||||||||||||||||||||||||||| LSP ||||||||||||||||||||||||||||||||||| --

local M = {}

-- Semantic-Tokens
lvim.lsp.on_attach_callback = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
end

-- Keymaps
lvim.lsp.buffer_mappings.normal_mode['K'] = nil
lvim.lsp.buffer_mappings.normal_mode['gl'] = nil
lvim.lsp.buffer_mappings.normal_mode['gj'] = { function()
  local config = lvim.lsp.diagnostics.float
  config.scope = "line"
  vim.diagnostic.open_float(0, config)
end }
lvim.lsp.buffer_mappings.normal_mode['gK'] = { vim.lsp.buf.hover, "Show hover" }

return M