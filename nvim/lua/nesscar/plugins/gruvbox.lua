return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000, -- load before UI plugins
	lazy = false, -- load immediately
	opts = {
		contrast = "hard",
		transparent_mode = true,
	},
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.cmd.colorscheme("gruvbox")

		-- ============================================================================
		-- GRUVBOX COLOR PALETTE (Hard Contrast, Dark Mode)
		-- ============================================================================
		local colors = {
			-- Neutrals
			bg = "#1d2021",           -- Dark background
			fg = "#ebdbb2",           -- Light foreground
			gray = "#928374",         -- Medium gray
			dark_gray = "#504945",    -- Dark gray
			light_gray = "#a89984",   -- Light gray

			-- Accent colors (from Gruvbox palette)
			red = "#fb4934",          -- Bright red
			green = "#b8bb26",        -- Bright green
			yellow = "#fabd2f",       -- Bright yellow
			blue = "#83a598",         -- Muted blue (aqua)
			purple = "#d3869b",       -- Muted purple/magenta
			orange = "#fe8019",       -- Bright orange
			aqua = "#8ec07c",         -- Bright aqua/green

			-- Dark variants (for background fills)
			red_dark = "#9d0006",
			green_dark = "#79740e",
			yellow_dark = "#b57614",
			blue_dark = "#076678",
			purple_dark = "#8f3f71",
		}

		-- ============================================================================
		-- POPUP UI STYLING (Pmenu, Completion Menu)
		-- Gruvbox native colors only - subtle, blends with background
		-- ============================================================================

		-- Pmenu (completion popup background)
		vim.api.nvim_set_hl(0, "Pmenu", {
			bg = "#1a1a1a",  -- Slightly darker than background (#131313)
			fg = colors.fg,  -- #ebdbb2: Primary text
		})

		-- PmenuSel (selected item in popup)
		vim.api.nvim_set_hl(0, "PmenuSel", {
			bg = "#242424",      -- Slightly lighter for selection
			fg = colors.yellow,  -- #fabd2f: Accent for visibility
			bold = true,
		})

		-- PmenuSbar (scrollbar background)
		vim.api.nvim_set_hl(0, "PmenuSbar", {
			bg = "#131313",  -- Match your background
		})

		-- PmenuThumb (scrollbar thumb/handle)
		vim.api.nvim_set_hl(0, "PmenuThumb", {
			bg = "#2a2a2a",  -- Slightly visible
		})

		-- Completion item text
		vim.api.nvim_set_hl(0, "CmpItemAbbr", {
			fg = colors.fg,  -- #ebdbb2: Default text
		})

		-- Matched characters in completion
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {
			fg = colors.yellow,  -- #fabd2f: Highlight matches
			bold = true,
		})

		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {
			fg = colors.yellow,  -- #fabd2f: Highlight fuzzy matches
			bold = true,
		})

		-- ============================================================================
		-- BLINK.CMP SPECIFIC POPUP STYLING
		-- ============================================================================

		-- Blink menu background
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", {
			bg = "#1a1a1a",  -- Slightly darker than background
		})

		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", {
			fg = "#2a2a2a",     -- Subtle border
			bg = "#1a1a1a",
		})

		-- Blink selection
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", {
			bg = "#242424",      -- Slightly lighter
			fg = colors.yellow,  -- #fabd2f: Yellow accent
			bold = true,
		})

		-- Blink documentation panel
		vim.api.nvim_set_hl(0, "BlinkCmpDoc", {
			bg = "#1a1a1a",  -- Match popup
		})

		vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", {
			fg = "#2a2a2a",     -- Subtle border
			bg = "#1a1a1a",
		})

		-- ============================================================================
		-- SEMANTIC COLOR DIFFERENTIATION FOR COMPLETION KINDS
		-- Using Gruvbox's native semantic highlighting colors
		-- ============================================================================

		-- Functions/Methods - Red (Gruvbox function color)
		vim.api.nvim_set_hl(0, "CmpItemKindFunction", {
			fg = colors.red,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindFunction", {
			fg = colors.red,
			bold = true,
		})

		-- Methods - Red (same as functions)
		vim.api.nvim_set_hl(0, "CmpItemKindMethod", {
			fg = colors.red,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindMethod", {
			fg = colors.red,
			bold = true,
		})

		-- Variables - Default foreground (Gruvbox default)
		vim.api.nvim_set_hl(0, "CmpItemKindVariable", {
			fg = colors.fg,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindVariable", {
			fg = colors.fg,
		})

		-- Classes/Types - Yellow (Gruvbox type color)
		vim.api.nvim_set_hl(0, "CmpItemKindClass", {
			fg = colors.yellow,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindClass", {
			fg = colors.yellow,
			bold = true,
		})
		vim.api.nvim_set_hl(0, "CmpItemKindStruct", {
			fg = colors.yellow,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindStruct", {
			fg = colors.yellow,
			bold = true,
		})

		-- Keywords - Red (Gruvbox keyword color)
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", {
			fg = colors.red,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindKeyword", {
			fg = colors.red,
			bold = true,
		})

		-- Snippets - Purple (Gruvbox constant color)
		vim.api.nvim_set_hl(0, "CmpItemKindSnippet", {
			fg = colors.purple,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindSnippet", {
			fg = colors.purple,
			bold = true,
		})

		-- Modules/Imports - Orange (structural)
		vim.api.nvim_set_hl(0, "CmpItemKindModule", {
			fg = colors.orange,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindModule", {
			fg = colors.orange,
			bold = true,
		})

		-- Properties/Fields - Green (Gruvbox string color for data)
		vim.api.nvim_set_hl(0, "CmpItemKindProperty", {
			fg = colors.green,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindProperty", {
			fg = colors.green,
		})
		vim.api.nvim_set_hl(0, "CmpItemKindField", {
			fg = colors.green,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindField", {
			fg = colors.green,
		})

		-- Enums - Yellow (type definitions)
		vim.api.nvim_set_hl(0, "CmpItemKindEnum", {
			fg = colors.yellow,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindEnum", {
			fg = colors.yellow,
			bold = true,
		})

		-- Constants - Purple (Gruvbox constant color)
		vim.api.nvim_set_hl(0, "CmpItemKindConstant", {
			fg = colors.purple,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindConstant", {
			fg = colors.purple,
		})

		-- TypeParameters - Yellow (type-related)
		vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", {
			fg = colors.yellow,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindTypeParameter", {
			fg = colors.yellow,
		})

		-- EnumMembers - Yellow (type-related)
		vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", {
			fg = colors.yellow,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindEnumMember", {
			fg = colors.yellow,
		})

		-- Constructor - Red (function-like)
		vim.api.nvim_set_hl(0, "CmpItemKindConstructor", {
			fg = colors.red,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindConstructor", {
			fg = colors.red,
			bold = true,
		})

		-- Interfaces - Yellow (type definitions)
		vim.api.nvim_set_hl(0, "CmpItemKindInterface", {
			fg = colors.yellow,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindInterface", {
			fg = colors.yellow,
			bold = true,
		})

		-- Text/Buffer - Gray (less important)
		vim.api.nvim_set_hl(0, "CmpItemKindText", {
			fg = colors.light_gray,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindText", {
			fg = colors.light_gray,
		})

		-- Files/Folders - Green (data/paths)
		vim.api.nvim_set_hl(0, "CmpItemKindFile", {
			fg = colors.green,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindFile", {
			fg = colors.green,
		})
		vim.api.nvim_set_hl(0, "CmpItemKindFolder", {
			fg = colors.green,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindFolder", {
			fg = colors.green,
		})

		-- References/Values - Purple (constants/references)
		vim.api.nvim_set_hl(0, "CmpItemKindReference", {
			fg = colors.purple,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindReference", {
			fg = colors.purple,
		})

		-- Values - Purple (constants)
		vim.api.nvim_set_hl(0, "CmpItemKindValue", {
			fg = colors.purple,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindValue", {
			fg = colors.purple,
		})

		-- Unit/Events - Orange (special)
		vim.api.nvim_set_hl(0, "CmpItemKindUnit", {
			fg = colors.orange,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindUnit", {
			fg = colors.orange,
		})
		vim.api.nvim_set_hl(0, "CmpItemKindEvent", {
			fg = colors.orange,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindEvent", {
			fg = colors.orange,
		})

		-- Operators - Red (function-like operations)
		vim.api.nvim_set_hl(0, "CmpItemKindOperator", {
			fg = colors.red,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindOperator", {
			fg = colors.red,
		})

		-- Misc - Gray (fallback)
		vim.api.nvim_set_hl(0, "CmpItemKindMisc", {
			fg = colors.light_gray,
			bg = "NONE",
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemKindMisc", {
			fg = colors.light_gray,
		})

		-- ============================================================================
		-- BLINK ITEM TEXT STYLING
		-- ============================================================================

		-- Main item text (matched part highlight)
		vim.api.nvim_set_hl(0, "BlinkCmpItemAbbr", {
			fg = colors.fg,
		})

		-- Highlight matched characters
		vim.api.nvim_set_hl(0, "BlinkCmpItemAbbrMatch", {
			fg = colors.yellow,
			bold = true,
		})
		vim.api.nvim_set_hl(0, "BlinkCmpItemAbbrMatchFuzzy", {
			fg = colors.yellow,
			bold = true,
		})

		-- Ghost text (inline preview) - subtle
		vim.api.nvim_set_hl(0, "BlinkCmpGhostText", {
			fg = colors.gray,
			italic = true,
		})

		-- ============================================================================
		-- PMENU FALLBACK STYLING (for non-blink menus)
		-- ============================================================================

		vim.api.nvim_set_hl(0, "Pmenu", {
			bg = "#282828",
			fg = colors.fg,
		})

		vim.api.nvim_set_hl(0, "PmenuSel", {
			bg = colors.blue_dark,
			fg = colors.aqua,
			bold = true,
		})

		vim.api.nvim_set_hl(0, "PmenuSbar", {
			bg = colors.dark_gray,
		})

		vim.api.nvim_set_hl(0, "PmenuThumb", {
			bg = colors.light_gray,
		})

		-- ============================================================================
		-- SIGNATURE HELP & FLOAT STYLING
		-- ============================================================================

		-- Float background (glass)
		vim.api.nvim_set_hl(0, "NormalFloat", {
			bg = "NONE",
		})

		-- Soft border (visible but not loud)
		vim.api.nvim_set_hl(0, "FloatBorder", {
			fg = colors.dark_gray,
			bg = "NONE",
		})

		-- Highlight active parameter (focus cue)
		vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
			fg = colors.yellow,
			bold = true,
		})

		-- ============================================================================
		-- TELESCOPE & OTHER FLOAT UI
		-- ============================================================================

		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "Normal" })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "FloatBorder" })
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Normal" })
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		-- ============================================================================
		-- DIFF HIGHLIGHTING
		-- ============================================================================

		vim.api.nvim_set_hl(0, "DiffAdd", {
			bg = colors.green_dark,
			fg = colors.green,
		})

		vim.api.nvim_set_hl(0, "DiffDelete", {
			bg = colors.red_dark,
			fg = colors.red,
		})

		vim.api.nvim_set_hl(0, "DiffChange", {
			bg = colors.blue_dark,
			fg = colors.blue,
		})

		vim.api.nvim_set_hl(0, "DiffText", {
			bg = "#3c3836",
			fg = colors.yellow,
			bold = true,
		})
	end,
}
