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

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("spell-markdown"),
  pattern = { "markdown" },
  callback = function()
    vim.cmd("LspStop copilot")
  end,
})

-- NOTE: Workaround for octo.nvim not detaching LSP properly
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_detach_octo"),
  callback = function(args)
    local bufnr = args.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    -- Check if buffer URI has non-file scheme (e.g., octo://)
    if bufname:match("^%w+://") and not bufname:match("^file://") then
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        -- Kill the client entirely
        vim.lsp.stop_client(client.id)
      end
    end
  end,
})
