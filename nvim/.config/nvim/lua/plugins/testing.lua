return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "sidlatau/neotest-dart",
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
