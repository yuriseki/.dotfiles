local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- Check if the config already exists to prevent errors
if not configs.drupalls then
  configs.drupalls = {
    default_config = {
      cmd = {
        "/bin/bash",
        "-c",
        "cd /home/yuri/ssd2/project-files/Yuri/DrupalLS && source .venv/bin/activate && poetry run drupalls",
        -- "cd /home/yuri/ssd2/project-files/Yuri/DrupalLS && source .venv/bin/activate && DEBUG_DRUPALLS=1 python -m drupalls.main",
      },      filetypes = { "php", "yaml", "twig" },
      root_dir = lspconfig.util.root_pattern(".git", "composer.json"), -- Marks the project root
      name = "drupalls",
      single_file_support = true,
    },
  }
end

require("lspconfig").drupalls.setup({
  -- Add any specific settings or on_attach function here
  on_attach = function(client, bufnr)
    -- Keymaps and other buffer-specific settings can go here
    -- Example: vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end,
  capabilities = require("blink.cmp").get_lsp_capabilities(), -- If using blink.cmp
})

