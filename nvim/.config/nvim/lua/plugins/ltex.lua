return {
  "vigoux/ltex-ls.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("ltex-ls").setup({
      use_spellfile = true,
      filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
      settings = {
        ltex = {
          language = "auto",
          disabledRules = {
            en = {
              "UPPERCASE_SENTENCE_START",  -- Disable for Markdown task lists
            },
          },
        },
      },
    })
  end,
}
