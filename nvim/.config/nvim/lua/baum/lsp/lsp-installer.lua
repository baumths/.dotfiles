local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  -- return early if server is dart since it is handled by flutter-tools.nvim
  if server.name == "dartls" then
    vim.notify("lsp_installer skipping dart")
    return
  end

  local handlers = require("baum.lsp.handlers")
	local opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

  if server.name == "sumneko_lua" then
  	local sumneko_opts = require("baum.lsp.settings.sumneko_lua")
  	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
