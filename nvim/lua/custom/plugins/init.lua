return {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        "clangd",
        "css-lsp",
        "gopls",
        "html-lsp",
        "jdtls",
        "kotlin-language-server",
        "lua-language-server",
        "omnisharp",
        "pyright",
        "rust-analyzer",
        "shellcheck",
        "solargraph",
        -- "sourcekit",
        "typescript-language-server",
        "vetur-vls"
      }
    }
  },
  ["folke/which-key.nvim"] = { disable = false },
  ["tpope/vim-repeat"] = {},
  ["tpope/vim-surround"] = { after="vim-repeat" },
  ["gbprod/substitute.nvim"] = {},
  ["phaazon/hop.nvim"] = {
    config = function()
      require'hop'.setup({
        teasing = false,
        char2_fallback_key = "<cr>",
      })
    end
  },
}
