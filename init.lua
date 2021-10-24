if vim.g.vscode then
    return
end

-- installs packer if needed
if require "first_load"() then return end

require "impatient"

vim.g.mapleader = " "

require "plugins"
require "keymaps"
require "settings"
