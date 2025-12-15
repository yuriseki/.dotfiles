return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
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
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
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
      }

      -- TypeScript configurations (same as JavaScript)
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript
    end,
  },
}
