local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "vetur-vls",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- Golang
    "gopls",

    -- Java/Kotlin
    "jdtls",
    "kotlin-language-server",

    -- C#
    "omnisharp",

    -- Python
    "pyright",

    -- Rust
    "rust-analyzer",

    -- Ruby
    "solargraph"
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.hop = {
  teasing = false,
  char2_fallback_key = "<cr>",
}

return M
