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
      ["<C-y>"] = { "accept", "fallback" },
      ["<M-q>"] = { "hide" },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned.
      nerd_font_variant = "mono",
    },

    -- (Default) Only show the documentation popup when manually triggered.
    completion = {
      keyword = {
        range = "full", -- Only complete from word start to avoid overlapping ghost text
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      ghost_text = {
        enabled = true,
        show_with_menu = true,
        show_without_menu = true, -- Show ghost text even without menu for IntelliJ-like hints
      },
      -- Enable inline completions for AI suggestions
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_insert = true,
        show_on_insert_on_trigger_character = true,
      },
      menu = {
        auto_show_delay_ms = 500,
      },
      documentation = { auto_show = false }, -- Displayed with crtl+space
    },
    signature = { enabled = true },
    snippets = {
      preset = "luasnip",
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to ``
    sources = {
      default = {
        "lsp",
        "path",
        "buffer",
        "snippets",
        "emoji",
      },
      -- Prioritize LSP for context-aware completions
      providers = {
        lsp = {
          score_offset = 20, -- Boost LSP suggestions for higher priority
        },
        buffer = {
          score_offset = 0, -- Boost buffer for intra-file context
        },
        path = {
          score_offset = 0, -- Boost buffer for intra-file context
        },
        snippets = {
          score_offset = 0, -- Boost buffer for intra-file context
        },
        -- avante = {
        --   module = "blink-cmp-avante",
        --   name = "Avante",
        --   opts = {
        --     -- options for blink-cmp-avante
        --   },
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
      },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
      -- Enable prebuilt binaries for better performance
    },
  },
  opts_extend = { "sources.default" },
  -- config = function(_, opts)
  --   -- Custom patch to remove duplicates.
  --   local list = require("blink.cmp.completion.list")
  --   ---@diagnostic disable-next-line: duplicate-set-field
  --   require("blink.cmp.completion.list").fuzzy = function(context, items_by_source)
  --     local fuzzy = require("blink.cmp.fuzzy")
  --     local filtered_items = fuzzy.fuzzy(
  --       context.get_line(),
  --       context.get_cursor()[2],
  --       items_by_source,
  --       require("blink.cmp.config").completion.keyword.range
  --     )
  --
  --     local unique_items = {}
  --     local seen = {}
  --     for _, item in ipairs(filtered_items) do
  --       local key = item.label .. ":" .. (item.source_id or "")
  --       if not seen[key] then
  --         seen[key] = true
  --         table.insert(unique_items, item)
  --       end
  --     end
  --
  --     -- apply the per source max_items
  --     filtered_items = require("blink.cmp.sources.lib").apply_max_items_for_completions(context, unique_items)
  --
  --     -- apply the global max_items
  --     return require("blink.cmp.lib.utils").slice(filtered_items, 1, list.config.max_items)
  --   end
  --
  --   require("blink.cmp").setup(opts)
  -- end,
}
