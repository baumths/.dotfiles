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

local nvim_tree = require("nvim-tree")

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
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
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
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
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
