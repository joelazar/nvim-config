return {
  {
    "kristijanhusak/vim-dadbod-ui",
    init = function()
      local ok, dbs = pcall(require, "config.dbs")
      if ok then
        vim.g.dbs = dbs
      end
    end,
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
      { "<leader>S", "<Plug>(DBUI_ExecuteQuery)", mode = { "n", "v" }, desc = "Execute SQL query" },
      { "<leader>E", "<Plug>(DBUI_EditBindParameters)", desc = "Edit SQL bind parameters" },
      { "<leader>W", "<Plug>(DBUI_SaveQuery)", desc = "Save SQL query" },
    },
  },
}
