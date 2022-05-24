local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"
  local servers = { "clangd", "cssls", "gopls", "html", "jdtls", "kotlin_language_server", "omnisharp", "pyright", "rust_analyzer", "solargraph", "sourcekit", "tsserver", "vuels" }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
    }
  end
end

return M
