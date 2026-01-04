return {
  "kkoomen/vim-doge",
  lazy = false,
  keys = {
    { "\\cd", "<Plug>(doge-generate)", desc = "Generate documentation" },
    { "<Tab>", "<Plug>(doge-comment-jump-forward)", desc = "Jump to next TODO", mode = { "n", "i", "s" } },
    { "<S-Tab>", "<Plug>(doge-comment-jump-backward)", desc = "Jump to previous TODO", mode = { "n", "i", "s" } },
  },
  config = function()
    vim.cmd([[call doge#install()]])
    vim.g.doge_php_settings = {
      resolve_fqn = 1,
    }
  end
}
