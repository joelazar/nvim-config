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
    file_selector = {
      -- Use fzf for file selection interface
      provider = "fzf",
      provider_opts = {},
    },
  },
  -- Required build step
  build = "make",
  -- Required dependencies for full functionality
  dependencies = {
    "stevearc/dressing.nvim",    -- Enhanced UI components
    "nvim-lua/plenary.nvim",     -- Lua utility functions
    "MunifTanjim/nui.nvim",      -- UI component library
    "ibhagwan/fzf-lua",          -- Fuzzy finder implementation
    "echasnovski/mini.icons",    -- File icons support
    "zbirenbaum/copilot.lua",    -- AI completion integration
    {
      -- Image handling capabilities
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          -- Don't embed images as base64 in documents
          embed_image_as_base64 = false,
          -- Don't prompt for image filenames
          prompt_for_file_name = false,
          drag_and_drop = {
            -- Enable drag-and-drop in insert mode
            insert_mode = true,
          },
        },
      },
    },
  },
}
