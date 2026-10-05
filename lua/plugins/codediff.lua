return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  opts = {
    diff = {
      compute_moves = true,
      cycle_hunks_across_files = true,
      gutter_signs = true,
      highlight_added_deleted_files = true,
    },
    explorer = {
      view_mode = "tree",
      auto_open_on_cursor = true,
      line_stats = { enabled = true },
    },
    keymaps = {
      view = {
        toggle_explorer = "<leader>E",
      },
    },
  },
}
