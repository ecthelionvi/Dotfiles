-- |||||||||||||||||||||||||||||||||||| LSP ||||||||||||||||||||||||||||||||||| --

local M = {}

lvim.lsp.on_attach_callback = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
end

return M