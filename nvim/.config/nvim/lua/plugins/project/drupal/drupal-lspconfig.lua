if not require("utils.project").isDrupalProject() then
  return {}
end

-- Only applicable for Drupal projects
return {
  "neovim/nvim-lspconfig",
  -- event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason-org/mason-lspconfig.nvim", "mason-org/mason.nvim" },
  opts = {
    servers = {
      intelephense = {
        cmd = { "intelephense", "--stdio" },
        settings = {
          intelephense = {
            environment = {
              includePaths = { "./vendor" }, -- important for Composer autoload
            },
            files = {
              maxSize = 5000000, -- adjust if large project
              exclude = {
                "**/vendor/**/*.Tests/**",
                "**/vendor/**/tests/**",
                "**/var/**",
                "**/pub/static/**",
                "**/generated/**",
              },
            },
            diagnostics = {
              enable = true,
            },
            stubs = {
              "drupal", -- this enables Drupal stub definitions for autocompletion
              "drupal_test",
              "drupal_console",
              "php",
              "datetime",
              "json",
            },
          },
        },
        on_new_config = function(config, root_dir)
          config.root_dir = root_dir
        end,
      },
      phpactor = {
        cmd = { "phpactor", "language-server" },
        on_new_config = function(config, root_dir)
          -- Ensure Phpactor uses the project's root directory correctly
          config.cmd_cwd = root_dir

          vim.fn.jobstart({
            "phpactor",
            "extension:install",
            "drupal",
          })
          vim.fn.jobstart({
            "phpactor",
            "extension:install",
            "symfony",
          })
        end,
        symfony = {
          enabled = true,
        },
        filetypes = { "php", "module", "install", "inc" },
        -- These options are merged with LazyVim's default options
        -- We don't need to add supported_extensions here if we use .phpactor.json
        -- but we can add general options like exclude patterns
        init_options = {
          ["language_server_phpstan.enabled"] = true,
          ["phpstan.bin"] = "./vendor/bin/phpstan",
          ["phpstan.config"] = "./phpstan.neon",
          ["indexer.exclude_patterns"] = {
            "/vendor/**/Tests",
            "/vendor/**/tests/**/*",
            "/vendor/composer/**/*",
            "/generated/**/*",
            "/pub/static/**/*", -- useful for Magento, adaptable for Drupal
            "/var/**/*",
          },
        },
        stubs = {
          "drupal", -- this enables Drupal stub definitions for autocompletion
          "drupal_test",
          "drupal_console",
          "php",
          "datetime",
          "json",
        },
      },
      -- YAML language server
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              -- Symfony DI
              ["https://getcomposer.org/schema.json"] = "/*",
              -- I could not find an equivalent to this one, so then it's
              -- commented out for now.
              -- ["https://json.schemastore.org/symfony-di.json"] = "**/*services.yaml",
              -- Drupal services
              ["https://www.schemastore.org/drupal-services.json"] = "**/*.services.yml",
            },
            validate = true,
            hover = true,
            completion = true,
          },
        },
      },
    },
    setup = {
      -- default fallback for other servers
      ["*"] = function(server, opts)
        require("lspconfig")[server].setup(opts)
      end,
    },
  },
}
