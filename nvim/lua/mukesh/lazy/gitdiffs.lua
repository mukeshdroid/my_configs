return {
  {
    "lewis6991/gitsigns.nvim",
    version = "*", -- auto-update to latest stable
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true, -- inline "<author>, <relative-time> - <summary>" on current line; toggle via <leader>gB
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
      },
    },
  },
}
