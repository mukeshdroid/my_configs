return {
  "folke/trouble.nvim",
  -- intentionally tracking main: latest tag (v3.7.1) predates the fix for the
  -- nvim_set_decoration_provider API change in Neovim 0.12 (commits 3fb3bd7, 20189f0).
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (workspace)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Diagnostics (buffer)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (outline)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP definitions / references" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location list" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
  },
}
