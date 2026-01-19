return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = opts.sources or {}
    -- Add dotenv-linter for .env files
    table.insert(opts.sources, nls.builtins.diagnostics.dotenv_linter)
  end,
}