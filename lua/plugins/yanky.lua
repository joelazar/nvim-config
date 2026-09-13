-- Yanky tweaks (plugin comes from lazyvim.plugins.extras.coding.yanky)
-- Free up gp/gP: they are mapped to system clipboard paste in config/keymaps.lua,
-- and yanky would otherwise re-map them once it loads.
return {
  "gbprod/yanky.nvim",
  keys = {
    { "gp", false },
    { "gP", false },
  },
}
