local finders = {}

function finders.find_files()
  local opts = { previewer = false }
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")

  builtin.find_files(themes.get_dropdown(opts))
end

function finders.find_all_files()
  local opts = {
    previewer = false,
    hidden = true,
  }
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")

  builtin.find_files(themes.get_dropdown(opts))
end

function finders.buffers()
  local opts = { previewer = false }
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")

  builtin.buffers(themes.get_dropdown(opts))
end

function finders.code_actions()
  local opts = {
    previewer = false,
    layout_config = {
      height = 0.7,
    }
  }
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")

  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

return finders
