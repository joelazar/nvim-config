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
          header = [[Good morning Joe 🌤️!]],
        },
      },
    },
  },

  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = { { "ga.", mode = { "n", "v" }, "<cmd>TextCaseOpenTelescope<CR>", desc = "Telescope text-case" } },
    cmd = { "TextCaseOpenTelescope" },
  },

  {
    -- Measure the time spent on projects
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = { enabled = false },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
      spec = {
        {
          mode = { "n" },
          { "<leader>W", '<cmd>lua require("config.utils").sudo_write()', desc = "Write (sudo)" },
        },
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    setup = function()
      require("telescope").load_extension("undo")
    end,
    keys = {
      mode = { "n" },
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo history" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
        mode = "n",
      },
    },
    opts = {
      mappings = {
        n = {
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
          ["<c-a>"] = function(...)
            return require("telescope.actions").toggle_all(...)
          end,
          ["<S-Up>"] = require("telescope.actions").preview_scrolling_up,
          ["<S-Down>"] = require("telescope.actions").preview_scrolling_down,
          ["<PageDown>"] = require("telescope.actions").cycle_history_next,
          ["<PageUp>"] = require("telescope.actions").cycle_history_prev,
        },
        i = {
          ["<c-a>"] = function(...)
            return require("telescope.actions").toggle_all(...)
          end,
          ["<S-Up>"] = require("telescope.actions").preview_scrolling_up,
          ["<S-Down>"] = require("telescope.actions").preview_scrolling_down,
          ["<PageDown>"] = require("telescope.actions").cycle_history_next,
          ["<PageUp>"] = require("telescope.actions").cycle_history_prev,
        },
      },
      pickers = {
        find_files = {
          mappings = {
            i = {
              ["<esc>"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
      },
    },
  },
}
