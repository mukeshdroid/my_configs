return {
  {
    "stevearc/conform.nvim",
    version = "*", -- auto-update to latest stable
    config = function()
      require("conform").setup({
        -- Add more language and their formatters here
        formatters_by_ft = {
          rust = { "rustfmt" },
        },
      })

      -- Format on save for everything that has a formatter
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            timeout_ms = 1000,
            lsp_format = "fallback",
          })
        end,
      })
    end,
  },
}
