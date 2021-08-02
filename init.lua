-- installs packer if needed
if require "first_load"() then return end

vim.g.mapleader = " "

require "plugins"

-- I set some global variables to use as configuration throughout my config.
-- These don't have any special meaning.
-- vim.g.snippets = "luasnip"

-- @todo - do I need this?
-- Force loading of astronauta first.
-- vim.cmd [[runtime plugin/astronauta.vim]]
