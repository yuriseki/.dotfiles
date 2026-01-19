-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- add any additional keymaps here
local opts = { noremap = true, silent = true }

-- remap lowercase 'q' to do nothing
vim.keymap.set("n", "q", "<nop>", { noremap = true, silent = true })
-- remap uppercase 'Q' to the original 'q' behavior (which starts recording)
vim.keymap.set("n", "Q", "q", { noremap = true })

-- undo/redo
vim.keymap.set("i", "<c-z>", "<esc>ua", { silent = true, desc = "undo" })
vim.keymap.set("i", "<c-s-z>", "<esc><c-r>a", { silent = true, desc = "redo" })
vim.keymap.set("v", "<c-z>", "<esc>u", { silent = true, desc = "undo" })
vim.keymap.set("v", "<c-s-z>", "<esc><c-r><esc>gv", { silent = true, desc = "redo" })
vim.keymap.set("n", "<c-z>", "u", { silent = true, desc = "undo" })
vim.keymap.set("n", "<c-s-z>", "<c-r>", { silent = true, desc = "redo" })

-- undo breakpoints on space and punctuation
vim.keymap.set("i", " ", " <c-g>u")
vim.keymap.set("i", "<cr>", "<cr><c-g>u")
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", ">", "><c-g>u")
vim.keymap.set("i", "<", "<<c-g>u")

-- selection commands.
vim.keymap.set("v", "<s-up>", "<up>")
vim.keymap.set("v", "<s-down>", "<down>")
vim.keymap.set("i", "<s-up>", "<esc>v<up>", opts)
vim.keymap.set("i", "<s-down>", "<esc>v<down>", opts)
vim.keymap.set("n", "<s-up>", "v<up>", opts)
vim.keymap.set("n", "<s-down>", "v<down>", opts)

vim.keymap.set("n", "<s-left>", "v<left>", { silent = true })
vim.keymap.set("n", "<s-right>", "v<right>", { silent = true })
vim.keymap.set("i", "<s-left>", "<esc>v<left>", { silent = true })
vim.keymap.set("i", "<s-right>", "<esc><right>v<right>", { silent = true })
vim.keymap.set("v", "<s-left>", "h", { silent = true })
vim.keymap.set("v", "<s-right>", "l", { silent = true })

vim.keymap.set("n", "<c-s-left>", "vb", { silent = true })
vim.keymap.set("i", "<c-s-left>", "<esc>vb", { silent = true })
vim.keymap.set("v", "<c-s-left>", "b", { silent = true })
vim.keymap.set("n", "<c-s-right>", "ve", { silent = true })
vim.keymap.set("i", "<c-s-right>", "<esc>lve", { silent = true })
vim.keymap.set("v", "<c-s-right>", "e", { silent = true })

-- select all
vim.keymap.set("n", "<c-a>", "gg<s-v>G", { desc = "select all" })
vim.keymap.set({"i", "v"}, "<c-a>", "<Esc>gg<s-v>G", { desc = "select all" })

-- other arrows movements
vim.keymap.set("n", "<m-left>", "<cmd>vertical resize -2<cr>", { desc = "decrease window width" })
vim.keymap.set("n", "<m-right>", "<cmd>vertical resize +2<cr>", { desc = "increase window width" })
vim.keymap.set("n", "<m-up>", "<cmd>resize +2<cr>", { desc = "decrease window width" })
vim.keymap.set("n", "<m-down>", "<cmd>resize -2<cr>", { desc = "increase window width" })
vim.keymap.set("n", "<c-left>", "b", { desc = "go back 1 word" })
vim.keymap.set("n", "<c-right>", "w", { desc = "go forward 1 word" })

-- -- delete word (intellij-like)
vim.keymap.set("i", "<m-bs>", "<esc>cb<del>", { desc = "delete word" })
vim.keymap.set("i", "<m-del>", "<esc>ldei", { desc = "delete word" })
vim.keymap.set("n", "<m-bs>", "cb<del>", { desc = "delete word" })
vim.keymap.set("n", "<m-del>", "de", { desc = "delete word" })

-- copy/paste inside insert mode
-- vim.keymap.set("v", "y", '"+y<esc>i', { noremap = true, silent = true, desc = "yank" })
vim.keymap.set("i", "<m-v>", "<c-r>0", opts)
vim.keymap.set({"v", "n"}, "<m-v>", '"0p', opts)
vim.keymap.set({ "i", "v" }, "jk", "<Esc>", { desc = "Esc alternative" })

