local M = {}

function M.isDrupalProject()
  local root =
    require("lspconfig.util").root_pattern("core/lib/Drupal.php", "web/core/lib/Drupal.php")(vim.fn.expand("%:p:h"))

  return root ~= nil
end

return M
