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

    use "nvim-lua/plenary.nvim"

    use "nvim-lua/popup.nvim"

    use "tjdevries/astronauta.nvim"

    use {
        "folke/which-key.nvim",
        config = function() require("config.which-key").setup() end,
        event = "BufWinEnter"
    }

    use {
        "terrortylor/nvim-comment",
        config = function()
            local status_ok, nvim_comment = pcall(require, "nvim_comment")
            if not status_ok then return end
            nvim_comment.setup()
        end
    }

    use {
        "airblade/vim-rooter",
        config = function() vim.g.rooter_silent_chdir = 1 end
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        -- config = function()
        --     require("core.telescope").setup()
        -- end
    }

    -- Completion & Snippets
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter"
        -- config = function()
        --   require("core.compe").setup()
        -- end,
    }
    use {"L3MON4D3/LuaSnip", event = "InsertCharPre"}
    use {"rafamadriz/friendly-snippets", event = "InsertCharPre"}

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        -- event = "InsertEnter",
        after = "nvim-compe"
        -- config = function()
        --     require "core.autopairs"
        -- end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        branch = "0.5-compat"
        -- run = ":TSUpdate",
        -- config = function()
        --     require("core.treesitter").setup()
        -- end
    }

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        -- config = function()
        --   require("core.gitsigns").setup()
        -- end,
        event = "BufRead"
    }

    use "mcchrish/nnn.vim"

    use {
        "folke/todo-comments.nvim"
        -- requires = "nvim-lua/plenary.nvim",
        -- config = function()
        --   require("todo-comments").setup {
        --     -- your configuration comes here
        --     -- or leave it empty to use the default settings
        --     -- refer to the configuration section below
        --   }
        -- end
    }

    use "akinsho/nvim-toggleterm.lua"

    use {
        "romgrk/barbar.nvim",
        -- config = function()
        --     require "config.barbar"
        -- end,
        requires = {'kyazdani42/nvim-web-devicons'},
        event = "BufWinEnter"
    }
    use "kyazdani42/nvim-web-devicons"
    use "hoob3rt/lualine.nvim"
    use "kdheepak/lazygit.nvim"

    -- Debugging
    use {
        "mfussenegger/nvim-dap"
        -- event = "BufWinEnter",
        -- config = function() require("core.dap").setup() end,
        -- disable = not lvim.builtin.dap.active
    }

    -- Debugger management
    use {
        "Pocco81/DAPInstall.nvim"
        -- event = "BufWinEnter",
        -- event = "BufRead",
    }

    use "rcarriga/nvim-dap-ui"

    use "karb94/neoscroll.nvim"

    -- use "phaazon/hop.nvim"
    -- use "ray-x/go.nvim"
end)
