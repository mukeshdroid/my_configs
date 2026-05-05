return {
  {
    "lewis6991/gitsigns.nvim",
    version = "*", -- auto-update to latest stable
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
