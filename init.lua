if require("config.first_load")() then
	return
end

vim.g.mapleader = " "

require("config.plugins")

require("config.options")
require("config.mappings")
require("config.autocmds")
