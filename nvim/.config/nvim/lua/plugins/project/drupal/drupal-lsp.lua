if true then return {} end
return {
  "jdrupal-dev/drupal_ls",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "neovim/nvim-lspconfig",
  -- Requires cargo to be installed locally.
  -- build = "cargo build --release",
  config = function()
    local lspconfig = require("lspconfig")

    require("lspconfig.configs").drupal_ls = {
      default_config = {
        cmd = {
          -- vim.fn.stdpath("data") .. "/lazy/drupal_ls/target/release/drupal_ls",
          "/home/yuri/opt/drupal_ls-linux-amd64",
          "--file",
          "/tmp/drupal_ls-log.txt",
        },
        filetypes = { "php", "yaml", "yml", "module", "inc" },
        root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
        settings = {},
      },
    }

    lspconfig["drupal_ls"].setup({})
  end,
}
