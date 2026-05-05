return {
  {
    "neovim/nvim-lspconfig",
    version = "*", -- auto-update to latest stable
    ft = { "haskell", "lhaskell", "cabal" },
    config = function()
      local capabilities
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities()
      end

      vim.lsp.config.hls = {
        capabilities = capabilities,
      }

      vim.lsp.enable("hls")
    end,
  },
}
