local fzf = require('fzf-lua')
local map = vim.keymap.set

map("n", "\\f\\", "<cmd>FzfLua<CR>", { desc = "[F]uzy Finder" })

map("n", "\\fc", function ()
  fzf.files({cwd=vim.fn.stdpath("config")})
end, { desc = "Neovim [C]onfiguration" })

map({"n", "v"}, "\\fw", function ()
  fzf.grep_cword()
end, {desc = "Grewp current [W]ord"})

map("n", "\\fd", function ()
        require("fzf-lua").fzf_exec("fd --type d", {
        actions = {
          ["default"] = function(sel)
            require("fzf-lua").live_grep({ cwd = sel[1] })
          end,
        },
      })
end, {desc = "Gerp [D]irectory"})

map("n", "\\fh", "<cmd>FzfLua helptags<CR>", { desc = "[H]elp tags" })
map("n", "\\ff", "<cmd>FzfLua files<CR>", { desc = "[F]iles" })
map("n", "\\fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live [G]rep" })
map("n", "\\fb", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "Live [G]rep" })
map("n", "\\fr", "<cmd>FzfLua resume<CR>", { desc = "[R]esume" })
map("n", "\\\\", "<cmd>FzfLua buffers<CR>", { desc = "[\\] Find open buffers" })

