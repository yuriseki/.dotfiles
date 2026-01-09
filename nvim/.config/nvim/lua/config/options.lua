-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Case insensitive unless there is a Capital case letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.relativenumber = false

-- Disable autoformat on save
-- It conflicts with autosave
vim.g.autoformat = false

-- Use standard clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable mouse movement
vim.opt.mousemoveevent = true

vim.opt.autoindent = true
-- Keep indentation on blank lines
vim.opt.indentexpr = ""
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true

-- Better backspace on indentation.
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

-- Preview substitutions live, as you type. It's the s/ command.
vim.opt.inccommand = "split"

vim.opt.termguicolors = true

-- Turn on spellcheck by default
vim.opt.spell = true
vim.opt.spelllang = "en_us,pt_br"
vim.opt.spelloptions:append("camel")

vim.g.lazyvim_php_lsp = "phpactor"
