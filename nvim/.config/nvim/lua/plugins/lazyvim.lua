return {
  "LazyVim/LazyVim",
  opts = {
    root = {
      detect = function()
        return vim.loop.cwd()
      end,
    },
  },
}
