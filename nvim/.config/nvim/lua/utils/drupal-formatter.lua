local M = {}

-- Path to phpcbf
local phpcbf = "/home/yuri/.composer/vendor/bin/phpcbf"

-- Detect root for better standard resolution
local function get_root()
  local markers = {
    "composer.json",
    "phpcs.xml",
    "phpcs.xml.dist",
    ".phpcs.xml",
    ".phpcs.xml.dist",
  }
  for _, fname in ipairs(markers) do
    local f = vim.fn.findfile(fname, ".;")
    if f ~= "" then
      return vim.fn.fnamemodify(f, ":h")
    end
  end
  return vim.loop.cwd()
end

-----------------------------------------------------------------------
-- FULL FILE FORMATTER
-----------------------------------------------------------------------
-- vim.api.nvim_create_user_command("DrupalFormat", function()
function M.drupal_file_format()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    print("No file to format")
    return
  end

  local tmp = vim.fn.tempname() .. ".php"
  vim.fn.writefile(vim.fn.readfile(file), tmp)

  local cmd = {
    phpcbf,
    "--standard=Drupal",
    tmp,
  }

  local stdout = {}
  local stderr = {}

  vim.fn.jobstart(cmd, {
    cwd = get_root(),
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data)
      if data then
        vim.list_extend(stdout, data)
      end
    end,

    on_stderr = function(_, data)
      if data then
        vim.list_extend(stderr, data)
      end
    end,

    on_exit = function()
      -- Read the entire file content as a single string to preserve trailing newlines
      local f = io.open(tmp, "r")
      if not f then
        print("Error: could not open temporary file after formatting.")
        vim.fn.delete(tmp)
        return
      end
      local content = f:read("*a")
      f:close()

      -- phpcbf may not modify the file if no changes are needed.
      -- We check for content to avoid clearing the buffer unnecessarily.
      if content and #content > 0 then
        -- Split the string content into lines.
        -- vim.split correctly handles a trailing newline by producing an empty string at the end of the table.
        local fixed_lines = vim.split(content, "\n")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, fixed_lines)
        print("Drupal format applied ✓")
      else
        print("No output from formatter")
      end
      vim.fn.delete(tmp)
    end,
  })
end

-----------------------------------------------------------------------
-- RANGE FORMATTER
-----------------------------------------------------------------------
function M.drupal_format_selection()
  -- Helper function to get the line numbers of the visual selection.
  local function get_visual_selection_range()
    return vim.fn.line("'<"), vim.fn.line("'>")
  end

  -- Helper function to parse the text output of a unified diff into structured "hunks".
  local function parse_unified_diff(diff_lines)
    local hunks = {}
    local current_hunk = nil
    for _, line in ipairs(diff_lines) do
      if line:match("^@@") then
        -- Lines look like: @@ -old_start,old_count +new_start,new_count @@
        -- The count is optional and defaults to 1 if not present.
        local old_start, old_count, new_start, new_count =
          line:match("^@@%s+%-([0-9]+),?([0-9]*)%s+%+([0-9]+),?([0-9]*)%s+@@")

        if old_start then
          current_hunk = {
            -- The start line in the *original* content that this hunk modifies.
            orig_start = tonumber(old_start),
            -- If old_count is an empty string (for a 1-line hunk), default to 1.
            orig_count = tonumber(old_count ~= "" and old_count or "1"),
            -- The start line in the *new* content.
            new_start = tonumber(new_start),
            -- The new lines to be inserted.
            lines = {},
          }
          table.insert(hunks, current_hunk)
        end
      elseif current_hunk then
        -- Collect lines that are not deletions (i.e., context or additions).
        if line:match("^[+ ]") then
          table.insert(current_hunk.lines, line:sub(2))
        end
      end
    end
    return hunks
  end

  -- Helper function to apply the parsed hunks of changes to the buffer.
  local function apply_diff_hunks(bufnr, hunks)
    vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
    -- Apply hunks in reverse order to avoid line number shifts.
    for i = #hunks, 1, -1 do
      local hunk = hunks[i]
      vim.api.nvim_buf_set_lines(bufnr, hunk.orig_start - 1, hunk.orig_start - 1 + hunk.orig_count, false, hunk.lines)
    end
  end

  -- Main function logic
  local bufnr = vim.api.nvim_get_current_buf()
  local original_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local sel_start, sel_end = get_visual_selection_range()

  -- Create a temporary file to format.
  local tmp_file = vim.fn.tempname() .. ".php"
  vim.fn.writefile(original_lines, tmp_file)

  local cmd = { phpcbf, "--standard=Drupal", tmp_file }

  -- Run the formatter.
  vim.fn.jobstart(cmd, {
    cwd = get_root(),
    on_exit = function()
      -- Read the fully formatted file.
      local f = io.open(tmp_file, "r")
      if not f then
        print("Error: could not read formatted temp file.")
        vim.fn.delete(tmp_file)
        return
      end
      local formatted_content = f:read("*a")
      f:close()

      if not formatted_content or #formatted_content == 0 then
        print("Formatter produced no output.")
        vim.fn.delete(tmp_file)
        return
      end

      -- Calculate the diff between the original buffer and the formatted file.
      local original_content = table.concat(original_lines, "\n")
      local diff_output = vim.diff(original_content, formatted_content, { result_type = "unified" })

      if not diff_output then
        print("No changes needed in selection ✓")
        vim.fn.delete(tmp_file)
        return
      end

      local diff_lines = vim.split(diff_output, "\n", { plain = true })
      local hunks = parse_unified_diff(diff_lines)

      -- Filter the hunks to keep only those that overlap with the user's selection.
      local filtered_hunks = {}
      for _, hunk in ipairs(hunks) do
        local hunk_end = hunk.orig_start + hunk.orig_count - 1
        if not (hunk_end < sel_start or hunk.orig_start > sel_end) then
          table.insert(filtered_hunks, hunk)
        end
      end

      if #filtered_hunks > 0 then
        apply_diff_hunks(bufnr, filtered_hunks)
        print("Drupal partial format applied ✓")
      else
        print("No changes needed in selection ✓")
      end

      vim.fn.delete(tmp_file)
    end,
  })
end

return M
