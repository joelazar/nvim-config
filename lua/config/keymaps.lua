-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-----------------------------------------------------------
-- Key Mapping Configuration
-----------------------------------------------------------

-- Shorthand for mapping keys
local map = vim.keymap.set

-- Window Management
-- Q: Close current window (replaces default 'Q' which enters Ex mode)
map("n", "Q", "<cmd>close<cr>", { silent = true })

-- System Clipboard Integration
-- gy: Copy to system clipboard (normal and visual modes)
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
-- gp: Paste from system clipboard (normal mode)
map("n", "gp", '"+p', { desc = "Paste from system clipboard" })
-- gp: Paste in Visual mode without copying selected text (see :h v_P)
map("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- Better Navigation for Wrapped Lines
-- These mappings make j/k move by visible lines rather than file lines
-- Only applies when not using a count (e.g. 5j still moves 5 actual lines)
-- Not mapped in operator-pending mode to preserve behavior of operations like 'dj'
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Reselect latest changed, put, or yanked text
map(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Visually select changed text" }
)

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
map({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

-- Better page up/down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- smart deletion, dd
-- It solves the issue, where you want to delete empty line, but dd will override you last yank.
-- Code above will check if u are deleting empty line, if so - use black hole register.
-- [src: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3]
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end

vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

-- Configure toggle terminal for CMD+J
map("n", "<D-j>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("t", "<D-j>", "<cmd>close<cr>", { desc = "Hide Terminal" })

map("n", "<leader>cD", "<cmd>%s/\\s\\+$//e<cr>", { desc = "Delete trailing spaces" })

-- Toggle harper_ls (spelling checker)
local harper_ls_active = false
map("n", "<leader>cs", function()
  local clients = vim.lsp.get_clients({ name = "harper_ls" })
  if #clients > 0 then
    -- Stop harper_ls
    for _, client in ipairs(clients) do
      client.stop()
    end
    harper_ls_active = false
    vim.notify("Harper LSP stopped", vim.log.levels.INFO)
  else
    -- Start harper_ls
    vim.cmd("LspStart harper_ls")
    harper_ls_active = true
    vim.notify("Harper LSP started", vim.log.levels.INFO)
  end
end, { desc = "Toggle spelling" })

local function undotree()
  vim.cmd(":packadd nvim.undotree")
  local close = require("undotree").open({
    title = "undotree",
    command = "topright 30vnew",
  })
  if not close then
    vim.bo.filetype = "undotree"
  end
end

vim.api.nvim_create_user_command("Undotree", undotree, {})
