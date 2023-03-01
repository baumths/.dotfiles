local K = require("baum.keymap")

local nvim_tree = require("nvim-tree")

local function expand_all()
    local nvimlib = require("nvim-tree.lib")
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
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "★",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
    },
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = "O", action = "expand_all", action_cb = expand_all },
        { key = "d", action = "trash" }
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
  },
}

K.n("<leader>t", ":NvimTreeToggle<CR>")
