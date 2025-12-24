-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false

-- Disable autoformat on save
-- It conflicts with auto-save
vim.g.autoformat = false

-- Use standard clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable mousemoveevent
vim.opt.mousemoveevent = true

vim.opt.autoindent = true
-- Keep indentation on blank lines
vim.opt.indentexpr = ""
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true

-- Better backspace on identation.
vim.opt.backspace = { "indent", "eol", "start" }

-- Do not remove trailing spaces when switching modes.
vim.g.lazyvim_mini_trailspace = false
vim.opt.startofline = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8

-- Automatically reload buffer after external update, such as switching git
-- branches.
vim.o.autoread = true

-- Highlight column 80
vim.opt.colorcolumn = "80"

vim.opt.undofile = true
vim.opt.breakindent = true

-- Preview substitutions live, as you type.
vim.opt.inccommand = "split"

vim.opt.termguicolors = true
