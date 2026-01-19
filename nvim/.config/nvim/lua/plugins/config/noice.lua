require("noice").setup({
  routes = {
    {
      filter = {
        event = "lsp",
        kind = "progress",
        cond = function(message)
          -- Disable Phpactor noice message as it sticks forever.
          local client = vim.tbl_get(message.opts, "progress", "client")
          return client == "phpactor"
        end,
      },
      opts = { skip = true },
    },
  },
})
