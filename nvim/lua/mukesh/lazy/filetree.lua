return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- icons
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    init = function()
      -- This makes neo-tree nicer with `:q` etc.
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,    -- close if it's the last window
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,

        filesystem = {
          follow_current_file = { enabled = true }, -- auto-focus current file
          group_empty_dirs = true,
          use_libuv_file_watcher = true,
        },

        window = {
          position = "left", -- left sidebar
          width = 30,
        },
      })
    end,
  },
}
