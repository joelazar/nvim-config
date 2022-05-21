if vim.g.vscode then
	return
end

local present, impatient = pcall(require, "impatient")

if present then
	impatient.enable_profile()
end

-- installs packer if needed
if require("first_load")() then
	return
end

vim.g.mapleader = " "

require("plugins")
require("keymaps")
require("settings")
require("autocmds")
