local M = {}

M.config = {
    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = '│',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
        },
        change = {
            hl = 'GitSignsChange',
            text = '│',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
        delete = {
            hl = 'GitSignsDelete',
            text = '_',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = '‾',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        }
    },
    numhl = false,
    linehl = false,
    keymaps = {},
    watch_index = {interval = 1000, follow_files = true},
    current_line_blame = false,
    current_line_blame_opts = {delay = 1000},
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil, -- Use default
    word_diff = false,
    use_internal_diff = true -- If luajit is present
}

M.setup = function()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then return end
    gitsigns.setup(M.config)
end

return M
