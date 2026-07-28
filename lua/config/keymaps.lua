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

-- Toggle file explorer with CMD+B
map("n", "<D-b>", function()
  Snacks.explorer()
end, { desc = "Toggle Explorer" })

-- Configure toggle terminal for CMD+J
map({ "n", "t" }, "<D-j>", function()
  -- Use git root (stable) instead of LazyVim.root(), which changes once an LSP
  -- attaches and would open a second terminal instance instead of toggling.
  Snacks.terminal(nil, { cwd = LazyVim.root.git() })
end, { desc = "Terminal (Git Root)" })

map("n", "<leader>cD", "<cmd>%s/\\s\\+$//e<cr>", { desc = "Delete trailing spaces" })

-- Toggle harper_ls (spelling checker)
local harper_ls_active = false
map("n", "<leader>us", function()
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

vim.cmd(":packadd nvim.undotree")
map("n", "<leader>bu", "<cmd>Undotree<cr>", { desc = "Undotree" })

-- Cmd+S to save (works in Neovide and terminals that forward Cmd, e.g. Kitty/WezTerm/Ghostty)
map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i", "x", "n", "s" }, "<D-S>", "<cmd>noautocmd w<cr><esc>", { desc = "Save File (no format)" })

-- Code review with tuicr (replaces agent-review.nvim)
local function tuicr(args)
  local root = LazyVim.root.git()
  Snacks.terminal("tuicr " .. args, { cwd = root, interactive = true })
end

map("n", "<leader>rr", function()
  tuicr("-w")
end, { desc = "Review working tree" })

map("n", "<leader>rb", function()
  local base = vim.fn.systemlist("git symbolic-ref --short refs/remotes/origin/HEAD")[1] or ""
  base = base:gsub("^origin/", "")
  if base == "" then
    base = "main"
  end
  tuicr("-r " .. base .. "..HEAD")
end, { desc = "Review branch vs base" })

map("n", "<leader>rf", function()
  tuicr("--file " .. vim.fn.expand("%:p"))
end, { desc = "Review current file" })

map("n", "<leader>rp", function()
  local pr = vim.fn.systemlist("gh pr view --json number --jq .number")[1]
  if vim.v.shell_error ~= 0 or not pr or pr == "" then
    vim.notify("No PR for the current branch", vim.log.levels.WARN)
    return
  end
  tuicr("pr " .. pr)
end, { desc = "Review PR for current branch" })

-- Neovide: macOS Cmd keys
if vim.g.neovide then
  local all = { "n", "v", "i", "c", "s", "t" }

  -- Clipboard (explicit "+" register, since vim.o.clipboard is empty on purpose)
  map({ "n", "v" }, "<D-c>", '"+y', { desc = "Copy to clipboard" })
  map({ "n", "v" }, "<D-x>", '"+d', { desc = "Cut to clipboard" })
  map({ "n", "v" }, "<D-v>", '"+p', { desc = "Paste from clipboard" })
  map({ "i", "c" }, "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })
  map("t", "<D-v>", '<C-\\><C-n>"+pi', { desc = "Paste from clipboard" })
  map("n", "<D-a>", "ggVG", { desc = "Select all" })

  -- Font size (Neovide scales guifont via neovide_scale_factor)
  local function scale(delta)
    return function()
      local factor = vim.g.neovide_scale_factor or 1
      vim.g.neovide_scale_factor = math.min(math.max(factor + delta, 0.5), 4)
    end
  end
  map(all, "<D-=>", scale(0.1), { desc = "Increase font size" })
  map(all, "<D-+>", scale(0.1), { desc = "Increase font size" })
  map(all, "<D-->", scale(-0.1), { desc = "Decrease font size" })
  map(all, "<D-0>", function()
    vim.g.neovide_scale_factor = 1
  end, { desc = "Reset font size" })

  -- Window
  map(all, "<D-CR>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle fullscreen" })
  map({ "n", "v", "i" }, "<D-w>", "<cmd>confirm close<cr>", { desc = "Close window" })
  map({ "n", "v", "i" }, "<D-q>", "<cmd>confirm qa<cr>", { desc = "Quit Neovide" })
  map({ "n", "v", "i" }, "<D-n>", "<cmd>enew<cr>", { desc = "New buffer" })

  -- Ghostty remaps: Cmd+<key> behaves like the terminal equivalent
  map({ "n", "v", "i" }, "<D-p>", "<C-p>", { remap = true, desc = "Cmd+P -> Ctrl+P" })
  map({ "n", "v", "i" }, "<D-S-g>", "<C-S-g>", { remap = true })
  map({ "n", "v", "i" }, "<D-S-e>", "<C-S-e>", { remap = true })
  map({ "n", "v", "i" }, "<D-S-m>", "<C-S-m>", { remap = true })

  -- Cmd+Left/Right -> start/end of line (like \x01 / \x05 in the shell)
  map({ "n", "v" }, "<D-Left>", "^", { desc = "Start of line" })
  map({ "n", "v" }, "<D-Right>", "$", { desc = "End of line" })
  map("i", "<D-Left>", "<C-o>^", { desc = "Start of line" })
  map("i", "<D-Right>", "<End>", { desc = "End of line" })
end
