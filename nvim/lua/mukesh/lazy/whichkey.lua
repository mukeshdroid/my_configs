return {
  "folke/which-key.nvim",
  version = "*", -- auto-update to latest stable
  event = "VeryLazy",
  opts = {
    delay = 300, -- ms before the popup appears
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>r", group = "Rust / Rename" },
      { "<leader>c", group = "Code" },
      { "<leader>l", group = "LazyGit" },
    })
  end,
}
