return {
  "folke/persistence.nvim",
  version = "*", -- auto-update to latest stable
  event = "VimEnter", -- need this earlier than BufReadPre so the autocmd below can fire
  keys = {
    { "<leader>qs", function() require("persistence").load() end,                desc = "Restore session for cwd" },
    { "<leader>qS", function() require("persistence").select() end,              desc = "Select a session to load" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't save current session" },
  },
  config = function()
    require("persistence").setup({})

    -- Auto-restore on startup when no specific file was given.
    -- Treats `nvim` and `nvim <dir>` (e.g. `nvim .`) the same.
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("persistence_auto_restore", { clear = true }),
      nested = true,
      callback = function()
        local args = vim.fn.argv()
        local no_file = #args == 0 or (#args == 1 and vim.fn.isdirectory(args[1]) == 1)
        if no_file then
          require("persistence").load()
        end
      end,
    })
  end,
}
