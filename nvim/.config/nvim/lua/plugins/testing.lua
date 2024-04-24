return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "sidlatau/neotest-dart",
  },
  keys = {
    { "<leader>tt", "<cmd>Neotest summary<cr>" },
    { "<leader>tr", "<cmd>Neotest run<cr>" },
    { "<leader>ts", "<cmd>Neotest stop<cr>" },
    { "<leader>tf", "<cmd>Neotest run vim.fn.expand('%')<cr>" },
  },
  config = function()
    require("neotest").setup({
      adapters = { require("neotest-dart")({ command = "flutter" }) },
      icons = {
        passed = "",
        failed = "",
        skipped = "",
        unknown = "",
        running = "◌",
        running_animated = { "", "", "", "" },
      },
      quickfix = { enabled = true, open = false },
      summary = {
        animated = true,
        open = "botright vsplit | vertical resize 80",
      },
    })
  end,
}
