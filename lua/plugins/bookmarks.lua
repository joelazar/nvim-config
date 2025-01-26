-- Vim Bookmarks configuration
-- Allows for bookmarking lines in files and easily jumping between them
return {
  "MattesGroeger/vim-bookmarks",
  config = function()
    -- Set persistent storage location for bookmarks
    -- Stores in ~/.local/share/nvim/bookmarks
    vim.g.bookmark_auto_save_file = vim.fn.expand("$HOME") .. "/.local/share/nvim/bookmarks"
  end,
  -- Load when reading or creating new files
  event = { "BufRead", "BufNewFile" },
}
