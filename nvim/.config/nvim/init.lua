local modules_directory = "baum"
local user_modules = {
  "autopairs",
  "cmp",
  "colorscheme",
  "comment",
  "flutter",
  "gitsigns",
  "impatient",
  "indentline",
  "keymaps",
  "lualine",
  "lsp",
  "nvim-tree",
  "options",
  "other",
  "plugins",
  "telescope",
  "toggleterm",
  "treesitter",
}

for _, module in pairs(user_modules) do
  local ok, _ = pcall(require, modules_directory .. "." .. module)
  if not ok then
    local uppercase_module = string.upper(module)
    vim.notify("Failed to load Module <" .. uppercase_module .. ">.")
  end
end
