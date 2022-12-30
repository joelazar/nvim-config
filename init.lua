if vim.g.vscode then
	return
end

local present, impatient = pcall(require, "impatient")

if present then
	impatient.enable_profile()
end

-- installs packer if needed
if require("config.first_load")() then
	return
end

vim.g.mapleader = " "

require("config.plugins")
require("config.keymaps")
require("config.settings")
require("config.autocmds")
