return {
    'MeanderingProgrammer/render-markdown.nvim',
    version = "*", -- auto-update to latest stable
    dependencies = { 'nvim-treesitter/nvim-treesitter', { 'nvim-mini/mini.nvim', version = "*" } },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
}
