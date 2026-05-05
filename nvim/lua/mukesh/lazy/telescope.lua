return {
  'nvim-telescope/telescope.nvim',
  version = "*", -- auto-update to latest stable
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({})
  end
}
