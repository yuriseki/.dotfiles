local project = require("utils.project")
local key_bindings = {}

if project.isDrupalProject() then
  key_bindings = {
    -- Deprecated in favor of Null-ls
    -- {
    --   "<C-M-l>",
    --   function()
    --     require("utils.drupal-formatter").drupal_format_selection()
    --   end,
    --   mode = "v",
    --   desc = "Drupal format selection (phpcbf + diff)",
    -- },
    {
      "\\cc",
      function()
        require("utils.drupal-formatter").drupal_file_format()
      end,
      mode = "n",
      desc = "Drupal format file (phpcbf)",
    },

  }
else
  key_bindings = {
    {
      "<C-M-l>",
      function()
        LazyVim.format({ force = true })
      end,
      mode = { "i", "n", "v" },
      desc = "Format code",
    },
  }
end

return {
  -- ---------------------------------------------------------------------------
  -- Drupal key bindings.
  -- ---------------------------------------------------------------------------
  {
    "LazyVim/LazyVim",
    keys = key_bindings,
  },
}
