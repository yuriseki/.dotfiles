return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    config = function()
      require("jupytext").setup({
        style = "hydrogen",
        output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
        force_ft = nil, -- Default filetype. Don't change unless you know what you are doing
        custom_language_formatting = {},
      })
    end,
  },
}
