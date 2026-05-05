return {
  "windwp/nvim-autopairs",
  version = "*", -- auto-update to latest stable
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- treesitter-aware: skip pairing inside strings/comments
    })

    -- nvim-cmp integration: auto-insert () after function/method completion
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
