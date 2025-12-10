local M = {}

-- Define the base configuration path
local config_path = vim.fn.stdpath("config")

-- Function to load all .lua files in a given directory
function M.load_config_dir(dir_name)
  local full_dir_path = config_path .. "/lua/" .. string.gsub(dir_name, "%.", "/")
  -- Use vim.fn.readdir for a list of files and filter for .lua
  for _, file_entry in ipairs(vim.fn.readdir(full_dir_path, [[v:val =~ '\.lua$']])) do
    -- Extract the module name (relative path without the .lua extension)
    local module_name = dir_name .. "." .. file_entry:gsub("%.lua$", "")
    -- Require the module
    require(module_name)
  end
end

return M
