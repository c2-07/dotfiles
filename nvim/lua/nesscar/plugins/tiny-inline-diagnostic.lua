return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000, -- Ensure it loads before other diagnostic plugins
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "minimal",
      options = {
        show_source = true,
        use_icons_from_diagnostic = true,
      },
    })
  end,
}
