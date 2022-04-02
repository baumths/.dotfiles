local flutter = require("flutter-tools")
local handlers = require("baum.lsp.handlers")

flutter.setup {
  lsp = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  },
}

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = true,
    signs = true,
    update_in_insert = false,
  }
)
