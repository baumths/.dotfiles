vim.o.number = true
vim.o.relativenumber = true
vim.o.errorbells = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.colorcolumn = "80"
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 250
vim.o.backup = false
vim.o.writebackup = false
vim.o.wrap = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.o.clipboard = "unnamed"

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = highlight_group,
  callback = function() vim.highlight.on_yank() end,
})

local format_options_group = vim.api.nvim_create_augroup("FormatOptions", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = format_options_group,
  callback = function() vim.opt_local.formatoptions:remove({ "r", "o" }) end,
})
