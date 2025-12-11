local util = require("conform.util")
local config = require("conform")

config.setup({
  formatters_by_ft = {
    php = { "php-cs-fixer" },
  },

  formatters = {
    ["php-cs-fixer"] = {
      command = util.find_executable({
        "tools/php-cs-fixer/vendor/bin/php-cs-fixer",
        "vendor/bin/php-cs-fixer",
      }, "php-cs-fixer"),

      args = {
        "fix",
        "$FILENAME",
        '--rules={"@PSR12": true, "array_indentation": true, "single_quote": true, "braces_position": { "control_structures_opening_brace": "same_line", "functions_opening_brace": "next_line", "classes_opening_brace": "next_line" }, "new_with_braces": true, "array_syntax": { "syntax": "short" }, "strict_param": true, "concat_space": { "spacing": "none" }}',
      },

      stdin = false,
      cwd = util.root_file({ "composer.json" }),
    },
  },
})
