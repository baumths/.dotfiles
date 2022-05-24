require("indent_blankline").setup {
  char = "▏",
  -- show_current_context = true,
  show_first_indent_level = false,
  filetype_exclude = { "help", "packer", "startify", "dashboard", "NvimTree", },
  buftype_exclude = { "terminal", "nofile" },
}
