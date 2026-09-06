-- neotest tweaks (plugin comes from lazyvim.plugins.extras.test.core + lang.go)
return {
  "nvim-neotest/neotest",
  opts = {
    adapters = {
      -- Use gotestsum for nicer, more reliable test output parsing
      ["neotest-golang"] = {
        runner = "gotestsum",
      },
    },
  },
}
