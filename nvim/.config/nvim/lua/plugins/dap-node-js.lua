return {
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      local dap = require("dap")

      -- -------------------------
      -- 🟨 JavaScript/TypeScript setup
      -- -------------------------
      -- Kill any existing js-debug-adapter processes to avoid port conflicts
      vim.fn.system("pkill -f js-debug-adapter || true")

      -- Configure Node.js adapter manually
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = 8123,
        executable = {
          command = "js-debug-adapter",
          args = { "8123" },
        },
      }

      -- NextJS development configurations
      dap.configurations.javascript = {
        {
          name = "NextJS: Launch dev server",
          type = "pwa-node",
          request = "launch",
          program = "${workspaceFolder}/node_modules/.bin/next",
          args = { "dev" },
          cwd = "${workspaceFolder}",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          -- Alternative: Use external terminal if you prefer
          console = "externalTerminal",
          -- console = "integratedTerminal",
        },
        {
          name = "NextJS: Debug current file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
          name = "NextJS: Attach to running process",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
          name = "NextJS: Attach to dev server (port 9229)",
          type = "pwa-node",
          request = "attach",
          port = 9229,
          address = "127.0.0.1",
          -- Match launch config exactly
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          -- Try with minimal settings first (like launch config)
          -- If breakpoints still don't work, the issue is likely with
          -- how NextJS handles source maps when started manually
        },
        -- {
        --   name = "NextJS: Attach to dev server (auto-detect port)",
        --   type = "pwa-node",
        --   request = "attach",
        --   port = function()
        --     -- Try common debug ports
        --     local ports = { 9229, 9930, 9222, 9223, 9224, 9225 }
        --     for _, port in ipairs(ports) do
        --       local handle = io.popen("lsof -i :" .. port .. " 2>/dev/null")
        --       if handle then
        --         local result = handle:read("*a")
        --         handle:close()
        --         if result and result ~= "" then
        --           return port
        --         end
        --       end
        --     end
        --     return 9229 -- fallback
        --   end,
        --   host = "127.0.0.1",
        --   cwd = "${workspaceFolder}",
        --   skipFiles = { "<node_internals>/**", "node_modules/**" },
        -- },
      }

      -- TypeScript configurations (same as JavaScript)
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript
    end,
  },
}
