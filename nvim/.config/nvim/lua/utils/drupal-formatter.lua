local M = {}

-- Path to phpcbf
local phpcbf = "/home/yuri/.config/composer/vendor/bin/phpcbf"

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
      local fixed = vim.fn.readfile(tmp)
      if #fixed > 0 then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, fixed)
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
local function get_visual_selection_range()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  return start_line, end_line
end

local function read_file(path)
  return vim.fn.readfile(path)
end

local function write_file(path, lines)
  vim.fn.writefile(lines, path)
end

-- Apply unified diff hunks to a buffer (range-limited)
local function apply_diff_hunks(bufnr, hunks)
  vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })

  for _, hunk in ipairs(hunks) do
    local start = hunk.start
    local orig_count = hunk.orig_count
    local new_lines = hunk.lines

    -- Convert to 0-index for nvim_buf_set_lines
    vim.api.nvim_buf_set_lines(bufnr, start - 1, start - 1 + orig_count, false, new_lines)
  end
end

-- parse unified diff into hunks
local function parse_unified_diff(diff_lines)
  local hunks = {}
  local current = nil

  for _, line in ipairs(diff_lines) do
    if line:match("^@@") then
      -- Example: @@ -12,3 +12,4 @@
      local o_start, o_cnt, n_start, n_cnt = line:match("@@%s+%-(%d+),?(%d*)%s+%+(%d+),?(%d*)%s+@@")

      current = {
        start = tonumber(n_start),
        orig_count = tonumber(o_cnt ~= "" and o_cnt or 1),
        new_count = tonumber(n_cnt ~= "" and n_cnt or 1),
        lines = {},
      }
      table.insert(hunks, current)
    elseif current and (line:match("^+") or line:match("^%-") or line:match("^ ")) then
      if line:sub(1, 1) ~= "-" then
        table.insert(current.lines, line:sub(2))
      end
    end
  end

  return hunks
end

function M.drupal_format_selection()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)

  if file == "" then
    print("No file to format")
    return
  end

  local sel_start, sel_end = get_visual_selection_range()

  local orig_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- temp files
  local tmp_orig = vim.fn.tempname() .. ".php"
  local tmp_fixed = vim.fn.tempname() .. ".php"

  write_file(tmp_orig, orig_lines)
  write_file(tmp_fixed, orig_lines)

  -- run phpcbf on tmp_fixed
  local cmd = { phpcbf, "--standard=Drupal", tmp_fixed }

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_exit = function()
      local fixed_lines = read_file(tmp_fixed)

      -- Compute diff (vim.diff expects strings, not string arrays)
      local orig_text = table.concat(orig_lines, "\n")
      local fixed_text = table.concat(fixed_lines, "\n")

      local diff = vim.diff(orig_text, fixed_text, {
        result_type = "unified",
        algorithm = "myers",
      })

      -- Ensure diff is a string before splitting
      if type(diff) ~= "string" then
        diff = tostring(diff or "")
      end

      local diff_lines = vim.split(diff, "\n", { plain = true })

      -- Parse diff hunks
      local hunks = parse_unified_diff(diff_lines)

      -- Filter hunks only affecting selection
      local filtered = {}
      for _, hunk in ipairs(hunks) do
        local hunk_end = hunk.start + hunk.orig_count
        if not (hunk_end < sel_start or hunk.start > sel_end) then
          table.insert(filtered, hunk)
        end
      end

      if #filtered == 0 then
        print("No changes needed in selection ✓")
      else
        apply_diff_hunks(bufnr, filtered)
        print("Drupal partial format applied ✓")
      end

      vim.fn.delete(tmp_orig)
      vim.fn.delete(tmp_fixed)
    end,
  })
end

return M
