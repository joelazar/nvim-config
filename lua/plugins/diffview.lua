return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
    "DiffviewRefresh",
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff4_mixed",
        disable_diagnostics = true,
      },
    },
  },
}
