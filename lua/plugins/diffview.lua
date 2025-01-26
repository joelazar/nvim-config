-- Diffview configuration
-- A single tabpage interface for easily cycling through diffs
return {
  "sindrets/diffview.nvim",
  -- Load only when these commands are used
  cmd = {
    "DiffviewOpen",      -- Open diff view
    "DiffviewClose",     -- Close diff view
    "DiffviewToggleFiles", -- Toggle file panel
    "DiffviewFocusFiles", -- Focus file panel
    "DiffviewFileHistory", -- Show file history
    "DiffviewRefresh",   -- Refresh diff view
  },
  opts = {
    -- Enable enhanced diff highlighting
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        -- Use 4-way diff layout for merge conflicts
        layout = "diff4_mixed",
        -- Disable LSP diagnostics in diff view
        disable_diagnostics = true,
      },
    },
  },
}
