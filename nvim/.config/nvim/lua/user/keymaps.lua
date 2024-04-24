vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<space>", "<nop>", opts)

vim.keymap.set("n", "<leader>w", ":w<CR>", opts)
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)

vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+Y', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("v", "<leader>Y", '"+Y', opts)
vim.keymap.set("x", "<leader>y", '"+y', opts)
vim.keymap.set("x", "<leader>Y", '"+Y', opts)

vim.keymap.set("n", "<leader>p", '"+p', opts)
vim.keymap.set("n", "<leader>P", '"+P', opts)
vim.keymap.set("v", "<leader>p", '"+p', opts)
vim.keymap.set("v", "<leader>P", '"+P', opts)
vim.keymap.set("x", "<leader>p", '"+p', opts)
vim.keymap.set("x", "<leader>P", '"+P', opts)

-- window navigation
vim.keymap.set("n", "<leader>[", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<leader>}", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<leader>{", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<leader>]", ":wincmd l<CR>", opts)

-- split resizing
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -5<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize +5<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -5<CR>", opts)

-- stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- move selection up/down
vim.keymap.set("v", "<leader>j", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<leader>k", ":m .-2<CR>==", opts)

-- move selection up/down
vim.keymap.set("x", "<leader>J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<leader>K", ":move '<-2<CR>gv-gv", opts)

-- other
vim.keymap.set("n", "<leader>so", ":luafile %<CR>", opts)
vim.keymap.set("v", "<leader>cl", "g<C-g>", opts) -- count buffer lines
vim.keymap.set("i", "<C-g>", "<C-k>", opts)
vim.keymap.set("n", "U", "<C-r>", opts)
