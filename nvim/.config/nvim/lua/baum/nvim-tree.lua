-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

vim.g.nvim_tree_indent_markers = 1 -- lines

local nvim_tree = require("nvim-tree")

-- local nvim_tree_config = require("nvim-tree.config")
-- local tree_cb = nvim_tree_config.nvim_tree_callback

local function expand_all()
    local nvimlib = require('nvim-tree.lib')
    local function iter(nodes)
        for _, node in pairs(nodes) do
            if not node.open and node.nodes then
                nvimlib.expand_or_collapse(node)
            end
            if node.nodes then
                iter(node.nodes)
            end
        end
    end

    local nodes = {}
    local currnode = nvimlib.get_node_at_cursor()
    if currnode == nil then
        return
    end
    nodes = {currnode}
    iter(nodes)
end

nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  auto_close = false,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  update_to_buf_dir = {
    enable = false,
    auto_open = false,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "O", action = "expand_all", action_cb = expand_all }
        -- { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        -- { key = "h", cb = tree_cb "close_node" },
        -- { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
  git_hl = true,
  disable_window_picker = false,
  root_folder_modifier = ":t",
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
  actions = {
    change_dir = {
      enable = false,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      -- window_picker = {
      --   enable = true,
      --   chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      --   exclude = {
      --     filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
      --     buftype = { "nofile", "terminal", "help" },
      --   },
      -- },
    },
  },
}
