local M = {}

local highlights = {
  Normal = { bg = "NONE", fg = "#bdae93" },
  NormalNC = { bg = "NONE" },
  SignColumn = { bg = "NONE" },
  EndOfBuffer = { bg = "NONE" },
  FoldColumn = { bg = "NONE" },
  LineNr = { bg = "NONE", fg = "#928374" },
  CursorLineNr = { bg = "NONE", fg = "#a89984" },

  NormalFloat = { bg = "NONE" },
  FloatBorder = { bg = "NONE", fg = "#303030" },

  Pmenu = { bg = "NONE" },
  PmenuSbar = { bg = "NONE" },

  TelescopeNormal = { bg = "NONE" },
  TelescopeBorder = { bg = "NONE", fg = "#303030" },
  TelescopePromptNormal = { bg = "NONE" },
  TelescopePromptBorder = { bg = "NONE", fg = "#303030" },
  TelescopeResultsNormal = { bg = "NONE" },
  TelescopeResultsBorder = { bg = "NONE", fg = "#303030" },
  TelescopePreviewNormal = { bg = "NONE" },
  TelescopePreviewBorder = { bg = "NONE", fg = "#303030" },
}

function M.apply()
  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("UserHighlights", { clear = true })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      vim.schedule(M.apply)
    end,
  })

  M.apply()
end

return M
