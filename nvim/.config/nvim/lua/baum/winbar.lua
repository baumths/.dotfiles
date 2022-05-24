local M = {}

local ignored_filetypes = {
  "log",
  "NvimTree",
}

local function check_is_ignored(filetype)
  return vim.tbl_contains(ignored_filetypes, filetype)
end

function M.get_winbar()
  local bo = vim.bo

  if check_is_ignored(bo.filetype) then
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
