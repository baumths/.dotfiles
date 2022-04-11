local finders = {}

function finders.find_files(hidden)
  hidden = hidden or false

  local opts = { previewer = false, hidden = hidden }
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")

  builtin.find_files(themes.get_dropdown(opts))
end

function finders.find_all_files()
  finders.find_files(true)
end

return finders
