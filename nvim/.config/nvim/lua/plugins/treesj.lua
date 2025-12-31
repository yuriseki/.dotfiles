return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup(
      -- For default preset
      vim.keymap.set("n", "<leader>m", require("treesj").toggle),
      -- For extending default preset with `recursive = true`
      vim.keymap.set("n", "<leader>M", function()
        require("treesj").toggle({ split = { recursive = true } })
      end, {desc = "Split or join codeblocks - Recursive"})
    )
  end,
}
