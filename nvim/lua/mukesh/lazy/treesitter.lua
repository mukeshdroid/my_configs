return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local parsers = {
      "lua", "vim", "vimdoc", "bash",
      "haskell", "markdown", "markdown_inline",
      "json", "yaml",
      "python", "javascript", "typescript",
      "html", "css",
      "rust", "toml",
    }

    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
