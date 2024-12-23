return {
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
    keys = {
      { "<A-Left>", "<cmd>BufferLineCyclePrev<cr>", mode = "n", desc = "Move to previous buffer" },
      { "<A-Right>", "<cmd>BufferLineCycleNext<cr>", mode = "n", desc = "Move to next buffer" },
      { "<A-,>", "<cmd>BufferLineMovePrev<cr>", mode = "n", desc = "Re-order to previous buffer" },
      { "<A-.>", "<cmd>BufferLineMoveNext<cr>", mode = "n", desc = "Re-order to next buffer" },
      { "<A-p>", "<cmd>BufferLineTogglePin<cr>", mode = "n", desc = "Pin buffer" },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[Hey Joe 👋!]],
        },
      },
      indent = {
        scope = { enabled = false },
        animate = { enabled = false },
      },
      scroll = {
        enabled = false,
      },
    },
  },

  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
    end,
  },

  {
    -- Measure the time spent on projects
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        golangci_lint_ls = {},
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<C-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = { LazyVim.cmp.map({ "snippet_forward" }), "select_next", "fallback" },
        ["<S-Tab>"] = { LazyVim.cmp.map({ "snippet_backward" }), "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
      },
      completion = { list = { selection = "manual" } },
    },
  },

  {
    "ibhagwan/fzf-lua",
    opts = {
      oldfiles = {
        include_current_session = true,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
      icons = {
        mappings = false,
        rules = false,
      },
      spec = {
        {
          mode = { "n" },
          { "<leader>W", '<cmd>lua require("config.utils").sudo_write()', desc = "Write (sudo)" },
        },
      },
    },
  },
}
