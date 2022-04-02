local M = {}

M.setup = function()
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local config = {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  local lsp = vim.lsp
  local handlers = lsp.handlers

  handlers["textDocument/hover"] = lsp.with(handlers.hover, {
    border = "rounded",
  })

  handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local nmap = function (key, action)
    local opts = { noremap = true, silent = false }
    vim.api.nvim_buf_set_keymap(bufnr, "n", key, action, opts)
  end

  nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  nmap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  nmap("<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  nmap("<leader>gf", "<cmd>lua vim.diagnostic.open_float()<CR>")
  nmap("[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
  nmap("]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
  nmap("gl", '<cmd>lua vim.diagnostic.open_float()<CR>')
  nmap("<leader>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end
M.on_attach = function(_, bufnr)
  lsp_keymaps(bufnr)
end

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
