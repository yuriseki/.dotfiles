if not require("utils.project").isDrupalProject() then
  return {}
end

return {
  "nvimtools/none-ls.nvim",
  -- opts = function()
  --   local nls = require("null-ls")
  --
  --   return {
  --     diagnostics_format = "#{m} (#{c}) [#{s}]",
  --     sources = {
  --       -- ---------------------------
  --       -- PHPCS Diagnostics (linting)
  --       -- ---------------------------
  --       nls.builtins.diagnostics.phpcs.with({
  --         command = "vendor/bin/phpcs",
  --         args = {
  --           "--standard=Drupal,DrupalPractice",
  --           "--report=json",
  --           "--stdin-path=$FILENAME",
  --           "-", -- read from stdin
  --         },
  --       }),
  --
  --       -- ---------------------------
  --       -- PHPCBF Formatting
  --       -- ---------------------------
  --       nls.builtins.formatting.phpcbf.with({
  --         command = "vendor/bin/phpcbf",
  --         args = {
  --           "--standard=Drupal,DrupalPractice",
  --           "--stdin-path=$FILENAME",
  --           "-", -- read from stdin
  --         },
  --         stdin = true,
  --       }),
  --
  --       -- ---------------------------
  --       -- PHPStan Diagnostics
  --       -- ---------------------------
  --       nls.builtins.diagnostics.phpstan.with({
  --         command = "vendor/bin/phpstan",
  --         args = {
  --           "analyze",
  --           "--error-format=json",
  --           "--configuration=phpstan.neon",
  --           "--level=5",
  --           "$FILENAME",
  --         },
  --         to_stdin = false,
  --         from_stderr = false,
  --       }),
  --     },
  --   }
  -- end,

  config = function()
    local null_ls = require("null-ls")
    local utils = require("null-ls.utils")
    null_ls.setup({
      -- Change this to debug with `:NullLsLog`. Double check PHP version.
      debug = false,
      -- Find the root directory by looking for a phpcs.xml file. This could
      -- also include composer.json, .git, etc.
      root_dir = utils.root_pattern("phpcs.xml"),
      -- `#{m}`: message
      -- `#{s}`: source name (defaults to `null-ls` if not specified)
      -- `#{c}`: code (if available)
      diagnostics_format = "#{m} (#{c}) [#{s}]",
      sources = {
        -- A manual (NOT recommended) way to enforce Drupal coding standards:
        -- In .zshrc/.bashrc:
        --   export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
        -- Install Drupal Coder:
        --   composer global require drupal/coder:8.3.13
        -- Configure the Mason phpcs to use Coder:
        --   phpcs --config-set installed_paths ~/.config/composer/vendor/drupal/coder/coder_sniffer
        -- And then add this line below:
        --   extra_args = { "--standard=Drupal" }
        --
        -- However, the better way is to first include core-dev:
        --   ddev composer require --dev drupal/core-dev
        -- And then include a phpcs.xml file, such as:
        --   https://github.com/Lullabot/drainpipe/blob/main/drainpipe-dev/scaffold/phpcs.xml.dist
        --
        -- See https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#phpcs
        null_ls.builtins.diagnostics.phpcs.with({
          prefer_local = "vendor/bin",
        }),
        -- Similarly, configure with a phpstan.neon file.
        null_ls.builtins.diagnostics.phpstan.with({
          prefer_local = "vendor/bin",
        }),
        null_ls.builtins.formatting.phpcbf.with({
          prefer_local = "vendor/bin",
        }),
        null_ls.builtins.formatting.stylua,
      },
    })

    vim.keymap.set("n", "\\cf", vim.lsp.buf.format, {desc = "[F]ormat code - Drupal"})
    vim.keymap.set("n", "<C-M-l>", vim.lsp.buf.format, {desc = "[F]ormat code - Drupal"})
    -- -- Show errors
    -- vim.keymap.set("n", "<space>er", "<cmd>lua vim.diagnostic.open_float()<CR>")
    -- -- Show current root
    -- vim.keymap.set("n", "<leader>cr", '<cmd>lua print(require("null-ls.client").get_client().config.root_dir)<CR>', {})
  end,

  -- keys = {
  --   {
  --     "<S-M-l>",
  --     vim.lsp.buf.format,
  --     desc = "Format code",
  --     mode = { "n", "i" },
  --   },
  --   {
  --     "\\cf",
  --     vim.lsp.buf.format,
  --     desc = "Format code",
  --     mode = "i",
  --   },
  -- },
}
