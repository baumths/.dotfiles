return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    init = function() vim.cmd.colorscheme "catppuccin-mocha" end,
    opts = { integrations = { neotree = true } },
  },
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "stevearc/dressing.nvim", opts = {} },
  { "windwp/nvim-autopairs",  event = "VeryLazy", opts = {} },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = { char = "▏" },
      scope = { enabled = false },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "]g", "<cmd>Git next_hunk<cr>" },
      { "[g", "<cmd>Git prev_hunk<cr>" },
    },
  },
}
