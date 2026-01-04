local M = {}

function M.check_pair()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  if col < 2 or col > #line then
    return false
  end
  local before = line:sub(col - 1, col - 1)
  local after = line:sub(col, col)
  local pairs = { ["{"] = "}", ["["] = "]", ["("] = ")", ['"'] = '"', ["'"] = "'", ["`"] = "`" }
  return pairs[before] == after
end

return M
