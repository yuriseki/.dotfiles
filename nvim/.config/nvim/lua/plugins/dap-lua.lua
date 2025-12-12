-- DAP configuration for Lua development, specifically for Neovim plugins.
return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  optional = true,
  config = function()
    local dap = require("dap")

    -- Adapter for the lua-local debugger.
    -- Assumes you have run :MasonInstall lua-local
    dap.adapters.lua = {
      type = "executable",
      command = "node",
      args = {
        vim.loop.os_homedir()
          .. "/.local/share/nvim/mason/packages/local-lua-debugger-vscode/extension/extension/debugAdapter.js",
      },
      enrich_config = function(config, on_config)
        if true or not config["extensionPath"] then
          local c = vim.deepcopy(config)
          -- 💀 If this is missing or wrong you'll see
          -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
          c.extensionPath = vim.loop.os_homedir()
            .. "/.local/share/nvim/mason/packages/local-lua-debugger-vscode/extension"
          on_config(c)
        else
          on_config(config)
        end
      end,
    }

    -- Configuration for launching a new Neovim instance for plugin development.
    dap.configurations.lua = {
      {
        type = "lua",
        request = "launch",
        name = "Neovim Plugin Development",
        cwd = "${workspaceFolder}",
        -- This tells the debugger to run a new instance of Neovim
        -- that is configured to load the code from your current project directory.
        program = {
          command = "nvim",
          args = {
            "-u",
            "NONE", -- Start with a clean configuration
            "-c",
            "set runtimepath+=$PWD", -- Add current project to Neovim's runtime path
          },
        },
        stopOnEntry = true,
      },
      {
        name = "Current file (local-lua-dbg, lua)",
        type = "lua",
        repl_lang = "lua",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = {
          lua = "luajit",
          file = "${file}",
        },
        args = {},
      },
      {
        name = "Current file (local-lua-dbg, neovim lua interpreter with nlua)",
        type = "lua",
        repl_lang = "lua",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = {
          lua = "nlua",
          file = "${file}",
        },
        args = {},
      },
    }
  end,
}
