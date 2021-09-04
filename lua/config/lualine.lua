local M = {}

local function lsp_progress()
    local messages = vim.lsp.util.get_progress_messages()
    if #messages == 0 then return end
    local status = {}
    for _, msg in pairs(messages) do
        table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
    end
    local spinners = {
        "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"
    }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners
    return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

M.config = {
    options = {
        theme = 'github',
        section_separators = {"", ""},
        component_separators = {"", ""},
        -- section_separators = { "", "" },
        -- component_separators = { "", "" },
        icons_enabled = true
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch"},
        lualine_c = {{"diagnostics", sources = {"nvim_lsp"}}, "filename"},
        lualine_x = {"filetype", lsp_progress},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
    -- extensions = { "nvim-tree" },
}

M.setup = function()
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then return end
    lualine.setup(M.config)
end

return M
