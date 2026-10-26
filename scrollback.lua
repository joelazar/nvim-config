-- Minimal scrollback pager, used by Rex's edit_scrollback (cmd+shift+f).
-- Usage: nvim --clean -u ~/.config/nvim/scrollback.lua <file captured with `rex capture --format=vt`>
-- Renders the ANSI colors via a terminal buffer; no plugins, starts in ~10ms.

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/catppuccin")
pcall(function()
  require("catppuccin").setup({ flavour = "mocha", term_colors = true, auto_integrations = false })
  vim.cmd.colorscheme("catppuccin-mocha")
end)

local o = vim.o
o.number = false
o.relativenumber = false
o.signcolumn = "no"
o.laststatus = 0
o.showmode = false
o.ruler = false
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.scrolloff = 4
o.shada = ""
o.swapfile = false
o.clipboard = ""
o.mousescroll = "ver:3,hor:0"
o.scrollback = 100000
-- visible cursor: solid block (same as main config) plus a highlighted line
o.guicursor = "n-v-c-sm:block-blinkon0,i-ci-ve:ver25-blinkon0,r-cr-o:hor20-blinkon0,t:block-blinkon0-TermCursor"
o.cursorline = true

vim.g.mapleader = " "
local map = vim.keymap.set
map({ "n", "x" }, "y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map("n", "Y", '"+y$')
map("n", "q", "<cmd>qa!<cr>")
map("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd.nohlsearch()
  else
    vim.cmd("qa!")
  end
end)
-- e: save the rendered text (no escapes) over the capture and exit 3; the Rex script reopens it in full nvim
map("n", "e", function()
  vim.fn.writefile(vim.api.nvim_buf_get_lines(0, 0, -1, false), vim.fn.argv(0))
  vim.cmd("cquit 3")
end, { desc = "Open in full nvim" })
-- jump between shell prompts (starship's ❯)
map({ "n", "x" }, "[[", "<cmd>silent! ?^\\s*❯<cr><cmd>nohlsearch<cr>", { desc = "Previous prompt" })
map({ "n", "x" }, "]]", "<cmd>silent! /^\\s*❯<cr><cmd>nohlsearch<cr>", { desc = "Next prompt" })

-- URLs: ]u / [u jump, <leader>u picks one from the whole capture
local url_pat = [[\v<https?://[^ \t<>"'`()\[\]{}]+]]
map("n", "]u", function()
  vim.fn.search(url_pat, "W")
end, { desc = "Next URL" })
map("n", "[u", function()
  vim.fn.search(url_pat, "bW")
end, { desc = "Previous URL" })

local plain = "" -- capture without escapes, set on VimEnter
map("n", "<leader>u", function()
  local urls, seen = {}, {}
  for url in plain:gmatch("https?://[^%s<>\"'`()%[%]{}]+") do
    url = url:gsub("[.,;:!?]+$", "")
    if not seen[url] then
      seen[url] = true
      table.insert(urls, 1, url) -- newest first
    end
  end
  if #urls == 0 then
    return vim.notify("No URLs in scrollback")
  end
  vim.ui.select(urls, { prompt = "Open URL" }, function(url)
    if url then
      vim.ui.open(url)
    end
  end)
end, { desc = "Pick URL to open" })

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local path = vim.fn.argv(0)
    local f = path ~= "" and io.open(path, "rb")
    if not f then
      return
    end
    local data = f:read("*a")
    f:close()
    -- strip CSI and OSC sequences, but keep OSC 8 hyperlink targets (clickable text whose URL isn't shown)
    local targets = {}
    for url in data:gmatch("\27%]8;[^;]*;([^\27\7]+)") do
      table.insert(targets, url)
    end
    plain = table.concat(targets, "\n")
      .. "\n"
      .. data:gsub("\27%[[%d;:?<=>]*[ -/]*[@-~]", ""):gsub("\27%].-\7", ""):gsub("\27%].-\27\\", "")

    local file_buf = vim.api.nvim_get_current_buf()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_buf_delete(file_buf, { force = true })
    local chan = vim.api.nvim_open_term(buf, {})
    vim.api.nvim_chan_send(chan, (data:gsub("\r?\n", "\r\n")))
    -- terminal output is processed async; jump to the end once it lands
    vim.defer_fn(function()
      vim.bo[buf].modifiable = false
      vim.cmd("normal! G")
      -- drop trailing empty lines so G lands on real output
      vim.fn.search("\\S", "bW")
    end, 50)
  end,
})
