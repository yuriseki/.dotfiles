if not require("utils.project").isDrupalProject() then
  return {}
end

return {
  "nvimtools/none-ls.nvim",
  opts = function()
    local nls = require("null-ls")

    return {
      diagnostics_format = "#{m} (#{c}) [#{s}]",
      sources = {
        -- ---------------------------
        -- PHPCS Diagnostics (linting)
        -- ---------------------------
        nls.builtins.diagnostics.phpcs.with({
          command = "vendor/bin/phpcs",
          args = {
            "--standard=Drupal,DrupalPractice",
            "--report=json",
            "--stdin-path=$FILENAME",
            "-", -- read from stdin
          },
        }),

        -- ---------------------------
        -- PHPCBF Formatting
        -- ---------------------------
        nls.builtins.formatting.phpcbf.with({
          command = "vendor/bin/phpcbf",
          args = {
            "--standard=Drupal,DrupalPractice",
            "--stdin-path=$FILENAME",
            "-", -- read from stdin
          },
          stdin = true,
        }),

        -- ---------------------------
        -- PHPStan Diagnostics
        -- ---------------------------
        nls.builtins.diagnostics.phpstan.with({
          command = "vendor/bin/phpstan",
          args = {
            "analyze",
            "--error-format=json",
            "--configuration=phpstan.neon",
            "--level=5",
            "$FILENAME",
          },
          to_stdin = false,
          from_stderr = false,
        }),
      },
    }
  end,
}
