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
      { "<A-p>", "<cmd>BufferLineTogglePin<cr>", mode = "n", desc = "Toggle Pin" },
      { "<leader>bP", false },
      { "<leader>bw", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete All Buffers" },
      { "<leader>bW", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
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
    keys = {
      { "<C-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        golangci_lint_ls = {},
      },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "hrsh7th/cmp-calc",
      "saghen/blink.compat",
      "Kaiser-Yang/blink-cmp-avante",
      {
        "Kaiser-Yang/blink-cmp-git",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      keymap = {
        ["<Tab>"] = { LazyVim.cmp.map({ "snippet_forward" }), "select_next", "fallback" },
        ["<S-Tab>"] = { LazyVim.cmp.map({ "snippet_backward" }), "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
        ["<C-j>"] = { "select_and_accept" },
      },
      completion = { list = { selection = { preselect = false, auto_insert = false } } },
      sources = {
        default = { "avante", "git", "dictionary", "calc" },
        compat = { "calc" },
        providers = {
          calc = {
            kind = "calc",
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            opts = {},
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {},
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            opts = {},
          },
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

  {
    "ZWindL/orphans.nvim",
    config = function()
      require("orphans").setup({})
    end,
    cmd = { "Orphans" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "sql", "gotmpl", "comment" } },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", os.getenv("HOME") .. "/.config/nvim/.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },

  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end,
    cmd = "BlameToggle",
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local function is_textfile()
        local filetype = vim.bo.filetype
        return filetype == "markdown"
          or filetype == "asciidoc"
          or filetype == "pandoc"
          or filetype == "tex"
          or filetype == "text"
      end

      local function wordcount()
        local wc = vim.fn.wordcount()
        local visual_words = wc.visual_words or wc.words
        local word_string = visual_words == 1 and " word" or " words"
        return tostring(visual_words) .. word_string
      end

      table.insert(opts.sections.lualine_z, { wordcount, cond = is_textfile })
    end,
  },
}
