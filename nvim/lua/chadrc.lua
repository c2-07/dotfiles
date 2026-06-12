local M = {}

M.base46 = {
  theme = "gruvbox", -- default theme
  transparency = true,
  hl_override = {
    -- Core UI
    Pmenu = { bg = "none" },
    PmenuSel = { bg = "#242630", fg = "none" },
    NormalFloat = { bg = "none" },
    FloatBorder = { bg = "none", fg = "#404040" },
    CursorLine = { bg = "#222222" },

    -- Selector/Highlight for completion and themes
    BlinkCmpMenuSelection = { bg = "#242630", fg = "none" },
    TelescopeSelection = { bg = "#242630", fg = "none" },

    -- Borders for completion menu
    BlinkCmpMenuBorder = { fg = "#404040", bg = "none" },
    BlinkCmpDocBorder = { fg = "#404040", bg = "none" },

    -- Italic Groups
    Comment = { italic = true },
    Keyword = { italic = true },
    Conditional = { italic = true },
    Repeat = { italic = true },
    Label = { italic = true },
    Exception = { italic = true },
    Include = { italic = true },
    PreProc = { italic = true },

    -- Bold Groups
    Function = { bold = true },
    Type = { bold = true },
    Structure = { bold = true },
    StorageClass = { bold = true },
    Macro = { bold = true },
    Statement = { bold = true },
  },
}

M.ui = {
  statusline = {
    enabled = false,
    theme = "default",
  },
  tabufline = {
    enabled = false, -- Disabled as requested by user
  },
  cmp = {
    style = "default",
  },
}

return M
