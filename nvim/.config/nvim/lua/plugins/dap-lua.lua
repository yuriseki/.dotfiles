-- QUICKSTART
--
-- The following steps will guide you through the process of starting a debug
-- session using nvim-dap.
--
-- Let's say you have a lua script `myscript.lua` in your home directory that has
-- the following content: >lua
--
--     print("start")
--     for i = 1, 10 do
--       print(i)
--     end
--     print("end")
-- <
-- 1. Open a Neovim instance (instance A)
-- 2. Launch the DAP server with (A) >vim
--     :lua require"osv".launch({port=8086})
-- 3. Open another Neovim instance (instance B)
-- 4. Open `myscript.lua` (B)
-- 5. Place a breakpoint on line 2 using (B) >vim
--     :lua require"dap".toggle_breakpoint()
-- 6. Connect the DAP client using (B) >vim
--     :lua require"dap".continue()
-- 7. Run `myscript.lua` in the other instance (A) >vim
--     :luafile myscript.lua
-- 8. The breakpoint should hit and freeze the instance (B)

-- DAP configuration for Lua development, specifically for Neovim plugins.
return {
  "jbyuki/one-small-step-for-vimkind",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  lazy = false,
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

    -- Dap for NeoVim plugin development debug.
    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
    end

    -- Configuration for launching a new Neovim instance for plugin development.
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        port = 8086,
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
