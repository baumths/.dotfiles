local options = {
  number = true,
  relativenumber = true,
  errorbells = false,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  hidden = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  scrolloff = 8,
  sidescrolloff = 8,
  colorcolumn = "80",
  signcolumn = "yes",
  splitright = true,
  splitbelow = true,
  cmdheight = 1,
  updatetime = 50,
  encoding = "UTF-8",
  backup = false,
  writebackup = false,
  autoread = true,
  wrap = false,
  swapfile = false,
  undofile = true,
  undodir = "/home/baum/.vim/undodir",
  termguicolors = true,
  laststatus = 2,
  wildmenu = true,

  clipboard = "unnamed",
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
