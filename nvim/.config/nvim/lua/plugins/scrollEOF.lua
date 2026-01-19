-- this plugin is causing bugs when scrolling down in neo-tree and other pickers.
if true then return {} end
return {
  "Aasim-A/scrollEOF.nvim",
  event = "CursorMoved",
  config = true,
}
