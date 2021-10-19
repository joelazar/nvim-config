return require("packer").startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        event = "VimEnter",
        after = {'coq_nvim'},
        config = function() require("config.lspconfig") end
    }

    -- Misc
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"

    -- Display popup with possible keybindings
    use {
        "folke/which-key.nvim",
        event = "BufWinEnter",
        config = function() require("config.which-key").setup() end
    }

    -- Asynctasks
    use {"skywind3000/asyncrun.vim", event = "BufWinEnter"}
    use {"skywind3000/asynctasks.vim", event = "BufWinEnter"}

    -- Comment toggler
    use {
        "terrortylor/nvim-comment",
        event = "BufRead",
        config = function()
            local status_ok, nvim_comment = pcall(require, "nvim_comment")
            if not status_ok then return end
            nvim_comment.setup()
        end
    }

    -- Project management
    use {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        requires = {{'nvim-telescope/telescope.nvim'}},
        config = function()
            require("project_nvim").setup {
                require('telescope').load_extension('projects')
            }
        end
    }

    -- Fuzzy filtering
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function() require("config.telescope").setup() end
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        requires = {{'nvim-telescope/telescope.nvim'}},
        config = function() require('telescope').load_extension('fzf') end,
        run = 'make'
    }

    -- Status bar
    use {
        "shadmansaleh/lualine.nvim",
        event = "VimEnter",
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require("config.lualine").setup() end
    }

    -- Colorschema
    use {
        'projekt0n/github-nvim-theme'
        -- config = function() require('github-theme').setup() end
    }

    use {"EdenEast/nightfox.nvim"}

    -- Automagically resizing splits
    use {
        "beauwilliams/focus.nvim",
        event = "BufWinEnter",
        config = function() require("focus").setup() end
    }

    use {
        "NTBBloodbath/rest.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        ft = {'http'},
        config = function()
            require("rest-nvim").setup({
                -- Open request results in a horizontal split
                result_split_horizontal = false,
                -- Skip SSL verification, useful for unknown certificates
                skip_ssl_verification = false,
                -- Highlight request on run
                highlight = {enabled = true, timeout = 1000},
                -- Jump to request line on run
                jump_to_request = false
            })
        end
    }

    -- Color highlighter
    use {
        'norcalli/nvim-colorizer.lua',
        ft = {'html', 'css'},
        config = function() require('colorizer').setup() end
    }

    -- Completion & Snippets
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        config = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up',
                clients = {lsp = {resolve_timeout = 0.15, weight_adjust = 0.4}}
            }
        end,
        run = ":COQdeps"
    }
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ Snippets

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        after = "coq_nvim",
        config = function() require("config.autopairs").setup() end
    }

    -- Surround text object plugin
    use {
        "blackCauldron7/surround.nvim",
        event = "InsertEnter",
        config = function()
            require("surround").setup({mappings_style = "surround"})
        end
    }

    -- Nicer search highlighter
    -- use {"kevinhwang91/nvim-hlslens", event = "BufReadPost"}

    -- Clipboard management
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            {'nvim-telescope/telescope.nvim'},
            {'tami5/sqlite.lua', module = 'sqlite'}
        },
        config = function()
            require('neoclip').setup({enable_persistant_history = true})
            require('telescope').load_extension('neoclip')
        end
    }

    -- Go development
    use {
        "ray-x/go.nvim",
        ft = {"go", "gomod"},
        config = function() require("config.go").setup() end,
        run = ':lua require("go.install").install_all()'
    }

    use {
        "phaazon/hop.nvim",
        as = "hop",
        config = function() require("hop").setup() end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        branch = "0.5-compat",
        config = function() require("config.treesitter").setup() end,
        run = ":TSUpdate"
    }

    -- Rainbow parentheses by using tree-sitter
    use {"p00f/nvim-ts-rainbow", after = "nvim-treesitter"}

    -- Autocreate/update html tags
    use {
        'windwp/nvim-ts-autotag',
        event = "BufWinEnter",
        after = "nvim-treesitter"
    }

    -- Adds indentation guides to all lines
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function() require("config.indent-blankline").setup() end
    }

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require("config.gitsigns").setup() end,
        event = "BufRead"
    }

    use {
        'pwntester/octo.nvim',
        config = function() require"octo".setup() end,
        event = "BufWinEnter"
    }

    use {"sindrets/diffview.nvim", event = "BufWinEnter"}

    -- File manager
    use {
        "luukvbaal/nnn.nvim",
        event = "BufWinEnter",
        config = function() require("config.nnn").setup() end
    }

    -- Highlight todo comments
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        event = "BufReadPost",
        config = function() require("config.todo").setup() end
    }

    -- Terminal
    use {
        "akinsho/nvim-toggleterm.lua",
        event = "BufWinEnter",
        config = function() require("config.terminal").setup() end
    }

    -- Bookmarks
    use {"MattesGroeger/vim-bookmarks", event = "BufWinEnter"}

    use {
        "tom-anders/telescope-vim-bookmarks.nvim",
        requires = {
            {'nvim-telescope/telescope.nvim'}, {'MattesGroeger/vim-bookmarks'}
        },
        config = function()
            require('telescope').load_extension('vim_bookmarks')
        end
    }

    use {
        "romgrk/barbar.nvim",
        config = function() require("config.barbar").setup() end,
        requires = {'kyazdani42/nvim-web-devicons'},
        event = "BufWinEnter"
    }

    -- Debugging
    use({"mfussenegger/nvim-dap", ft = {"go"}, event = "ColorScheme"})

    use({"rcarriga/nvim-dap-ui", ft = {"go"}, after = "nvim-dap"})

    use({"theHamsta/nvim-dap-virtual-text", ft = {"go"}, after = "nvim-dap"})

    use "kyazdani42/nvim-web-devicons"

    use "kdheepak/lazygit.nvim"

end)
