-- Include here the LSPs
local servers = {
  bashls = {},
  -- intelephense = {},
  phpactor = {},
  yamlls = {},
  lua_ls = {},
  jdtls = {}, -- Add Java LSP for IntelliJ-like suggestions
  -- ts_ls = {
  --   settings = {
  --     typescript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "none",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = false,
  --         includeInlayVariableTypeHints = false,
  --         includeInlayPropertyDeclarationTypeHints = false,
  --         includeInlayFunctionLikeReturnTypeHints = false,
  --         includeInlayEnumMemberValueHints = false,
  --       },
  --     },
  --     javascript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "none",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = false,
  --         includeInlayVariableTypeHints = false,
  --         includeInlayPropertyDeclarationTypeHints = false,
  --         includeInlayFunctionLikeReturnTypeHints = false,
  --         includeInlayEnumMemberValueHints = false,
  --       },
  --     },
  --   },
  -- },
  vtsls = {}, -- Use vtsls for JavaScript/TS instead of ts_ls
  pyright = {},
  cssls = {},
  html = {},
  jsonls = {},
}
--
-- configs.setup
local ensure_installed = vim.tbl_keys(servers or {})

-- Include here other non LSP packages to make sure Manson have installed.
vim.list_extend(ensure_installed, {
  "shellcheck", -- bash linter
  "bash-debug-adapter", -- bash DAP
  "shfmt", -- bash formatter
  "local-lua-debugger-vscode", -- Lua DAP
  "js-debug-adapter", -- JavaScript/TypeScript DAP
  "php-debug-adapter",
  "black", -- Python formatter
  "php-cs-fixer",
  "prettier",
  "prettierd",
  "dotenv-linter",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

local original_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
-- local capabilities = require("nvim-cmp").get_lsp_capabilities(original_capabilities)
-- local capabilities = original_capabilities

require("mason-lspconfig").setup({
  ensure_installed = {}, -- explicitly set to an empty table (populates installs via mason-tool-installer)
  automatic_installation = true,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for ts_ls)
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      server.on_attach = function(client)
        -- Disable inlay hints to prevent column out of range errors
        client.server_capabilities.inlayHintProvider = false
      end
      require("lspconfig")[server_name].setup(server)
    end,
  },
})
