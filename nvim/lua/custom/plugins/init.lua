return {
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
