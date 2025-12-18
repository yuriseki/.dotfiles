return {
  "saghen/blink.cmp",
  enabled = true,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "moyiz/blink-emoji.nvim",
  },
  -- use a release tag to download pre-built binaries
  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "super-tab",
      -- ["<CR>"] = { "accept", "fallback" },
      ["<M-q>"] = { "hide" },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned.
      nerd_font_variant = "normal",
    },

    -- (Default) Only show the documentation popup when manually triggered.
    completion = {
      ghost_text = {
        show_with_menu = true,
        show_without_menu = true, -- Show ghost text even without menu for IntelliJ-like hints
      },
      menu = {
        auto_show_delay_ms = 100, -- Even faster for immediate response
      },
      documentation = { auto_show = false }, -- Displayed with crtl+space
      -- Avoid duplicate suggestions from multiple sources
      list = {
        selection = { preselect = false, auto_insert = false },
      },
    },
    signature = { enabled = true },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to ``
    sources = {
      default = { "lsp", "path", "buffer", "snippets", "emoji" },
      -- Prioritize LSP for context-aware completions
      providers = {
        -- lsp = {
        --   score_offset = 100, -- Boost LSP suggestions for higher priority
        -- },
        -- buffer = {
        --   score_offset = 50, -- Boost buffer for intra-file context
        -- },
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = {
            insert = true, -- Insert emoji (default) or complete its name
            ---@type string|table|fun():table
            trigger = function()
              return { ":" }
            end,
          },
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end,
        },
        comrade = {
          module = "blink_comrade",
          name = "Comrade",
        },
      },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
      -- Enable prebuilt binaries for better performance
    },
  },
  opts_extend = { "sources.default" },
}
