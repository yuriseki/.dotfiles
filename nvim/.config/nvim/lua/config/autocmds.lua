-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client and client.name ~= "null-ls" then
--       client.server_capabilities.documentFormattingProvider = false
--     end
--   end,
-- })
--


-- Associate drupal filetypes as PHP.
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.module", "*.theme", "*.install", "*.inc"},
    callback = function()
        vim.opt.filetype = "php"
    end,
})

