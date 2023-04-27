local K = require("baum.keymap")

vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup {
  close_if_last_window = true,
  window = {
    mappings = {
      ["o"] = "open",
    }
  },
}

K.n("<leader>e", "<cmd>Neotree<cr>")
