-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

_G.check_php_arrow = function()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".") - 1
  local before = line:sub(1, col)
  if before:match("%$[a-zA-Z_][a-zA-Z0-9_]*$") then
    return "->"
  else
    return "-"
  end
end

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
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.module", "*.theme", "*.install", "*.inc" },
  callback = function()
    vim.opt.filetype = "php"
  end,
})

-- Associate .env.local files with dotenv syntax highlighting
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { ".env", "*.env", ".env.*", ".env.local" },
  callback = function()
    vim.opt.filetype = "sh"
  end,
})

-- Open pdf
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.pdf",
  callback = function()
    local file_path = vim.api.nvim_buf_get_name(0)
    require("pdfview").open(file_path)
  end,
})

-- Disable inlay hints to avoid column out of range errors
vim.lsp.inlay_hint.enable(false)

-- Auto return to normal mode after X seconds of inactivity in insert mode
local time_to_return_to_normal_mode = 50000
local insert_timer = nil
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if insert_timer then
      insert_timer:stop()
    end
    insert_timer = vim.loop.new_timer()
    insert_timer:start(
      time_to_return_to_normal_mode,
      0,
      vim.schedule_wrap(function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
      end)
    )
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if insert_timer then
      insert_timer:stop()
      insert_timer = nil
    end
  end,
})
vim.api.nvim_create_autocmd("TextChangedI", {
  callback = function()
    if insert_timer then
      insert_timer:stop()
      insert_timer:start(
        time_to_return_to_normal_mode,
        0,
        vim.schedule_wrap(function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        end)
      )
    end
  end,
})

-- Insert spaces based on previous line's indent when leaving insert on an empty line
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   callback = function()
--     local line = vim.fn.line(".")
--     local content = vim.fn.getline(line)
--     if content:match("^%s*$") then
--       local prev_indent = vim.fn.indent(line - 1)
--       if prev_indent > 0 then
--         vim.fn.setline(line, string.rep(" ", prev_indent))
--         vim.fn.cursor(line, prev_indent + 1)
--       end
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.php", "*.inc", "*.module", "*.install" }, -- Add your desired patterns here
  callback = function()
    vim.cmd("LspStart phpactor") -- Or intelephense if switching
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.php", "*.inc", "*.module", "*.install" },
  callback = function()
    vim.api.nvim_set_keymap("i", "-", "v:lua.check_php_arrow()", { expr = true })
  end,
})
