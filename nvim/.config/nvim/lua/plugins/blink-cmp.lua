return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
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
      ["<CR>"] = { "accept", "fallback" },
      ["<M-Esc>"] = { "hide" },
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
        show_without_menu = true,
      },
      menu = {
        auto_show_delay_ms = 500,
      },
      documentation = { auto_show = false },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
