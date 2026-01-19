return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostics disable: missing-fields
  opts = {
    zfz_opts = {
      ["--bind"] = "alt-w:wincmd w",
   },
    -- keymap = {
    --    fzf = {
    --      ["alt-w"] = "execute:wincmd w<CR>", -- Cycle windows
    --    },
    --  },
  },
  ---@diagnostics enable: missing-fields
  -- keys = {
  --   {""},
  -- }
  files = {
    fd_opts = [[--color=always --hidden --type f --type l --exclude .git]],
  },
}
