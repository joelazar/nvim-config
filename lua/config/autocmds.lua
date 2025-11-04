-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_custom_" .. name, { clear = true })
end

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = augroup("disable-copilot-obsidian"),
  pattern = { vim.fn.expand("~") .. "/Obsidian/**.md" },
  callback = function(ev)
    vim.b.copilot_enabled = false
    vim.b.copilot_suggestion_auto_trigger = false
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("stop-copilot-obsidian"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "copilot" then
      local bufname = vim.api.nvim_buf_get_name(args.buf)
      if bufname:match(vim.fn.expand("~") .. "/Obsidian/.*%.md$") then
        vim.lsp.stop_client(client.id)
      end
    end
  end,
})
