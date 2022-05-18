local lsp = require("lspconfig")
local U = require("baum.plugins.lsp.utils")

U.setup()

local capabilities = U.capabilities()
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

lsp.sumneko_lua.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = function(_, buf)
    U.mappings(buf)
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "dump" },
      },
    	workspace = {
        library = U.get_nvim_rtp_path(),
      },
    },
  },
})
