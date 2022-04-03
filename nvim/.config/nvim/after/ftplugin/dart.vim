augroup DartAutos
  au!
  autocmd BufWritePre *.dart :lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END
