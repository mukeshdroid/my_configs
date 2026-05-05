return {
  {
    "stevearc/conform.nvim",
    version = "*", -- auto-update to latest stable
    config = function()
      require("conform").setup({
        -- Required binaries on PATH: rustfmt, stylua, taplo, prettier
        -- A missing binary is non-fatal: conform skips it and the save proceeds
        -- (with lsp_format = "fallback" picking up Lua etc. via LSP if available).
        formatters_by_ft = {
          rust     = { "rustfmt" },
          lua      = { "stylua" },
          toml     = { "taplo" },
          json     = { "prettier" },
          yaml     = { "prettier" },
          markdown = { "prettier" },
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
