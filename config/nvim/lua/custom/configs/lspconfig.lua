local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = { "clangd", "cssls", "gopls", "html", "jdtls", "kotlin_language_server", "lua_ls", "omnisharp", "pyright", "rust_analyzer", "solargraph", "sourcekit", "ts_ls", "vuels" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
