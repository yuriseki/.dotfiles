return {
  "basola21/PDFview",
  lazy = false,
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {
    "<leader>jj",
    "<cmd>:lua require('pdfview.renderer').next_page()<CR>",
    desc = "PDFview: Next page",
    },
    {
      "<leader>kk",
      "<cmd>:lua require('pdfview.renderer').previous_page()<CR>",
      desc = "PDFview: Previous page",
    },
    {
      "<leader>fd",
      "<cmd>:lua require('pdfview').open()<CR>",
      desc = "Open PDF [D]ocument"
    }
  }
}
