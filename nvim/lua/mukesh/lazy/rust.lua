return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,

    init = function()
      -- Safely try to load cmp_nvim_lsp
      local capabilities
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities()
      end

      vim.g.rustaceanvim = {
        server = {
          capabilities = capabilities,
        },
      }
    end,
  },
}
