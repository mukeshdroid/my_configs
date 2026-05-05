return {
  url = "https://codeberg.org/andyg/leap.nvim", -- repo migrated from GitHub
  name = "leap.nvim",
  event = "VeryLazy",
  config = function()
    -- Per upstream README: no setup() needed, just define keybindings.
    -- s/S override vim's substitute-char and substitute-line; the README
    -- acknowledges this trade-off as expected.
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)",             { desc = "Leap" })
    vim.keymap.set("n",               "S", "<Plug>(leap-from-window)", { desc = "Leap from other window" })
  end,
}
