return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  config = function()
    local capabilities, on_attach = require("user.utils").setup()

    require("flutter-tools").setup({
      lsp = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
    })
  end,
  keys = {
    { "<leader>fr", ":FlutterRun<CR>" },
    { "<leader>fq", ":FlutterQuit<CR>" },
    { "<leader>fh", ":FlutterReload<CR>" },
    { "<leader>fH", ":FlutterRestart<CR>" },
  },
}
