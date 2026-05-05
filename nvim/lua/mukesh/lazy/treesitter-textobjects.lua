return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main", -- match nvim-treesitter; master is frozen per upstream README
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },

  init = function()
    vim.g.no_plugin_maps = true -- per upstream lazy.nvim snippet; prevents legacy plugin defaults
  end,

  config = function()
    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")

    local k = vim.keymap.set
    local function o(desc)
      return { desc = desc, silent = true }
    end

    -- Selection (visual + operator-pending)
    k({ "x", "o" }, "af", function() select.select_textobject("@function.outer") end,  o("TS: around function"))
    k({ "x", "o" }, "if", function() select.select_textobject("@function.inner") end,  o("TS: inside function"))
    k({ "x", "o" }, "ac", function() select.select_textobject("@class.outer") end,     o("TS: around class"))
    k({ "x", "o" }, "ic", function() select.select_textobject("@class.inner") end,     o("TS: inside class"))
    k({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer") end, o("TS: around argument"))
    k({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner") end, o("TS: inside argument"))

    -- Movement (normal + visual + operator-pending)
    k({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer") end,      o("TS: next function start"))
    k({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer") end,  o("TS: prev function start"))
    k({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer") end,        o("TS: next function end"))
    k({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer") end,    o("TS: prev function end"))
    k({ "n", "x", "o" }, "]m", function() move.goto_next_start("@class.outer") end,         o("TS: next class start"))
    k({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@class.outer") end,     o("TS: prev class start"))
    k({ "n", "x", "o" }, "]M", function() move.goto_next_end("@class.outer") end,           o("TS: next class end"))
    k({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@class.outer") end,       o("TS: prev class end"))
    k({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner") end,     o("TS: next argument"))
    k({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner") end, o("TS: prev argument"))

    -- Swap arguments
    k("n", "<leader>a", function() swap.swap_next("@parameter.inner") end,     o("Swap: argument with next"))
    k("n", "<leader>A", function() swap.swap_previous("@parameter.inner") end, o("Swap: argument with previous"))
  end,
}
