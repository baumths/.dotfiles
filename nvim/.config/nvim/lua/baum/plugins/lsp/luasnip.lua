require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("dart", { "flutter" })

local K = require("baum.keymap")

K.i("<C-j>", "<CMD>lua require('luasnip').jump(1)<CR>")
K.i("<C-k>", "<CMD>lua require('luasnip').jump(-1)<CR>")
K.s("<C-j>", "<CMD>lua require('luasnip').jump(1)<CR>")
K.s("<C-k>", "<CMD>lua require('luasnip').jump(-1)<CR>")
