return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  -- Completion for `blink.cmp`
  dependencies = { "saghen/blink.cmp" },

  config = function()
    local markview = require("markview")

    markview.setup({
        -- No presets, rely on manual highlights
    })

    -- Define Gruvbox colors manually for Markview
    local colors = {
      bg = "#1d2021",
      fg = "#ebdbb2",
      red = "#fb4934",
      green = "#b8bb26",
      yellow = "#fabd2f",
      blue = "#83a598",
      purple = "#d3869b",
      aqua = "#8ec07c",
      orange = "#fe8019",
      gray = "#928374",
    }

    local set_hl = function(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Customize Markview Highlights with Gruvbox colors
    
    -- Headings
    set_hl("MarkviewHeading1", { fg = colors.orange, bg = "#3c3836", bold = true })
    set_hl("MarkviewHeading2", { fg = colors.yellow, bold = true })
    set_hl("MarkviewHeading3", { fg = colors.green, bold = true })
    set_hl("MarkviewHeading4", { fg = colors.aqua, bold = true })
    set_hl("MarkviewHeading5", { fg = colors.blue, bold = true })
    set_hl("MarkviewHeading6", { fg = colors.purple, bold = true })

    -- Blockquotes
    set_hl("MarkviewBlockQuote", { fg = colors.gray })

    -- Code Blocks
    set_hl("MarkviewCode", { bg = "#282828", fg = colors.fg })
    set_hl("MarkviewCodeInfo", { fg = colors.gray })

    -- Horizontal Rule
    set_hl("MarkviewHorizontalRule", { fg = colors.orange, bold = true })

    -- Tables
    set_hl("MarkviewTableBorder", { fg = colors.gray })
    set_hl("MarkviewTableAlignLeft", { fg = colors.fg })
    set_hl("MarkviewTableAlignRight", { fg = colors.fg })
    set_hl("MarkviewTableAlignCenter", { fg = colors.fg })

    -- Checkboxes
    set_hl("MarkviewCheckboxChecked", { fg = colors.green })
    set_hl("MarkviewCheckboxUnchecked", { fg = colors.gray })
  end,
}
