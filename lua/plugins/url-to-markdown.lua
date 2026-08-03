-- URL to Markdown converter plugin
return {
  name = "url-to-markdown",
  dir = vim.fn.stdpath("config"),
  config = function()
    local url_to_markdown = require("utils.url-to-markdown")
    url_to_markdown.setup({
      keybind = "<C-S-a>", -- Cmd+Shift+A, forwarded by Ghostty
    })
  end,
  filetype = { "markdown", "mdx" },
}
