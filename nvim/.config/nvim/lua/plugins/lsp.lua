return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lsp = require("lspconfig")
    local capabilities, on_attach = require("user.utils").setup()

    lsp.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 200,
      },
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
}
