-- Codediff configuration
-- VSCode-style diff rendering with two-tier highlighting
return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  opts = {
    diff = {
      layout = "side-by-side",
      disable_inlay_hints = true,
      ignore_trim_whitespace = false,
      hide_merge_artifacts = false,
      cycle_next_hunk = true,
      cycle_next_file = true,
      jump_to_first_change = true,
    },
  },
}
