-- Display the filename in the buffer. Very usefull when we have more than one
-- file opened.
return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup()
  end,
}