-- Make deletions and changes not override the unnamed register (clipboard)
-- vim.keymap.set("n", "x", '"xx')
-- vim.keymap.set("n", "d", '"dd')
-- vim.keymap.set("v", "d", '"dd')
-- vim.keymap.set("n", "c", '"cc')

-- Other text edit navigation
vim.keymap.set("i", "<S-End>", "<esc>lv$h", { noremap = true, desc = "Select end" })
vim.keymap.set("n", "<S-End>", "v$h", { noremap = true, desc = "Select end" })
vim.keymap.set("v", "<end>", "$h", { noremap = true, desc = "Select end" })
vim.keymap.set("i", "<Home>", "<Esc>^i", { noremap = true, desc = "Go home" })
vim.keymap.set("i", "<S-Home>", "<esc>v^", { noremap = true, desc = "Select home" })
vim.keymap.set("n", "<S-Home>", "v^", { noremap = true, desc = "Select home" })

-- Sanity keybindings. The ones I press all the time forgoting to enter in normal mode.
-- vim.keymap.set("i", ":q", "<esc>:q", { noremap = true, desc = "Don't mess with the content trying to quit" })
-- vim.keymap.set("i", "ciw", "<esc>ciw", { noremap = true, desc = "Change word" })
-- vim.keymap.set("i", 'ci"', '<esc>ci"', { noremap = true, desc = 'Chenge inner ""' })
-- vim.keymap.set("i", "ci'", "<esc>ci'", { noremap = true, desc = "Chenge inner ''" })
-- vim.keymap.set("i", "ci(", "<esc>ci(", { noremap = true, desc = "Chenge inner ()" })
-- vim.keymap.set("i", "ci{", "<esc>ci{", { noremap = true, desc = "Chenge inner {}" })
-- vim.keymap.set("i", "ciq", "<esc>ciq", { noremap = true, desc = "Chenge inner {}" })
-- vim.keymap.set("i", "cib", "<esc>cib", { noremap = true, desc = "Chenge inner {}" })
-- vim.keymap.set("i", "yyp", "<esc>yyp", { noremap = true, desc = "Duplicate line" })
vim.keymap.set("i", "<C-d>", "<esc>yypi", { noremap = true, desc = "Duplicate line" })

-- Oil navigation
-- vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open current directory in Oil" })

-- Tabs
vim.keymap.set("i", "<S-Tab>", "<C-D>", { desc = "Unindent" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Ident" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent" })

-- ----------------------------------------------------------------------------
-- UI keys.
-- ----------------------------------------------------------------------------
vim.keymap.set("n", "<C-b>", function()
  Snacks.bufdelete()
end, { noremap = true, desc = "Delete Buffer" })

vim.keymap.set({ "n", "v" }, "<C-M-]>", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "v" }, "<C-M-[>", ":bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set({ "n", "v" }, "<C-M-p>", ":b#<CR>", { desc = "Previous visualised Buffer" })
vim.keymap.set("i", "<C-M-]>", "<Esc>:bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("i", "<C-M-[>", "<Esc>:bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("i", "<C-M-p>", "<Esc>:b#<CR>", { desc = "Previous visualised Buffer" })

-- ----------------------------------------------------------------------------
-- Coding keys.
-- ----------------------------------------------------------------------------
-- Already defined in drupal-keybindings.lua
-- vim.api.nvim_create_user_command("DrupalFormat", function()
--   require("utils.drupal-formatter").drupal_file_format()
-- end, {})
-- vim.keymap.set("n", "\\cc", ":DrupalFormat<CR>", { desc = "Drupal Format File" })
--
-- vim.api.nvim_create_user_command("DrupalFormatRange", function()
--   require("utils.drupal-formatter").drupal_format_selection()
-- end, { range = true })
--
-- vim.keymap.set("v", "\\cf", ":DrupalFormatRange<CR>")
--
vim.keymap.set("n", "\\cm", function()
  vim.cmd([[
    %join!
    %s/\s\+/ /g
    %s/^\s\+//
    %s/\s\+$//
  ]])
end, { desc = "[M]inify text" })

-- Insert new line between pairs of brackets or quotes.
local check_pair = require("utils.check-pair").check_pair
vim.keymap.set("i", "<cr>", function()
  if check_pair() then
    return "<cr><esc>O"
  else
    return "<cr><c-g>u"
  end
end, { expr = true })

--This is check how
