return {
  "MattesGroeger/vim-bookmarks",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tom-anders/telescope-vim-bookmarks.nvim",
  },
  config = function()
    vim.g.bookmark_auto_save_file = vim.fn.expand("$HOME") .. "/.local/share/nvim/bookmarks"
    require("telescope").load_extension("vim_bookmarks")
  end,
  event = { "BufRead", "BufNewFile" },
}
