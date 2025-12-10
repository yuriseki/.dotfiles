return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,

                -- Force Snacks pickers to use the directory where nvim was started
        -- root = {
        --   -- Prefer CWD
        --   fallback = function()
        --     return vim.loop.cwd()
        --   end,
        -- },
      },
    },
  },
}
