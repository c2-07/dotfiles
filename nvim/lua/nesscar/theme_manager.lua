local M = {}

local black = "#000000"
local border_gray = "#303030"
local white = "#ffffff"

local ui_overrides = {
  -- Floating Windows
  NormalFloat = { bg = black },
  FloatBorder = { bg = black, fg = border_gray },
  FloatTitle = { bg = black, fg = white, bold = true },

  -- Popup Menus (Pmenu / Blink / CMP)
  Pmenu = { bg = black },
  PmenuSel = { bg = "#222222" },
  PmenuSbar = { bg = black },
  PmenuThumb = { bg = border_gray },
  BlinkCmpMenu = { bg = black },
  BlinkCmpMenuBorder = { fg = border_gray, bg = black },
  BlinkCmpDoc = { bg = black },
  BlinkCmpDocBorder = { fg = border_gray, bg = black },

  -- Telescope
  TelescopeNormal = { bg = black },
  TelescopeBorder = { bg = black, fg = border_gray },
  TelescopePromptNormal = { bg = black },
  TelescopePromptBorder = { bg = black, fg = border_gray },
  TelescopeResultsNormal = { bg = black },
  TelescopeResultsBorder = { bg = black, fg = border_gray },
  TelescopePreviewNormal = { bg = black },
  TelescopePreviewBorder = { bg = black, fg = border_gray },
  TelescopeTitle = { bg = black, fg = white, bold = true },
}

function M.apply_overrides()
  for group, opts in pairs(ui_overrides) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

function M.setup()
  -- Apply on ColorScheme change
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = M.apply_overrides,
  })

  -- Initial apply
  M.apply_overrides()
end

return M
