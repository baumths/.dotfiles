local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = {
    "dart",
    "bash",
    "json",
    "yaml",
    "html",
    "scss",
    "lua",
    "markdown",
  },
  sync_install = false,
  -- ignore_install = { "" },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = false,
    disable = {}
  },
  autopairs = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
