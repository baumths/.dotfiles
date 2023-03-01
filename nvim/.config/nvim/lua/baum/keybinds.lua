local K = require("baum.keymap")

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Write & Quit
K.n("<leader>w", ":w<CR>")
K.n("<leader>q", ":q<CR>")

-- Yank to clipboard
K.n("<leader>y", '"+y')
K.n("<leader>Y", '"+Y')
K.v("<leader>y", '"+y')
K.v("<leader>Y", '"+Y')
K.x("<leader>y", '"+y')
K.x("<leader>Y", '"+Y')

-- Paste from clipboard
K.n("<leader>p", '"+p')
K.n("<leader>P", '"+P')

-- Better window navigation
K.n("<leader>[", ":wincmd h<CR>")
K.n("<leader>}", ":wincmd j<CR>")
K.n("<leader>{", ":wincmd k<CR>")
K.n("<leader>]", ":wincmd l<CR>")

-- Arrow resizing
K.n("<C-Up>", ":resize +5<CR>")
K.n("<C-Down>", ":resize -5<CR>")
K.n("<C-Left>", ":vertical resize +5<CR>")
K.n("<C-Right>", ":vertical resize -5<CR>")

-- Other
K.n("<leader>so", ":luafile %<CR>")
K.n("<leader>db", ":bdelete<CR>")
K.n("<C-l>", ":nohlsearch<CR>")

-- Count lines
K.v("<leader>cl", "g<C-g>")

-- Stay in visual mode when indenting
K.v("<", "<gv")
K.v(">", ">gv")

-- Move selection up/down
K.v("<leader>j", ":m .+1<CR>==")
K.v("<leader>k", ":m .-2<CR>==")

-- Move selection up/down
K.x("J", ":move '>+1<CR>gv-gv")
K.x("K", ":move '<-2<CR>gv-gv")
K.x("<A-j>", ":move '>+1<CR>gv-gv")
K.x("<A-k>", ":move '<-2<CR>gv-gv")

K.i("<C-g>", "<C-k>")
K.n("U", "<C-r>")
