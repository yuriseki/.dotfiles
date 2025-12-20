return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text", -- Displays the variable values as a virtual text.
    },
    keys = {
      {
        "<F4>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "DAP Toggle Breakpoint",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "DAP Continue / Play",
      },
      {
        "<F6>",
        function()
          require("dapui").toggle()
        end,
        desc = "DAP Toggle UI",
      },
      {
        "<F9>",
        function()
          require("dap").step_over()
        end,
        desc = "DAP Step Over",
      },
      {
        "<F10>",
        function()
          require("dap").step_into()
        end,
        desc = "DAP Step Into",
      },
      {
        "<S-F10>",
        function()
          require("dap").step_out()
        end,
        desc = "DAP Step Out",
      },
    },

    opts = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      -- ---------------------------------------------------------
      -- 🔥 GLOBAL DAP ICONS (Apply to ALL languages)
      -- ---------------------------------------------------------
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = " ", texthl = "DiagnosticError", linehl = "Visual" })

      -- ---------------------------------------------------------
      -- Configure Listeners to prevent auto-open/close
      -- ---------------------------------------------------------
      opts.listeners = {
        dap = {
          started = function() end,  -- Disable auto-open on debug start
          terminated = function() end,  -- Disable auto-close on debug end
        },
      }

      -- ---------------------------------------------------------
      -- Configure Layout
      -- ---------------------------------------------------------
      opts.layouts = {
        {
          elements = {
            { id = "console", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left", -- Can be "left" or "right"
        },
        {
          elements = {
            "scopes",
            "repl",
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      }
    end,
  },
}
