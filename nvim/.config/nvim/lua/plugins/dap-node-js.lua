return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
      "rcarriga/nvim-dap-ui",
    },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = function()
      local dap = require("dap")

      -- -------------------------
      -- 🟨 JavaScript/TypeScript setup
      -- -------------------------
      -- Kill any existing js-debug-adapter processes to avoid port conflicts
      vim.fn.system("pkill -f js-debug-adapter || true")

       -- NextJS development configurations
       dap.configurations.javascript = {
         {
           name = "NextJS: Attach to dev server",
           type = "pwa-node",
           request = "attach",
           port = function()
             return tonumber(vim.fn.input("Debug port: ", "9229")) or 9229
           end,
           address = "127.0.0.1",
           cwd = "${workspaceFolder}",
           skipFiles = { "<node_internals>/**", "node_modules/**" },
           sourceMaps = true,
           resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
           sourceMapPathOverrides = {
             ["webpack://_N_E/*"] = "${workspaceFolder}/*",
             ["webpack://*"] = "${workspaceFolder}/node_modules/*",
           },
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
           name = "NextJS: Debug client-side",
           type = "chrome",
           request = "launch",
           url = "http://localhost:3000",
           webRoot = "${workspaceFolder}",
           sourceMaps = true,
           sourceMapPathOverrides = {
             ["webpack://_N_E/*"] = "${workspaceFolder}/*",
             ["webpack://*"] = "${workspaceFolder}/node_modules/*",
           },
         },
       }

      -- TypeScript configurations (same as JavaScript)
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript
    end,
  },
}
