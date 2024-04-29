return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VeryLazy",
  branch = "v3.x",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    close_if_last_window = true,
    window = {
      mappings = {
        ["o"] = "open",
        ["oc"] = "",
        ["od"] = "",
        ["og"] = "",
        ["om"] = "",
        ["on"] = "",
        ["os"] = "",
        ["ot"] = "",
      },
    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>" },
  },
}
