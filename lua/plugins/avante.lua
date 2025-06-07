-- Avante.nvim configuration
-- A modern and feature-rich note-taking plugin for Neovim
return {
  "yetone/avante.nvim",
  -- Load on startup since it's a core functionality
  event = "VeryLazy",
  lazy = false,
  -- Track main branch for latest features
  version = false,
  opts = {
    hints = { enabled = false },
    file_selector = {
      provider = "snacks",
      provider_opts = {},
    },
    provider = "claude",
    -- provider = "gemini-pro",
  },
  -- Required build step
  build = "make",
  -- Required dependencies for full functionality
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
