local K = require("baum.keymap")

K.n(
  "<leader>ts",
  "<cmd>lua require'neotest'.summary.toggle()<cr>"
)
K.n(
  "<leader>tr",
  "<cmd>lua require'neotest'.run.run()<cr>"
)
K.n(
  "<leader>tf",
  "<cmd>lua require'neotest'.run.run(vim.fn.expand('%'))<cr>"
)
