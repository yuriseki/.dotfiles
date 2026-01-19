if true then return {} end
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- Check if the config already exists to prevent errors
if not configs.ai_lsp then
  configs.ai_lsp = {
    default_config = {
      cmd = {
        "/bin/bash",
        "-c",
        "cd /home/yuri/ssd2/project-files/Yuri/ai_lsp && source .venv/bin/activate && poetry run ai-lsp",
        -- "cd /home/yuri/ssd2/project-files/Yuri/ai_lsp && source .venv/bin/activate && DEBUG_AI_LSP=1 python -m ai_lsp.main",
        -- "cd /home/yuri/ssd2/project-files/Yuri/ai_lsp && source .venv/bin/activate && python dev_server.py --debug",
      },      filetypes = { "python", "lua", "javascript", "typescript", "php", "txt", "md", "text", "markdown"},
      root_dir = lspconfig.util.root_pattern(".git"), -- Marks the project root
      name = "ai_lsp",
      single_file_support = true,
    },
  }
end

require("lspconfig").ai_lsp.setup({
  -- Add any specific settings or on_attach function here
  on_attach = function(client, bufnr)
    -- Keymaps and other buffer-specific settings can go here
    -- Example: vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end,
  capabilities = require("blink.cmp").get_lsp_capabilities(), -- If using blink.cmp
})

