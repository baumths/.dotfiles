return {
  "nvim-telescope/telescope.nvim",
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = "󰋇 ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        mappings = {
          n = { ["<c-h>"] = require("telescope.actions.layout").toggle_preview },
          i = {
            ["<c-h>"] = require("telescope.actions.layout").toggle_preview,
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
      pickers = {
        diagnostics = { initial_mode = "normal", path_display = { "truncate" } },
        lsp_definitions = { initial_mode = "normal", path_display = { "truncate" } },
        lsp_references = { initial_mode = "normal", path_display = { "truncate" } },
        lsp_implementations = { initial_mode = "normal", path_display = { "truncate" } },
        find_files = {
          theme = "dropdown",
          hidden = true,
          preview = { hide_on_startup = true },
        },
        buffers = {
          theme = "dropdown",
          initial_mode = "normal",
          sort_lastused = true,
          show_all_buffers = true,
          preview = { hide_on_startup = true },
          mappings = { n = { d = "delete_buffer" } },
        },
      },
    })
  end,
  keys = {
    { "<leader><cr>", "<cmd>Telescope find_files<cr>" },
    { "<leader>/",    "<cmd>Telescope live_grep<cr>" },
    { "<leader>b",    "<cmd>Telescope buffers<cr>" },
    { "<leader>d",    "<cmd>Telescope diagnostics<cr>" },
    { "gd",           "<cmd>Telescope lsp_definitions<cr>" },
    { "gi",           "<cmd>Telescope lsp_implementations<cr>" },
    { "gr",           "<cmd>Telescope lsp_references<cr>" },
  },
}
