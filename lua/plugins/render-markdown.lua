return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    checkbox = {
      custom = {
        progress = { raw = "[/]", rendered = "󰦕 ", highlight = "RenderMarkdownWarn" },
        cancelled = { raw = "[~]", rendered = "󰜺 ", highlight = "RenderMarkdownError" },
        important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownError" },
      },
    },
  },
}
