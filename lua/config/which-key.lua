local M = {}
M.config = {
    active = false,
    setup = {
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = true, -- adds help for operators like d, y, ...
                motions = true, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true -- bindings for prefixed with g
            },
            spelling = {enabled = true, suggestions = 20} -- use which-key for spelling hints
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+" -- symbol prepended to a group
        },
        window = {
            border = "none", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
            padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
        },
        layout = {
            height = {min = 4, max = 25}, -- min and max height of the columns
            width = {min = 20, max = 50}, -- min and max width of the columns
            spacing = 3 -- spacing between columns
        },
        hidden = {
            "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "
        }, -- hide mapping boilerplate
        show_help = true -- show help message on the command line when the popup is visible
    },

    opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true -- use `nowait` when creating keymaps
    },
    vopts = {
        mode = "v", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true -- use `nowait` when creating keymaps
    },
    -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
    -- see https://neovim.io/doc/user/map.html#:map-cmd
    vmappings = {[";"] = {":CommentToggle<CR>", "Comment Operator"}},
    mappings = {
        ["w"] = {"<cmd>w!<CR>", "Save"},
        ["q"] = {"<cmd>q!<CR>", "Quit"},
        [";"] = {"<cmd>CommentToggle<CR>", "Comment Operator"},
        ["b"] = {
            name = "Buffers",
            ["j"] = {"<cmd>BufferPick<cr>", "Jump to buffer"},
            ["d"] = {"<cmd>BufferClose!<CR>", "Delete buffer"},
            ["<c-d>"] = {
                "<cmd>only<cr><cmd>BufferCloseAllButCurrent<cr>",
                "Close all but current buffer"
            },
            ["f"] = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format buffer"},
            ["l"] = {"<cmd>BufferMovePrevious<cr>", "Move buffer to the left"},
            ["r"] = {"<cmd>BufferMoveNext<cr>", "Move buffer to the right"},
            ["L"] = {
                "<cmd>BufferCloseBuffersLeft<cr>",
                "Close all buffers to the left"
            },
            ["R"] = {
                "<cmd>BufferCloseBuffersRight<cr>",
                "Close all buffers to the right"
            },
            ["p"] = {"<cmd>BufferPrevious<cr>", "Previous buffer"},
            ["n"] = {"<cmd>BufferNext<cr>", "Next buffer"},

            ["s"] = {
                name = "Sort buffers",
                ["d"] = {
                    "<cmd>BufferOrderByDirectory<cr>",
                    "Sort buffers automatically by directory"
                },
                ["l"] = {
                    "<cmd>BufferOrderByLanguage<cr>",
                    "Sort buffers automatically by language"
                }
            }

        },
        ["p"] = {
            name = "Packer",
            ["c"] = {"<cmd>PackerCompile<cr>", "Compile"},
            ["i"] = {"<cmd>PackerInstall<cr>", "Install"},
            ["r"] = {
                "<cmd>lua require('utils').reload_lv_config()<cr>", "Reload"
            },
            ["s"] = {"<cmd>PackerSync<cr>", "Sync"},
            ["u"] = {"<cmd>PackerUpdate<cr>", "Update"}
        },
        ["g"] = {
            name = "Git",
            ["j"] = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk"},
            ["k"] = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk"},
            ["l"] = {
                "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line"
            },
            ["p"] = {
                "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk"
            },
            ["r"] = {
                "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk"
            },
            ["R"] = {
                "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer"
            },
            ["s"] = {
                "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk"
            },
            ["u"] = {
                "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                "Undo Stage Hunk"
            },
            ["o"] = {"<cmd>Telescope git_status<cr>", "Open changed files"},
            ["b"] = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
            ["c"] = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
            ["C"] = {
                "<cmd>Telescope git_bcommits<cr>",
                "Checkout commit(for current file)"
            }
        },
        ["e"] = {
            name = "Errors",
            n = {
                "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
                "Next Diagnostic"
            },
            p = {
                "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
                "Prev Diagnostic"
            }
        },
        ["l"] = {
            name = "LSP",
            ["a"] = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
            ["d"] = {
                "<cmd>Telescope lsp_document_diagnostics<cr>",
                "Document Diagnostics"
            },
            ["w"] = {
                "<cmd>Telescope lsp_workspace_diagnostics<cr>",
                "Workspace Diagnostics"
            },
            ["i"] = {"<cmd>LspInfo<cr>", "Info"},
            ["j"] = {
                "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
                "Next Diagnostic"
            },
            ["k"] = {
                "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
                "Prev Diagnostic"
            },
            ["l"] = {"<cmd>silent lua require('lint').try_lint()<cr>", "Lint"},
            ["q"] = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
            ["r"] = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
            ["s"] = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
            ["S"] = {
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                "Workspace Symbols"
            }
        },
        ["s"] = {
            name = "Search",
            ["b"] = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
            ["B"] = {"<cmd>Telescope buffers<cr>", "Find buffer"},
            ["c"] = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
            ["f"] = {"<cmd>Telescope find_files<cr>", "Find File"},
            ["h"] = {"<cmd>Telescope help_tags<cr>", "Find Help"},
            ["L"] = {"<cmd>Telescope treesitter<cr>", "Treesitter"},
            ["m"] = {"<cmd>Telescope marks<cr>", "Marks"},
            ["M"] = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
            ["r"] = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
            ["R"] = {"<cmd>Telescope registers<cr>", "Registers"},
            ["t"] = {"<cmd>Telescope live_grep<cr>", "Text"},
            ["T"] = {"<cmd>Telescope grep_string<cr>", "Text under cursor"},
            ["k"] = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
            ["C"] = {"<cmd>Telescope commands<cr>", "Commands"},
            ["Q"] = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
            ["p"] = {
                "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
                "Colorscheme with Preview"
            }
        },
        ["T"] = {name = "Treesitter", i = {":TSConfigInfo<cr>", "Info"}}
    }
}

M.setup = function()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then return end

    which_key.setup(M.config.setup)
    local wk = require "which-key"

    wk.register(M.config.mappings, M.config.opts)
    wk.register(M.config.vmappings, M.config.vopts)
end

return M
