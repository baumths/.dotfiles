local function get_lsp_capabilities()
  return require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
end

local function setup_lsp_keymaps(buffer)
  local opts = { buffer = buffer, noremap = true, silent = true }

  -- Commented out lines are handled by Telescope
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "<leader>gl", vim.diagnostic.setqflist, opts)
  vim.keymap.set("n", "<leader>sl", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
end

local function enable_format_on_save(buffer)
  local fmt_group = vim.api.nvim_create_augroup("UserLspFormatting", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    group = fmt_group,
    callback = function() vim.lsp.buf.format({ buffer = buffer, async = false }) end,
  })
end

local function enable_rounded_borders()
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

local function enable_show_diagnostics_on_hover(buffer)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = buffer,
    callback = function()
      vim.diagnostic.open_float(nil, {
        prefix = " ",
        scope = "cursor",
        source = "always",
        focusable = false,
        border = "rounded",
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      })
    end
  })
end

local function get_diagnostic_config()
  return {
    virtual_text = {
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
    },
    signs = {
      text = {
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.ERROR] = "",
      },
    },
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
end

local function on_attach(_, buffer)
  enable_show_diagnostics_on_hover(buffer)
  enable_format_on_save(buffer)
  setup_lsp_keymaps(buffer)
end

return {
  setup = function()
    enable_rounded_borders()
    vim.diagnostic.config(get_diagnostic_config())
    return get_lsp_capabilities(), on_attach
  end,
}
