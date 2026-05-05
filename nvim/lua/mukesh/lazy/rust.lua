return {
  {
    "mrcjkb/rustaceanvim",
    version = "*", -- auto-update to latest stable
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
          -- Handler for pull diagnostics refresh request
          handlers = {
            ["workspace/diagnostic/refresh"] = function(_, _, ctx)
              local client = vim.lsp.get_client_by_id(ctx.client_id)
              if not client then
                return vim.NIL
              end

              -- Request fresh diagnostics for each buffer attached to this client
              for _, buf in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
                if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
                  client.request("textDocument/diagnostic", {
                    textDocument = { uri = vim.uri_from_bufnr(buf) },
                  }, nil, buf)
                end
              end

              return vim.NIL
            end,
          },
          default_settings = {
            ["rust-analyzer"] = {
              -- Diagnostics settings
              diagnostics = {
                enable = true,
                experimental = {
                  enable = true,
                },
              },
              -- Use clippy for lints on save
              check = {
                command = "clippy",
                allTargets = true,
                workspace = true,
                extraArgs = { "--all-targets" },
              },
              -- Performance: limit proc macro expansion
              procMacro = {
                enable = true,
                attributes = {
                  enable = true,
                },
              },
              -- Cargo settings
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Completion settings
              completion = {
                autoimport = {
                  enable = true,
                },
                postfix = {
                  enable = true,
                },
              },
              -- Inlay hints (optional, can slow things down)
              inlayHints = {
                bindingModeHints = {
                  enable = false,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                closureReturnTypeHints = {
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
      }
    end,
  },
}
