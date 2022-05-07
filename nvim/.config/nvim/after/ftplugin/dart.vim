augroup DartAutos
  au!
  autocmd BufWritePre *.dart :lua vim.lsp.buf.format()
augroup END
