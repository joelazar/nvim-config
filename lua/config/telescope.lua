local M = {}

M.config = {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require("telescope.actions").close,
                ["<S-Up>"] = require'telescope.actions'.preview_scrolling_up,
                ["<S-Down>"] = require'telescope.actions'.preview_scrolling_down
            }
        },
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case'
        },
        prompt_prefix = " ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            prompt_position = "bottom",
            -- preview_cutoff = 120,
            horizontal = {
                mirror = false,
                preview_width = 0.6,
                results_width = 0.8
            },
            width = 0.9,
            height = 0.9,
            preview_cutoff = 120,
            vertical = {mirror = false}
        },
        -- file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        file_ignore_patterns = {"node_modules"},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
        }
    }
}

M.setup = function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then return end
    telescope.setup(M.config)
end

return M
