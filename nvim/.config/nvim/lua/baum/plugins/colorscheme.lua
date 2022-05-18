local colorscheme = "desert"

local has_catppuccin, catppuccin = pcall(require, "catppuccin")
if has_catppuccin then
  colorscheme = "catppuccin"

  catppuccin.setup({
    transparent_background = false,
    term_colors = false,
    styles = {
      comments = "italic",
      functions = "NONE",
      keywords = "NONE",
      strings = "NONE",
      variables = "NONE",
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = "italic",
          hints = "italic",
          warnings = "italic",
          information = "italic",
        },
        underlines = {
          errors = "underline",
          hints = "underline",
          warnings = "underline",
          information = "underline",
        },
      },
      cmp = true,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = true,
      },
      indent_blankline = {
        enabled = false,
        colored_indent_levels = false,
      },
    }
  })
end

vim.cmd("colorscheme " .. colorscheme)
