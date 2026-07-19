return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_mode = true,
      palette_overrides = {
        -- bright_red = "#e74330",    -- ~8% dimmer than #fb4934 (dark bg)
        -- bright_yellow = "#e6ae2b", -- ~8% dimmer than #fabd2f (dark bg)
        -- bright_green = "#a9ac23",  -- ~8% dimmer than #b8bb26 (dark bg)
        -- faded_red = "#900005",     -- ~8% dimmer than #9d0006 (light bg)
        -- faded_yellow = "#a76d12",  -- ~8% dimmer than #b57614 (light bg)
        -- faded_green = "#6f6b0d",   -- ~8% dimmer than #79740e (light bg)
        dark0 = "#282828",
        dark1 = "#2d2d2d",
        dark2 = "#32302f",
        dark3 = "#3c3836",
        dark4 = "#45403d",

        light0 = "#ddc7a1",
        light1 = "#d4be98",
        light2 = "#bdae93",
        light3 = "#a89984",
        light4 = "#928374",

        bright_red = "#ea6962",
        bright_green = "#a9b665",
        bright_yellow = "#d8a657",
        bright_blue = "#7daea3",
        bright_purple = "#d3869b",
        bright_aqua = "#89b482",
        bright_orange = "#e78a4e",

        neutral_red = "#ea6962",
        neutral_green = "#a9b665",
        neutral_yellow = "#d8a657",
        neutral_blue = "#7daea3",
        neutral_purple = "#d3869b",
        neutral_aqua = "#89b482",
        neutral_orange = "#e78a4e",

        faded_red = "#c14a4a",
        faded_green = "#879c3c",
        faded_yellow = "#c18f41",
        faded_blue = "#6f8faf",
        faded_purple = "#945e80",
        faded_aqua = "#4c7a5d",
        faded_orange = "#c35e0a",
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
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
  },
}
