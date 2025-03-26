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
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-7-sonnet-latest",
      temperature = 0,
      max_tokens = 4096,
    },
    ollama = {
      model = "qwq:32b",
    },
    gemini = {
      model = "gemini-2.0-flash",
    },

    provider = "gemini-pro",
    cursor_applying_provider = "groq",
    -- NOTE: only needed for weaker models
    -- behaviour = {
    --   enable_cursor_planning_mode = true, -- enable cursor planning mode!
    -- },
    vendors = {
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
        max_completion_tokens = 32768,
      },
      ["gemini-pro"] = {
        __inherited_from = "gemini",
        model = "gemini-2.5-pro-exp-03-25",
      },
    },
  },
  -- Required build step
  build = "make",
  -- Required dependencies for full functionality
  dependencies = {
    "stevearc/dressing.nvim", -- Enhanced UI components
    "nvim-lua/plenary.nvim", -- Lua utility functions
    "MunifTanjim/nui.nvim", -- UI component library
    "echasnovski/mini.icons", -- File icons support
    "zbirenbaum/copilot.lua", -- AI completion integration
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
