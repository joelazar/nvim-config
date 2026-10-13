return {
  "mikavilpas/yazi.nvim",
  keys = {
    {
      "<leader>y",
      "<cmd>Yazi toggle<cr>",
      desc = "Yazi",
    },
    {
      "<leader>Y",
      "<cmd>Yazi cwd<cr>",
      desc = "Yazi - root dir",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
    integrations = {
      resolve_relative_path_application = "realpath",
      resolve_relative_path_implementation = function(args)
        local base = vim.fn.isdirectory(args.source_dir) == 1 and args.source_dir or vim.fs.dirname(args.source_dir)
        -- shortcut: no ../ paths, files outside base fall back to absolute; install coreutils if that matters
        return vim.fs.relpath(base, args.selected_file) or args.selected_file
      end,
    },
  },
}
