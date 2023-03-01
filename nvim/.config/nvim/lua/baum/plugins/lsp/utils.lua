local K = require("baum.keymap")

local M = {}

local fmt_group = vim.api.nvim_create_augroup("FORMATTING", { clear = true })

function M.setup ()
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local config = {
    virtual_text = {
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
    },
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

---Common format-on-save for lsp servers that implements formatting
---@param client table
---@param buf integer
function M.fmt_on_save(client, buf)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = fmt_group,
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({
          timeout_ms = 3000,
          buffer = buf,
        })
      end,
    })
  end
end

---LSP servers capabilities w/ nvim-cmp
function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

---LSP mappings
---@param bufnr number
function M.mappings(bufnr)
  K.n.bmap(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  K.n.bmap(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  K.n.bmap(bufnr, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  K.n.bmap(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  K.n.bmap(bufnr, "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
  K.n.bmap(bufnr, "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  K.n.bmap(bufnr, "[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>")
  K.n.bmap(bufnr, "]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>")
  K.n.bmap(bufnr, "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
  K.i.bmap(bufnr, "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  K.n.bmap(bufnr, "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  K.n.bmap(bufnr, "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  K.n.bmap(bufnr, "<leader>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  K.n.bmap(bufnr, "<leader>gl", "<cmd>lua vim.diagnostic.setqflist()<CR>")
end

function M.get_nvim_rtp_path()
  return {
    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    [vim.fn.stdpath("config") .. "/lua"] = true,
  }
end

return M
