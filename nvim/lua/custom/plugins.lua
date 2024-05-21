local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "folke/which-key.nvim",
    enabled = true
  },

  -- Install a plugin

  {
    "tpope/vim-repeat",
    event = "VeryLazy"
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {}
  },

  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup()
    end
  },

  {
    "smoka7/hop.nvim",
    event = "VeryLazy",
    opts = overrides.hop
  },
}

return plugins
