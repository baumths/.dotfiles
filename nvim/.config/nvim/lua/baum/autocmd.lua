local baum_group = vim.api.nvim_create_augroup("BAUM", { clear = true })

vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    group = baum_group,
    callback = function()
      vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
    end,
  }
)

vim.api.nvim_create_autocmd(
  "User",
  {
    group = baum_group,
    pattern = "PackerCompileDone",
    callback = function()
      vim.cmd "CatppuccinCompile"
      vim.defer_fn(function()
        vim.cmd "colorscheme catppuccin"
      end, 50)
    end,
  }
)
