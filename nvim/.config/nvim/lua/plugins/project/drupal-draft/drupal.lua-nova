-- if true then
--   return {}
-- end
-- lua/plugins/drupal.lua
-- Drupal LazyVim preset: Intelephense + PHPCS (Drupal) + Twig + YAML + manual lint/fix commands

local function is_drupal_root()
  local root = vim.fn.getcwd()
  return vim.fn.isdirectory(vim.fn.expand(root .. "/web/core/lib/Drupal")) == 1
end

local function project_root()
  -- tries to detect root by walking up until it finds web/core or .git
  local util = require("lspconfig.util")
  local root = util.root_pattern("web/core", ".git")(vim.fn.getcwd())
  return root or vim.fn.getcwd()
end

if not is_drupal_root() then
  return {}
end

-- Define the PHPCS inside the project.
local function project_phpcs()
  local root = project_root()
  -- local vendor_phpcs = root .. "/vendor/bin/phpcs"
  local vendor_phpcs = "/home/yuri/.config/composer/vendor/bin/phpcs"
  if vim.fn.executable(vendor_phpcs) == 1 then
    return vendor_phpcs
  end
  return "phpcs" -- fallback
end

-- Define the PHPBCF inside the project.
local function project_phpcbf()
  local root = project_root()
  -- local vendor_phpcbf = root .. "/vendor/bin/phpcbf"
  local vendor_phpcbf = "/home/yuri/.config/composer/vendor/bin/phpcbf"
  if vim.fn.executable(vendor_phpcbf) == 1 then
    return vendor_phpcbf
  end
  return "phpcbf" -- fallback
end

-----------------------------------------------------------
-- Set PHPCS paths glocabbly
-----------------------------------------------------------
-- print("PHPCS: " .. project_phpcs())
vim.g.nvim_phpcs_config_phpcs_path = project_phpcs()
vim.g.nvim_phpcbf_config_phpcbf_path = project_phpcbf()

-----------------------------------------------------------
-- Paths
-----------------------------------------------------------
local ROOT = project_root()
local PATHS = {
  vendor = ROOT .. "/vendor",
  core = ROOT .. "/web/core",
  modules = ROOT .. "/web/modules",
  themes = ROOT .. "/web/themes",
}

local function existing_paths(tbl)
  local out = {}
  for _, p in ipairs(tbl) do
    if vim.fn.isdirectory(p) == 1 then
      table.insert(out, p)
    end
  end
  return out
end

-----------------------------------------------------------
-- Core Plugin Config
-----------------------------------------------------------
return {
  -- ------------------------------------------------------
  --   -- Define Drupal SubGroup in the Code group.
  -- ------------------------------------------------------
  {
    "folke/which-key.nvim",
    -- optional = true,
    opts = function()
      local wk = require("which-key")
      wk.add({
        { "\\d", group = "[D]rupal" },
      })
    end,
  },

  -- 1) LSP servers configuration (Intelephense + yaml + twig)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason-lspconfig.nvim", "mason-org/mason.nvim" },
    opts = {
      servers = {
        phpactor = {
          cmd = { "phpactor", "language-server" },
          symfony = {
            enabled = true,
          },
          -- These options are merged with LazyVim's default options
          -- We don't need to add supported_extensions here if we use .phpactor.json
          -- but we can add general options like exclude patterns
          init_options = {
            ["indexer.exclude_patterns"] = {
              "/vendor/**/Tests",
              "/vendor/**/tests/**/*",
              "/vendor/composer/**/*",
              "/generated/**/*",
              "/pub/static/**/*", -- useful for Magento, adaptable for Drupal
              "/var/**/*",
            },
          },
          -- Ensure Phpactor uses the project's root directory correctly
          on_new_config = function(config, root_dir)
            config.cmd_cwd = root_dir
          end,
        },
      },
      setup = {
        -- default fallback for other servers
        ["*"] = function(server, opts)
          require("lspconfig")[server].setup(opts)
        end,
      },
    },
  },

  -- 2) null-ls (PHPCS diagnostics + PHPCBF formatter) but used manually
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      local sources = {}

      -- PHPCS as diagnostics (Drupal standards). Requires phpcs installed and Drupal coder
      table.insert(
        sources,
        nls.builtins.diagnostics.phpcs.with({
          command = "phpcs", -- ensure this is in PATH (composer global or project)
          args = { "--report=json", "--standard=Drupal,DrupalPractice", "-" },
          -- run via manual command; null-ls may invoke it on open/save depending on setup
        })
      )

      -- PHPCBF as formatting (manual use)
      if nls.builtins.formatting.phpcbf then
        table.insert(
          sources,
          nls.builtins.formatting.phpcbf.with({
            command = "phpcbf",
            args = { "--standard=Drupal,DrupalPractice", "-" },
          })
        )
      end

      return {
        root_dir = require("null-ls.utils").root_pattern("web/core", ".git"),
        sources = sources,
        on_attach = function(client, bufnr)
          -- prevent null-ls from auto-formatting on save (we want manual)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      }
    end,
  },

  -- 4) Optional: ensure mason installs servers commonly used for this preset
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "yaml-language-server",
        "php-debug-adapter",
        -- twig-language-server may not be available in mason; install manually if needed
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "php-debug-adapter",
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    optional = true,
    config = function()
      local dap = require("dap")
      -- local dapui = require("dapui")

      -- The following assumes you've installed the php-debug-adapter using mason.nvim
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = {
          vim.loop.os_homedir()
            .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
        },
      }

      dap.configurations.php = {
        -- For DDEV place your luanch.json script in the root of your project:
        --     .vscode/launch.json file.
        -- Follow the DDEV instructions for VSCode:
        --     https://ddev.readthedocs.io/en/stable/users/debugging-profiling/step-debugging/#ide-setup
        -- If you encounter problems, see the DDEV troubleshooting guide:
        --     https://ddev.readthedocs.io/en/stable/users/debugging-profiling/step-debugging/#troubleshooting-xdebug
        -- Here are more related discussions that helped me get up an running:
        --     https://github.com/ddev/ddev/issues/5099
        --     https://github.com/LazyVim/LazyVim/discussions/645
        -- You might need to run `sudo ufw allow 9003` and then restart
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug in Lando (Lando xdebug on)",
          port = 9003,
          pathMappings = {
            ["/app"] = "${workspaceFolder}",
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug in DDEV (ddev xdebug on)",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
        },
        {
          type = "php",
          name = "Listen for XDebug in Docksal",
          request = "launch",
          port = 9000,
          pathMappings = {
            ["/var/www/"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },

  -- 5) snippets (basic Drupal snippet source using luasnip)
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      if not is_drupal_root() then
        return
      end
      local ls = require("luasnip")
      -- example Drupal snippet: hook_form_alter
      ls.add_snippets("php", {
        ls.parser.parse_snippet(
          "hfa",
          [[
/**
 * Implements hook_form_alter().
 */
function ${1:MODULE}_form_alter(&$form, \\Drupal\\Core\\Form\\FormStateInterface $form_state, $form_id) {
  if ($form_id === '${2:form_id}') {
    // ...
  }
}
]]
        ),
      })
    end,
  },

}
