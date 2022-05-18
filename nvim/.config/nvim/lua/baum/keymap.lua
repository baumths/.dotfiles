return setmetatable(
  {
    noremap = { noremap = true, silent = false },
    remap = { noremap = false, silent = false },
  },
  {
    __index = function(p, mode)
      return setmetatable(
        {
          map = function(key, action)
            vim.api.nvim_set_keymap(mode, key, action, p.remap)
          end,
          nmap = function(key, action)
            vim.api.nvim_set_keymap(mode, key, action, p.noremap)
          end,
          bmap = function(buf, key, action)
            vim.api.nvim_buf_set_keymap(buf, mode, key, action, p.noremap)
          end,
        },
        {
          __call = function(this, key, action)
            this.nmap(key, action)
          end
        }
      )
    end,
  }
)
