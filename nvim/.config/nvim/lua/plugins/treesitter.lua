return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add parsers to the list of ensured installed parsers
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "phpdoc", "php" })
    end
  end,
}
