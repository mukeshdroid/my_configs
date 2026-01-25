return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  event = { "BufReadPost", "BufNewFile" },

  opts = {
    highlight = { enable = true },
    indent = { enable = true },

    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "haskell",
      "markdown",
      "markdown_inline",
      "json",
      "yaml",
      "python",
      "javascript",
      "typescript",
      "html",
      "css",
    },

    auto_install = true,
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
