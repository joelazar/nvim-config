return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "octo" },
  opts = {
    file_types = { "markdown", "octo" },
    completions = { lsp = { enabled = true } },
    checkbox = {
      custom = {
        progress = { raw = "[/]", rendered = "󰦕 ", highlight = "RenderMarkdownWarn" },
        cancelled = { raw = "[~]", rendered = "󰜺 ", highlight = "RenderMarkdownError" },
        important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownError" },
      },
    },
  },
}
