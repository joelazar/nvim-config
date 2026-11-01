-- Neovide 0.17+ renders ext_messages/ext_cmdline itself; noice refuses to run there.
return { "folke/noice.nvim", enabled = not vim.g.neovide }
