local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = {
    "dart",
    "bash",
    "json",
    "yaml",
    "lua",
    "markdown",
  },
  sync_install = false,
  highlight = {
    enable = true,
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
