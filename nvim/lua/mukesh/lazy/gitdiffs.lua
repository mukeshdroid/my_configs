return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- the defaults are good; this opts block can be empty
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
      },
    },
  },
}
