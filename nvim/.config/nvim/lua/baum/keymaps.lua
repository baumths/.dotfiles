-------------------- HELPERS --------------------

local default_opts = { noremap = true, silent = false }

local function map(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, default_opts)
end

local function nmap(key, action)
  map("n", key, action)
end

local function vmap(key, action)
  map("v", key, action)
end

local function xmap(key, action)
  map("x", key, action)
end

-- Leader
map("", "<space>", "<nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make control+backspace work
map("", "<C-BS>", "<C-w>")
map("", "<C-h>", "<C-w>")

-- Write & Quit
nmap("<leader>w", ":w<CR>")
nmap("<leader>q", ":q<CR>")

-- Yank to clipboard
nmap("<leader>y", '"+y')
vmap("<leader>y", '"+y')
xmap("<leader>y", '"+y')

-- Paste from clipboard
nmap("<leader>p", '"+p')
vmap("<leader>p", '"+p')
xmap("<leader>p", '"+p')

-- Better window navigation
nmap("<leader>h", ":wincmd h<CR>")
nmap("<leader>j", ":wincmd j<CR>")
nmap("<leader>k", ":wincmd k<CR>")
nmap("<leader>l", ":wincmd l<CR>")

-- Arrow resizing
nmap("<C-Up>", ":resize +5<CR>")
nmap("<C-Down>", ":resize -5<CR>")
nmap("<C-Left>", ":vertical resize +5<CR>")
nmap("<C-Right>", ":vertical resize -5<CR>")

-- Telescope
nmap("<leader>e", ":Telescope find_files<CR>")

-- No previewer
nmap(
  "<leader><CR>",
  "<cmd>lua require'baum.telescope.finders'.find_files()<CR>"
) -- Find files dropdown
nmap(
  "<leader><leader><CR>",
  "<cmd>lua require'baum.telescope.finders'.find_all_files()<CR>"
) -- Find files dropdown including hidden files
nmap(
  "<leader>b",
  "<cmd>lua require'baum.telescope.finders'.buffers()<CR><ESC>"
) -- Show buffers dropdown in normal mode
nmap(
  "<leader>.",
  "<cmd>lua require'baum.telescope.finders'.code_actions()<CR><ESC>"
) -- Show code actions dropdown in normal mode

-- Nvimtree
nmap("<leader>t", ":NvimTreeToggle<CR>")

-- Flutter
nmap("<leader>ff", ":DartFmt<CR>")
nmap("<leader>fr", ":FlutterRun<CR>")
nmap("<leader>fq", ":FlutterQuit<CR>")
nmap("<leader>fh", ":FlutterReload<CR>")
nmap("<leader>fH", ":FlutterRestart<CR>")
nmap("<leader>fc", "<cmd>lua require('telescope').extensions.flutter.commands()<CR>")

-- Other
nmap("<leader>so", ":luafile %<CR>")
nmap("<C-l>", ":nohlsearch<CR>")
nmap("<leader>db", ":bdelete<CR>")


-- Stay in visual mode when indenting
vmap("<", "<gv")
vmap(">", ">gv")

-- Move selection up/down
vmap("<leader>j", ":m .+1<CR>==")
vmap("<leader>k", ":m .-2<CR>==")

-- Move selection up/down
xmap("J", ":move '>+1<CR>gv-gv")
xmap("K", ":move '<-2<CR>gv-gv")
xmap("<A-j>", ":move '>+1<CR>gv-gv")
xmap("<A-k>", ":move '<-2<CR>gv-gv")
