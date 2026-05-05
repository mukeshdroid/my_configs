return {
  "nvim-treesitter/nvim-treesitter",

  branch = "main",

  config = function()
    -- Enable highlighting and indentation via autocmd
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
