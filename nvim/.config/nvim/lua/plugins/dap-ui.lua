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
          started = function() end, -- Disable auto-open on debug start
          terminated = function() end, -- Disable auto-close on debug end
          event_terminated = function() end, -- Prevent close on termination
          event_exited = function() end, -- Prevent close on exit
          event_stopped = function() end, -- Prevent actions on stop
        },
      }

      -- ---------------------------------------------------------
      -- Override controls order
      -- ---------------------------------------------------------
      local controls = require("dapui.controls")
      local blinking_func = nil
      vim.api.nvim_set_hl(0, "DapUIBlink", { fg = "#ffffff", bg = "#ff0000", bold = true }) -- Bright red blink highlight

      _G._dapui_blink_timer = nil
      setmetatable(_G._dapui, {
        __index = function(_, key)
          return function()
            local result = dap[key]()
            -- Trigger blink for this func
            blinking_func = key
            if _G._dapui_blink_timer then
              _G._dapui_blink_timer:stop()
            end
            _G._dapui_blink_timer = vim.defer_fn(function()
              blinking_func = nil
              controls.refresh_control_panel()
            end, 300) -- Blink for 300ms
            controls.refresh_control_panel()
            return result
          end
        end,
      })

      controls.controls = function(is_active)
        local session = dap.session()

        local running = (session and not session.stopped_thread_id)

        local avail_hl = function(group, allow_running)
          if not session or (not allow_running and running) then
            return is_active and "DapUIUnavailable" or "DapUIUnavailableNC"
          end
          return group
        end

        local icons = opts.controls and opts.controls.icons
          or {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
            disconnect = "",
          }
        -- Reorder elems: terminate first, then play/pause, step_over, step_into, step_out, step_back, run_last, disconnect

        local elems = {
          {
            func = "play",
            icon = running and icons.pause or icons.play,
            hl = is_active and "DapUIPlayPause" or "DapUIPlayPauseNC",
          },
          { func = "step_over", hl = avail_hl(is_active and "DapUIStepOver" or "DapUIStepOverNC") },
          { func = "step_into", hl = avail_hl(is_active and "DapUIStepInto" or "DapUIStepIntoNC") },
          { func = "step_out", hl = avail_hl(is_active and "DapUIStepOut" or "DapUIStepOutNC") },
          { func = "step_back", hl = avail_hl(is_active and "DapUIStepBack" or "DapUIStepBackNC") },
          { func = "run_last", hl = is_active and "DapUIRestart" or "DapUIRestartNC" },
          { func = "terminate", hl = avail_hl(is_active and "DapUIStop" or "DapUIStopNC", true) },
          { func = "disconnect", hl = avail_hl(is_active and "DapUIStop" or "DapUIStopNC", true) },
        }
        local bar = ""
        for _, elem in ipairs(elems) do
          local hl = elem.hl
          if elem.func == blinking_func then
            hl = "DapUIBlink"
          end
          bar = bar .. ("  %%#%s#%%0@v:lua._dapui.%s@%s%%#0#"):format(hl, elem.func, elem.icon or icons[elem.func])
        end
        return bar
      end

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
            { id = "scopes", size = 0.75 },
            { id = "repl", size = 0.25 },
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      }
    end,
  },
}
