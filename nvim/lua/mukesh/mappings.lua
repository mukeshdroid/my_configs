vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- basic mappings
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-----------------------------------------------------
-- Telescope keymaps (safe, lazy-loaded)
-----------------------------------------------------

local function tbuiltin(name)
  return function()
    local ok, builtin = pcall(require, "telescope.builtin")
    if not ok then
      vim.notify("Telescope not found", vim.log.levels.WARN)
      return
    end
    builtin[name]()
  end
end

map("n", "<leader>ff", tbuiltin("find_files"), { desc = "Telescope: Find files" })
map("n", "<leader>fg", tbuiltin("live_grep"),  { desc = "Telescope: Live grep" })
map("n", "<leader>fb", tbuiltin("buffers"),    { desc = "Telescope: Buffers" })
map("n", "<leader>fd", tbuiltin("diagnostics"),    { desc = "Telescope: Diagnostics" })

-------------------------------------------------------

-----------------------------------------------------
-- LSP navigation (all languages)
-----------------------------------------------------
map("n", "gd", tbuiltin("lsp_definitions"),      { desc = "LSP: Go to definition" })
map("n", "gD", tbuiltin("lsp_type_definitions"), { desc = "LSP: Go to type definition" })
map("n", "gi", tbuiltin("lsp_implementations"),  { desc = "LSP: Go to implementation" })
map("n", "gr", tbuiltin("lsp_references"),       { desc = "LSP: References" })

map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "LSP: Rename symbol" })

map({ "n", "v" }, "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP: Code action" })

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnostics: Previous" })

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnostics: Next" })

-- Signature help (insert mode)
map("i", "<C-k>", function()
  vim.lsp.buf.signature_help()
end, { desc = "LSP: Signature help" })

-----------------------------------------------------
-- Jump navigation (back / forward)
-----------------------------------------------------
vim.keymap.set("n", "gb", "<C-o>", { desc = "Jump back" })
vim.keymap.set("n", "gn", "<C-i>", { desc = "Jump forward" })

-----------------------------------------------------
-- Rust-specific keymaps (rustaceanvim / RustLsp)
-----------------------------------------------------

local function rustlsp(cmd)
  return function()
    -- Only call RustLsp if the command actually exists
    if vim.fn.exists(":RustLsp") == 2 then
      vim.cmd("RustLsp " .. cmd)
    else
      vim.notify("RustLsp command not available (is rustaceanvim installed?)", vim.log.levels.WARN)
    end
  end
end

-- Run tests / binaries detected by rust-analyzer
vim.keymap.set("n", "<leader>rr", rustlsp("runnables"), {
  desc = "Rust: Runnables",
})

-- Debuggable targets (we'll hook this into DAP later)
vim.keymap.set("n", "<leader>rd", rustlsp("debuggables"), {
  desc = "Rust: Debuggables",
})

-- Hover actions (richer than plain K once we configure more)
vim.keymap.set("n", "<leader>rh", rustlsp("hover actions"), {
  desc = "Rust: Hover actions",
})

-- Expand macro at cursor
vim.keymap.set("n", "<leader>re", rustlsp("expandMacro"), {
  desc = "Rust: Expand macro",
})

-- Crate graph (requires `dot` from graphviz installed)
vim.keymap.set("n", "<leader>rg", rustlsp("crateGraph"), {
  desc = "Rust: Crate graph",
})

------------------------------------------------------
-- Disable Arrow keys to form better habits
-------------------------------------------------------
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>")
--------------------------------------------------------

-------------------------------------------------------
-- File Explorer: neo-tree sidebar
------------------------------------------------------
vim.keymap.set("n", "<leader>e", function()
  -- Toggle sidebar on the left, revealing current file
  vim.cmd("Neotree toggle left reveal")
end, { desc = "File explorer (neo-tree)" })
--------------------------------------------------------


-----------------------------------------------------
-- Window navigation with Alt (Meta) + hjkl
-----------------------------------------------------
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Window right" })

-----------------------------------------------------
-- Git: gitsigns.nvim (safe, lazy-loaded)
-----------------------------------------------------

local function gitsigns(fn)
  return function()
    local ok, gs = pcall(require, "gitsigns")
    if not ok then
      vim.notify("gitsigns not found", vim.log.levels.WARN)
      return
    end
    gs[fn]()
  end
end

-- Hunk navigation (doesn't conflict with your [d ]d)
map("n", "]c", gitsigns("next_hunk"), { desc = "Git: Next hunk" })
map("n", "[c", gitsigns("prev_hunk"), { desc = "Git: Previous hunk" })

-- Preview + diff
map("n", "<leader>gp", gitsigns("preview_hunk"), { desc = "Git: Preview hunk" })
map("n", "<leader>gd", gitsigns("diffthis"),     { desc = "Git: Diff this file" })

-- Stage / reset
map("n", "<leader>gs", gitsigns("stage_hunk"),   { desc = "Git: Stage hunk" })
map("n", "<leader>gr", gitsigns("reset_hunk"),   { desc = "Git: Reset hunk" })
map("n", "<leader>gS", gitsigns("stage_buffer"), { desc = "Git: Stage buffer" })
map("n", "<leader>gR", gitsigns("reset_buffer"), { desc = "Git: Reset buffer" })

-- Blame
map("n", "<leader>gb", gitsigns("blame_line"),   { desc = "Git: Blame line" })
map("n", "<leader>gB", gitsigns("toggle_current_line_blame"), { desc = "Git: Toggle line blame" })

-- Toggle deleted lines in buffer (handy when reviewing)
map("n", "<leader>gD", gitsigns("toggle_deleted"), { desc = "Git: Toggle deleted" })
