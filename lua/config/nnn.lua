local M = {}

M.config = {
    command = "nnn -oCd",
    set_default_mappings = 0,
    replace_netrw = 1,
    action = {
        ["<c-t>"] = "tab split",
        ["<c-s>"] = "split",
        ["<c-v>"] = "vsplit",
        ["<c-o>"] = copy_to_clipboard
    }
}

M.setup = function()
    local status_ok, nnn = pcall(require, "nnn")
    if not status_ok then return end
    nnn.setup(M.config)
end

return M
