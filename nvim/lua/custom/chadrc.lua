local M = {}
local userPlugins = require "custom.plugins"

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },

  install = userPlugins,
}

return M
