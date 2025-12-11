if not require("utils.project").isDrupalProject() then
  return {}
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  optional = true,
  config = function()
    local dap = require("dap")

    -- The following assumes you've installed the php-debug-adapter using mason.nvim
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = {
        vim.loop.os_homedir() .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
      },
    }

    dap.configurations.php = {
      -- For DDEV place your luanch.json script in the root of your project:
      --     .vscode/launch.json file.
      -- Follow the DDEV instructions for VSCode:
      --     https://ddev.readthedocs.io/en/stable/users/debugging-profiling/step-debugging/#ide-setup
      -- If you encounter problems, see the DDEV troubleshooting guide:
      --     https://ddev.readthedocs.io/en/stable/users/debugging-profiling/step-debugging/#troubleshooting-xdebug
      -- Here are more related discussions that helped me get up an running:
      --     https://github.com/ddev/ddev/issues/5099
      --     https://github.com/LazyVim/LazyVim/discussions/645
      -- You might need to run `sudo ufw allow 9003` and then restart
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug in Lando (Lando xdebug on)",
        port = 9003,
        pathMappings = {
          ["/app"] = "${workspaceFolder}",
        },
      },
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug in DDEV (ddev xdebug on)",
        port = 9003,
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}",
        },
      },
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
      },
      {
        type = "php",
        name = "Listen for XDebug in Docksal",
        request = "launch",
        port = 9000,
        pathMappings = {
          ["/var/www/"] = "${workspaceFolder}",
        },
      },
    }
  end,
}
