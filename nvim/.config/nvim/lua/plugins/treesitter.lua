return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      ensure_installed = {
        "vimdoc",
        "lua",
        "xml",
        "json",
        "yaml",
        "toml",
        "markdown",
        "html",
        "css",
        "bash",
        "dart",
        "rust",
        "go",
        "python",
        "javascript",
      },
    })
  end,
}
