-- Make the auto-suggestion box wait a bit more before showing up.
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    opts.performance = opts.performance or {}

    opts.performance.debounce = 350   -- default is 60
    opts.performance.throttle = 350  -- default is 30
    opts.performance.fetching_timeout = 350

    -- Optional: only trigger completion on longer words (reduces noise)
    opts.completion = opts.completion or {}
    opts.completion.keyword_length = 3

    return opts
  end,
}

