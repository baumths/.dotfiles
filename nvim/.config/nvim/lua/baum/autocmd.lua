local baum_group = vim.api.nvim_create_augroup("BAUM", { clear = true })

vim.api.nvim_create_autocmd(
  'TextYankPost',
  {
    group = baum_group,
    callback = function()
      vim.highlight.on_yank({ higroup = 'Visual', timeout = 100 })
    end,
  }
)
