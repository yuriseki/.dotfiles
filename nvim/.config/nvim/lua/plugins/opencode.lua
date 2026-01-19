return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
  end,
  keys = {
    -- Recommended/example keymaps.
    {
      "\\oa",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "Ask opencode",
    },
    {
      "\\ox",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "Execute opencode action…",
    },
    {
      "\\or",
      function()
        return require("opencode").operator("@this")
      end,
      expr = true,
      mode = { "n", "x" },
      desc = "Add range to opencode",
    },
    {
      "\\ol",
      function()
        return require("opencode").operator("@this") .. "_"
      end,
      expr = true,
      mode = { "n" },
      desc = "Add line to opencode",
    },
    {
      "\\oo",
      function()
        require("opencode").toggle()
      end,
      mode = { "n", "t" },
      desc = "Toggle opencode",
    },
    {
      "\\os",
      function()
        require("opencode").select()
      end,
      mode = { "n" },
      desc = "Select available options",
    },
    {
      "<S-C-u>",
      function()
        require("opencode").command("session.half.page.up")
      end,
      mode = "n",
      desc = "opencode half page up",
    },
    {
      "<S-C-d>",
      function()
        require("opencode").command("session.half.page.down")
      end,
      mode = "n",
      desc = "opencode half page down",
    },
  },
}
