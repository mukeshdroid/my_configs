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

-------------------------------------------------------

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
vim.keymap.set("n", "<leader>rh", rustlsp("hover"), {
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

--------------------------------------------------------
