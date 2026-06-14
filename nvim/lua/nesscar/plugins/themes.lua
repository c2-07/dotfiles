return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_mode = true,
      palette_overrides = {
        bright_red = "#e74330",    -- ~8% dimmer than #fb4934 (dark bg)
        bright_yellow = "#e6ae2b", -- ~8% dimmer than #fabd2f (dark bg)
        bright_green = "#a9ac23",  -- ~8% dimmer than #b8bb26 (dark bg)
        faded_red = "#900005",     -- ~8% dimmer than #9d0006 (light bg)
        faded_yellow = "#a76d12",  -- ~8% dimmer than #b57614 (light bg)
        faded_green = "#6f6b0d",   -- ~8% dimmer than #79740e (light bg)
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
