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

    local function get_color(group, attr)
        -- Try to get the highlight definition directly
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        
        -- If the attribute is missing (e.g. it's a link or undefined), try resolving links
        if not hl or not hl[attr] then
            hl = vim.api.nvim_get_hl(0, { name = group })
        end
        
        if hl and hl[attr] then
            return string.format("#%06x", hl[attr])
        end
        return nil
    end

    local function update_markview_highlights()
        -- Dynamic Palette based on current theme
        local colors = {
            bg = get_color("Normal", "bg") or "#1d2021",
            fg = get_color("Normal", "fg") or "#ebdbb2",
            red = get_color("DiagnosticError", "fg") or "#fb4934",
            green = get_color("String", "fg") or "#b8bb26",
            yellow = get_color("Structure", "fg") or get_color("DiagnosticWarn", "fg") or "#fabd2f",
            blue = get_color("Function", "fg") or "#83a598",
            purple = get_color("Constant", "fg") or "#d3869b",
            aqua = get_color("Operator", "fg") or "#8ec07c",
            orange = get_color("Number", "fg") or "#fe8019",
            gray = get_color("Comment", "fg") or "#928374",
            bg_highlight = get_color("CursorLine", "bg") or "#3c3836",
            bg_code = get_color("NormalFloat", "bg") or "#282828"
        }

        local set_hl = function(group, opts)
            vim.api.nvim_set_hl(0, group, opts)
        end

        -- Customize Markview Highlights with Dynamic colors
        
        -- Headings
        set_hl("MarkviewHeading1", { fg = colors.orange, bg = colors.bg_highlight, bold = true })
        set_hl("MarkviewHeading2", { fg = colors.yellow, bold = true })
        set_hl("MarkviewHeading3", { fg = colors.green, bold = true })
        set_hl("MarkviewHeading4", { fg = colors.aqua, bold = true })
        set_hl("MarkviewHeading5", { fg = colors.blue, bold = true })
        set_hl("MarkviewHeading6", { fg = colors.purple, bold = true })

        -- Blockquotes
        set_hl("MarkviewBlockQuote", { fg = colors.gray })

        -- Code Blocks
        set_hl("MarkviewCode", { bg = colors.bg_code, fg = colors.fg })
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
    end

    -- Update on setup
    update_markview_highlights()

    -- Update on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = update_markview_highlights,
    })
  end,
}
