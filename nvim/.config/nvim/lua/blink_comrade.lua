local Provider = {}

Provider.new = function(opts)
  return setmetatable({
    get_completions = function(self, ctx, callback)
      local buf = ctx.bufnr
      if not vim.b[buf] or not vim.b[buf].comrade_info or not vim.b[buf].comrade_info.channel then
        callback({})
        return
      end
      local changedtick = vim.api.nvim_buf_get_changedtick(buf)
      local name = vim.api.nvim_buf_get_name(buf)
      local row = ctx.cursor.row
      local col = ctx.cursor.col
      local param = {
        buf_id = buf,
        buf_name = name,
        buf_changedtick = changedtick,
        row = row,
        col = col,
        new_request = true
      }
      local ok, results = pcall(vim.fn['comrade#RequestCompletion'], buf, param)
      if not ok or type(results) ~= 'table' then
        callback({})
        return
      end
      local items = {}
      if results.candidates and type(results.candidates) == 'table' then
        for _, cand in ipairs(results.candidates) do
          table.insert(items, {
            label = cand.word or cand.abbr or "",
            kind = cand.kind or "",
            -- add more fields if needed
          })
        end
      end
      callback(items)
    end
  }, {__index = Provider})
end

return Provider