return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
            },
          },
          lualine_y = {
            -- Show attached LSP clients
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                  return "No LSP"
                end
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return table.concat(names, ", ")
              end,
            },
          },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    version = "*", -- auto-update to latest stable
    event = "LspAttach",
    opts = {
      progress = {
        display = {
          render_limit = 5,
          done_ttl = 3,
        },
      },
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
}
