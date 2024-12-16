return {
  "MattesGroeger/vim-bookmarks",
  config = function()
    vim.g.bookmark_auto_save_file = vim.fn.expand("$HOME") .. "/.local/share/nvim/bookmarks"
  end,
  event = { "BufRead", "BufNewFile" },
}
