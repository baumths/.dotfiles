return {
  "nvim-lualine/lualine.nvim",
  event = "BufEnter",
  opts = {
    global_status = true,
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        { "branch", icon = "" },
        { "diff", symbols = { added = " ", modified = " ", removed = " " } }
      },
      lualine_c = {
        {
          "filename",
          file_status = true,
          symbols = { modified = "", readonly = "", unnamed = "unnamed" },
        }
      },
      lualine_x = { { "filetype", icon_only = true } },
      lualine_y = {
        {
          "diagnostics",
          colored = false,
          update_in_insert = false,
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn" },
          symbols = { error = " ", warn = " " },
        },
      },
      lualine_z = { "location" },
    },
  },
}
