-- Execute the following command to start uvicorn and allow nvim-dap-python to attach the debugger:
-- python -m debugpy --listen 5678 --wait-for-client -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
-- In nvim, use the command `VenvSelect` to select the virtual environment.
return {
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "linux-cultist/venv-selector.nvim",
    },
    ft = "python",
    config = function()
      local dap = require("dap")
      local venv = require("venv-selector")

      -- -------------------------
      -- 🧪 Python setup
      -- -------------------------
      local python_path = venv.python() or "python"

      dap.adapters.python = {
        type = "server",
        host = "127.0.0.1",
        port = 5678, -- must match your debugpy --listen
        executable = {
          command = python_path,
          args = { "-m", "debugpy.adapter" },
        },
      }

      dap.configurations.python = {
        {
          -- Launch a script directly
          name = "Python: Launch file",
          type = "python",
          request = "launch",
          program = "${file}",
          console = "integratedTerminal",
        },
        {
          -- Attach to FastAPI by executing:
          -- python -m debugpy --listen 5678 --wait-for-client -m uvicorn app.main:app --reload
          name = "Python: Attach to FastAPI",
          type = "python",
          request = "attach",
          host = "127.0.0.1",
          port = 5678,
          justMyCode = false,
          pathMappings = {
            {
              localRoot = vim.fn.getcwd(),
              remoteRoot = ".",
            },
          },
        },
        {
          -- Attach to AI LSP server
          name = "Python: Attach to AI LSP",
          type = "python",
          request = "attach",
          host = "127.0.0.1",
          port = 5678,
          justMyCode = false,
          pathMappings = {
            {
              localRoot = "/home/yuri/ssd2/project-files/Yuri/ai_lsp",
              remoteRoot = ".",
            },
          },
        },
      }

      -- -------------------------
      -- 🔄 Auto-update DAP after selecting venv
      -- -------------------------
      vim.api.nvim_create_autocmd("User", {
        pattern = "VenvSelectActivated",
        callback = function()
          local new_python = venv.python()
          if new_python then
            dap.adapters.python.executable.command = new_python
            vim.notify("DAP Python interpreter updated:\n" .. new_python, vim.log.levels.INFO)
          end
        end,
      })
    end,
  },

  {
    -- Python helpers
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function(_, opts)
      -- nvim-dap-python can be initialized with any python path,
      -- but we override it dynamically with venv-selector anyway.
      require("dap-python").setup("python")
    end,
  },
}
