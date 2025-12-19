-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }

-- Remap lowercase 'q' to do nothing
vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })
-- Remap uppercase 'Q' to the original 'q' behavior (which starts recording)
vim.keymap.set("n", "Q", "q", { noremap = true })

-- Undo/Redo
vim.keymap.set("i", "<C-z>", "<Esc>ua", { silent = true, desc = "Undo" })
vim.keymap.set("i", "<C-S-z>", "<Esc><C-r>a", { silent = true, desc = "Redo" })
vim.keymap.set("v", "<C-z>", "<Esc>u", { silent = true, desc = "Undo" })
vim.keymap.set("v", "<C-S-z>", "<Esc><C-r><Esc>gv", { silent = true, desc = "Redo" })
vim.keymap.set("n", "<C-z>", "u", { silent = true, desc = "Undo" })
vim.keymap.set("n", "<C-S-z>", "<C-r>", { silent = true, desc = "Redo" })

-- Undo breakpoints on space and punctuation
vim.keymap.set("i", " ", " <C-g>u")
vim.keymap.set("i", "<CR>", "<CR><C-g>u")
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", "!", "!<C-g>u")
vim.keymap.set("i", "?", "?<C-g>u")
vim.keymap.set("i", ">", "><C-g>u")
vim.keymap.set("i", "<", "<<C-g>u")

-- Selection while staying in insert mode
vim.keymap.set("v", "<S-Up>", "<Up>")
vim.keymap.set("v", "<S-Down>", "<Down>")
vim.keymap.set("i", "<S-Up>", "<esc>v<Up>", opts)
vim.keymap.set("i", "<S-Down>", "<esc>v<Down>", opts)
vim.keymap.set("n", "<S-Up>", "v<Up>", opts)
vim.keymap.set("n", "<S-Down>", "v<Down>", opts)

vim.keymap.set("n", "<C-S-Left>", "vB", { silent = true })
vim.keymap.set("i", "<C-S-Left>", "<Esc>vB", { silent = true })
vim.keymap.set("v", "<C-S-Left>", "B", { silent = true })
vim.keymap.set("n", "<C-S-Right>", "vE", { silent = true })
vim.keymap.set("i", "<C-S-Right>", "<Esc>lvE", { silent = true })
vim.keymap.set("v", "<C-S-Right>", "E", { silent = true })

-- Other arrows movements
vim.keymap.set("n", "<M-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<M-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<M-Up>", "<Cmd>resize +2<CR>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<M-down>", "<Cmd>resize -2<CR>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<C-Left>", "b", { desc = "Go back 1 word" })
vim.keymap.set("n", "<C-Right>", "w", { desc = "Go forward 1 word" })
-- Shift+Arrow selection (IntelliJ-style)
vim.keymap.set("n", "<S-Left>", "v<Left>", { silent = true })
vim.keymap.set("n", "<S-Right>", "v<Right>", { silent = true })
vim.keymap.set("i", "<S-Left>", "<esc>v<Left>", { silent = true })
vim.keymap.set("i", "<S-Right>", "<esc><Right>v<Right>", { silent = true })
vim.keymap.set("v", "<S-Left>", "h", { silent = true })
vim.keymap.set("v", "<S-Right>", "l", { silent = true })

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

-- -- Delete word (IntelliJ-like)
vim.keymap.set("i", "<M-BS>", "<Esc>cb<Del>", { desc = "Delete word" })
vim.keymap.set("i", "<M-Del>", "<Esc>ldei", { desc = "Delete word" })
vim.keymap.set("n", "<M-BS>", "cb<Del>", { desc = "Delete word" })
vim.keymap.set("n", "<M-Del>", "de", { desc = "Delete word" })

-- Copy/paste inside INSERT mode
-- vim.keymap.set("v", "y", '"+y<Esc>i', { noremap = true, silent = true, desc = "Yank" })
vim.keymap.set("i", "<C-S-v>", '<Esc>"0pa', opts) -- Escape substitute (like pressing Esc without leaving insert mo de)
vim.keymap.set({ "i", "v" }, "jk", "<Esc>", { desc = "Esc alternative" })

-- Other text edit navigation
vim.keymap.set("i", "<S-End>", "<esc>v$h", { noremap = true, desc = "Select end" })
vim.keymap.set("n", "<S-End>", "v$h", { noremap = true, desc = "Select end" })
vim.keymap.set("v", "<end>", "$h", { noremap = true, desc = "Select end" })
vim.keymap.set("i", "<Home>", "<Esc>^i", { noremap = true, desc = "Go home" })
vim.keymap.set("i", "<S-Home>", "<esc>v0", { noremap = true, desc = "Select home" })
vim.keymap.set("n", "<S-Home>", "v0", { noremap = true, desc = "Select home" })

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
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open current directory in Oil" })

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

--This is check how
