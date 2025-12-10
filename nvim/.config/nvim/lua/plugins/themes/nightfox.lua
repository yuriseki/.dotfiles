return {
  "EdenEast/nightfox.nvim",
  -- disable whle it's not yet configured.
  enable = false,
  opts = function()
    local bluloco = {
      -- syntax
      bg = "#282C34",
      bgFloat = "#21242D",
      fg = "#ABB2BF",
      cursor = "#FFCC00",
      keyword = "#10B1FE",
      comment = "#636D83",
      punctuation = "#7A82DA",
      method = "#3FC56B",
      type = "#FF6480",
      string = "#F9C859",
      number = "#FF78F8",
      constant = "#9F7EFE",
      tag = "#3691FF",
      attribute = "#FF936A",
      property = "#CE9887",
      parameter = "#8bcdef",
      label = "#50acae",
      module = "#FF839B",
      -- workspace
      primary = "#3691ff",
      selection = "#274670",
      search = "#1A7247",
      diffAdd = "#105B3D",
      diffChange = "#10415B",
      diffDelete = "#522E34",
      added = "#177F55",
      changed = "#1B6E9B",
      deleted = "#A14D5B",
      diffText = "#10415B",
      error = "#ff2e3f",
      errorBG = "#FDCFD1",
      warning = "#da7a43",
      warningBG = "#F2DBCF",
      info = "#3691ff",
      infoBG = "#D4E3FA",
      hint = "#7982DA",
      mergeCurrent = "#4B3D3F",
      mergeCurrentLabel = "#604B47",
      mergeIncoming = "#2F476B",
      mergeIncomingLabel = "#305C95",
      mergeParent = "#EB1C20",
      mergeParentLabel = "#EB1D29",
      copilot = "#95A922",

      -- terminal
      terminalBlack = "#42444d",
      terminalRed = "#fc2e51",
      terminalGreen = "#25a45c",
      terminalYellow = "#ff9369",
      terminalBlue = "#3375fe",
      terminalMagenta = "#9f7efe",
      terminalCyan = "#4483aa",
      terminalWhite = "#cdd3e0",
      terminalBrightBlack = "#8f9aae",
      terminalBrightRed = "#ff637f",
      terminalBrightGreen = "#3fc56a",
      terminalBrightYellow = "#f9c858",
      terminalBrightBlue = "#10b0fe",
      terminalBrightMagenta = "#ff78f8",
      terminalBrightCyan = "#5fb9bc",
      terminalBrightWhite = "#ffffff",
      rainbowRed = "#FF6666",
      rainbowYellow = "#f4ff78",
      rainbowBlue = "#44A5FF",
      rainbowOrange = "#ffa023",
      rainbowGreen = "#92f535",
      rainbowViolet = "#ff78ff",
      rainbowCyan = "#28e4eb",
      rainbowIndigo = "#9F7EFE",
    }

    require("nightfox").setup({
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false, -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true, -- Default enable value for modules
        styles = { -- Style to be applied to different syntax groups
          comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          keywords = "italic",
          numbers = "NONE",
          operators = "NONE",
          strings = "italic",
          types = "NONE",
          variables = "NONE",
        },
        inverse = { -- Inverse highlight for different types
          match_paren = false,
          visual = false,
          search = false,
        },
        modules = { -- List of various plugins and additional options
          -- ...
        },
      },
      palettes = {
        nordfox = {

          black = bluloco.terminalBlack,
          red = bluloco.type,
          -- "green" = "", --  │Shade Color (Base, Bright, Dim)
          -- "yellow" = "", -- │Shade Color (Base, Bright, Dim)
          -- "blue" = "", --   │Shade Color (Base, Bright, Dim)
          -- "magenta" = "", --│Shade Color (Base, Bright, Dim)
          -- "cyan" = "", --   │Shade Color (Base, Bright, Dim)
          -- "white" = "", --  │Shade Color (Base, Bright, Dim)
          -- "orange" = "", -- │Shade Color (Base, Bright, Dim)
          -- "pink" = "", --   │Shade Color (Base, Bright, Dim)
          -- "comment" = "", --│Comment color
          bg0 = bluloco.bgFloat, --"    │Darker bg (status line and float)
          bg1 = bluloco.bg, --"    │Default bg
          -- "bg2" = "", --"    │Lighter bg (colorcolumn folds)
          -- "bg3" = "", --"    │Lighter bg (cursor line)
          -- "bg4" = "", --"    │Lighter bg (Conceal, border fg)
          -- "fg0" = "", --"    │Lighter fg
          fg1 = "#ABB2BF", --"    │Default fg
          -- "fg2" = "", --"    │Darker fg (status line)
          -- "fg3" = "", --"    │Darker fg (line numbers, fold columns)
          -- "sel0" = "", --"   │Popup bg, visual selection bg
          -- "sel1" = "", --"   │Popup sel bg, search bg
        },
      },
      specs = {
        nordfox = {
          syntax = {
            operator = bluloco.punctuation,
            field = bluloco.property,
          },
        },
      },
      groups = {
        nordfox = {
          -- Position the name in the word and execute `:Inspect` to get the
          -- correct name from treesitter
          ["@variable.member"] = { fg = bluloco.cursor },
          ["@namespace"] = { fg = bluloco.type },
          -- LineNr = { fg = bluloco.cursor },
        },
      },
    })

    -- setup must be called before loading
    -- vim.cmd("colorscheme nordfox")
  end,
}
