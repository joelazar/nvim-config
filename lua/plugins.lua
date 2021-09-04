return require("packer").startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- LSP
    use "neovim/nvim-lspconfig"
    use {
        "kabouzeid/nvim-lspinstall",
        event = "VimEnter",
        config = function() require("lspinstall").setup() end
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

    -- Changes Vim working directory automagically
    use {
        "airblade/vim-rooter",
        config = function() vim.g.rooter_silent_chdir = 1 end
    }

    -- Fuzzy filtering
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function() require("config.telescope").setup() end
    }

    -- Colorschema
    use "romgrk/doom-one.vim"

    -- Completion & Snippets
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        config = function() vim.g.coq_settings = {auto_start = true} end
    }
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ Snippets

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        after = "coq_nvim",
        config = function() require("config.autopairs").setup() end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        branch = "0.5-compat",
        run = ":TSUpdate"
        -- config = function()
        --     require("core.treesitter").setup()
        -- end
    }

    -- Adds indentation guides to all lines
    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function() require("config.indent-blankline").setup() end
    }

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require("config.gitsigns").setup() end,
        event = "BufRead"
    }

    -- File manager
    use {
        "mcchrish/nnn.vim",
        event = "BufWinEnter",
        config = function() require("config.nnn").setup() end
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim"
        -- config = function()
        --   require("todo-comments").setup {
        --     -- your configuration comes here
        --     -- or leave it empty to use the default settings
        --     -- refer to the configuration section below
        --   }
        -- end
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

    use "kyazdani42/nvim-web-devicons"

    use "hoob3rt/lualine.nvim"

    use "kdheepak/lazygit.nvim"

    -- Debugging
    -- use {
    --     "mfussenegger/nvim-dap"
    --     -- event = "BufWinEnter",
    --     -- config = function() require("core.dap").setup() end,
    --     -- disable = not lvim.builtin.dap.active
    -- }

    -- -- Debugger management
    -- use {
    --     "Pocco81/DAPInstall.nvim"
    --     -- event = "BufWinEnter",
    --     -- event = "BufRead",
    -- }

    -- use "rcarriga/nvim-dap-ui"

    -- use "phaazon/hop.nvim"
    
    -- use "ray-x/go.nvim"
end)
