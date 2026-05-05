return {
  "vague-theme/vague.nvim",
  version = "*", -- auto-update to latest stable
  priority = 1000, -- load before other plugins so highlights are defined first
  config = function()
    require("vague").setup({
      transparent = false,
    })
    vim.cmd.colorscheme("vague")
  end,
}
