local flutter = require("flutter-tools")
local U = require("baum.plugins.lsp.utils")
local K = require("baum.keymap")

flutter.setup {
  lsp = {
    on_attach = function(client, buf)
        U.mappings(buf)
        U.fmt_on_save(client, buf)
    end,
    capabilities = U.capabilities(),
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

K.n("<leader>ff", ":DartFmt<CR>")
K.n("<leader>fr", ":FlutterRun<CR>")
K.n("<leader>fq", ":FlutterQuit<CR>")
K.n("<leader>fh", ":FlutterReload<CR>")
K.n("<leader>fH", ":FlutterRestart<CR>")
K.n("<leader>fc", "<cmd>lua require('telescope').extensions.flutter.commands()<CR>")
