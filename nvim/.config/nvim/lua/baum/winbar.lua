local M = {}

M.get_winbar = function()
  local bo = vim.bo

  if bo.filetype == "NvimTree" then
    return ""
  end

  local mod_symbol = ""

  if bo.modifiable then
    if bo.modified then
      mod_symbol = ""
    end
  else
    mod_symbol = ""
  end

  return "%t " .. mod_symbol
end

return M
