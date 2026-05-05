return {
  "kylechui/nvim-surround",
  version = "^4.0.0", -- per upstream README; pinned to 4.x to avoid breaking changes
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end,
}
