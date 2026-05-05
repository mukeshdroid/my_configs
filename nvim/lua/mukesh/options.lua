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

opt.scrolloff = 8            -- keep cursor 8 lines from top/bottom when scrolling
opt.cursorline = true        -- highlight the line the cursor is on
opt.ignorecase = true        -- case-insensitive search by default
opt.smartcase = true         -- ...unless the pattern contains uppercase letters
opt.inccommand = "split"     -- live preview of :s/:g substitutions in a split
opt.splitbelow = true        -- :split opens new window below current
opt.splitright = true        -- :vsplit opens new window to the right of current
opt.signcolumn = "yes"       -- always show sign column to prevent buffer text jitter
opt.termguicolors = true     -- enable 24-bit true color (required by most modern themes)
opt.undofile = true          -- persist undo history across nvim restarts
opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Add any other options you want here
