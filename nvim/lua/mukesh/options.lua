-- Basic sane Neovim options
local opt = vim.opt

opt.number = true            -- show line numbers
opt.relativenumber = true    -- relative numbers
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = true
vim.opt.linebreak = true      -- wrap at word boundaries
vim.opt.breakindent = true    -- keep indentation on wrapped lines
vim.opt.showbreak = "↪ " 
opt.swapfile = false

-- Add any other options you want here
