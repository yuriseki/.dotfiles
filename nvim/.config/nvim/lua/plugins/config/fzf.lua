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

map("n", "\\fh", "<cmd>FzfLua helptags<CR>", { desc = "Help tags" })
map("n", "\\ff", "<cmd>FzfLua files<CR>", { desc = "Files" })
map("n", "\\fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
map("v", "\\fg", function()
  local selected = fzf.utils.get_visual_selection()
  fzf.live_grep({ search = selected })
end, { desc = "Live Grep selection" })
map("n", "\\fb", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "Grep current buffer" })
map("n", "\\fr", "<cmd>FzfLua resume<CR>", { desc = "Resume" })
map("n", "\\\\", "<cmd>FzfLua buffers<CR>", { desc = "[\\] Find open buffers" })
