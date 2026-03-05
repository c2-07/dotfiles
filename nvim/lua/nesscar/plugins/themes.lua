return {
	-- ============================================================================
	-- THEME MANAGER & SWITCHER
	-- ============================================================================
	{
		"gourav/theme-switcher",
		dir = vim.fn.stdpath("config") .. "/lua/nesscar/plugins",
		lazy = false,
		priority = 1000,
		config = function()
			-- PERSISTENCE UTILS
			local state_file = vim.fn.stdpath("data") .. "/theme_state.json"
			
			local function save_state(state)
				local f = io.open(state_file, "w")
				if f then
					f:write(vim.fn.json_encode(state))
					f:close()
				end
			end

			local function load_state()
				local f = io.open(state_file, "r")
				if f then
					local content = f:read("*a")
					f:close()
					local ok, state = pcall(vim.fn.json_decode, content)
					if ok then return state end
				end
				return nil
			end

			-- Initialize transparency state
			if vim.g.transparent_enabled == nil then
				local saved = load_state()
				if saved and saved.transparent ~= nil then
					vim.g.transparent_enabled = saved.transparent
				else
					vim.g.transparent_enabled = true
				end
			end

			-- 1. GLOBAL "BLACK FOG" OVERRIDES (The Core Logic)
			local function apply_black_fog()
				local black = "#000000"
				local dark_gray = "#151515" -- Slightly lighter than black for selection
				local border_gray = "#303030"
				local white = "#ffffff"

				-- Determine background color based on toggle
				local main_bg = vim.g.transparent_enabled and "none" or black

				local overrides = {
					-- Main Background (Toggled)
					Normal = { bg = main_bg },
					-- CursorLine (Handled conditionally below)
					-- CursorLine = { bg = "#222222" }, -- Slightly lighter to be visible against black
					CursorLineNr = { bg = "none", fg = "#909090", bold = true },
					NonText = { bg = main_bg },
					LineNr = { bg = main_bg, fg = "#505050" },
					Folded = { bg = main_bg },
					SignColumn = { bg = main_bg },
					EndOfBuffer = { bg = main_bg },

					-- Floating Windows (ALWAYS Black Fog)
					NormalFloat = { bg = black },
					FloatBorder = { bg = black, fg = border_gray },
					FloatTitle = { bg = black, fg = white, bold = true },

					-- Popup Menus
					Pmenu = { bg = black },
					PmenuSel = { link = "CursorLine" },
					PmenuSbar = { bg = black },
					PmenuThumb = { bg = border_gray },

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

					-- Blink / CMP
					BlinkCmpMenu = { bg = black },
					BlinkCmpMenuBorder = { fg = border_gray, bg = black },
					BlinkCmpMenuSelection = { link = "CursorLine" },
					BlinkCmpDoc = { bg = black },
					BlinkCmpDocBorder = { fg = border_gray, bg = black },

					-- Separators
					VertSplit = { fg = border_gray, bg = main_bg },
					WinSeparator = { fg = border_gray, bg = main_bg },
					StatusLine = { bg = black, fg = border_gray },
					StatusLineNC = { bg = black, fg = border_gray },

					-- Indent Blankline (Fix for "No highlight group 'IblScope' found")
					-- We ensure these exist so the plugin doesn't crash on theme switch
					IblIndent = { fg = border_gray, nocombine = true },
					IblScope = { fg = border_gray, nocombine = true },
					IblWhitespace = { fg = border_gray, nocombine = true },

					-- Illuminated Words (vim-illuminate) - highlight variable under cursor
					IlluminatedWordText = { bg = "#353535" },
					IlluminatedWordRead = { bg = "#353535" },
					IlluminatedWordWrite = { bg = "#353535" },

					-- Dropbar (Persistent Winbar) - Match CursorLine-ish style
					-- We use a dedicated dark gray background to distinguish it from the code
					DropBar = { bg = "#1e1e1e", fg = "#a0a0a0" },
					DropBarIconKind = { bg = "#1e1e1e", fg = "#a0a0a0" },
					DropBarIconUI = { bg = "#1e1e1e", fg = "#a0a0a0" },
					DropBarText = { bg = "#1e1e1e", fg = "#a0a0a0" },
					
					-- Ensure standard WinBar groups match if DropBar falls back
					WinBar = { bg = "#1e1e1e", fg = "#a0a0a0" },
					WinBarNC = { bg = "#1e1e1e", fg = "#606060" },

					-- Floating Menus (Dropbar Menus)
					-- Solid background (no transparency) to prevent text-over-text issues
					DropBarMenu = { bg = "#1e1e1e", fg = "#c0c0c0" }, 
					DropBarMenuHover = { bg = "#303030", fg = white, bold = true },
					DropBarMenuCurrentContext = { bg = "#303030", fg = white, bold = true },
				}

				-- Handle CursorLine conditionally based on user preference
				-- Catppuccin uses the specific dark gray (#222222)
				-- Other themes use their default CursorLine (to match theme), but we can adjust if needed
				if vim.g.colors_name and string.find(vim.g.colors_name, "catppuccin") then
					overrides.CursorLine = { bg = "#222222" }
				else
					-- For other themes, we use a subtle, theme-matching cursor line
					-- By default, we let the theme set it.
					-- If we wanted to force a specific style for all others, we'd do it here.
					-- overrides.CursorLine = { bg = "#1a1a1a" } -- Example generic dark
				end

				for group, opts in pairs(overrides) do
					-- Force create/override to ensure they exist
					opts.default = false
					vim.api.nvim_set_hl(0, group, opts)
				end

				-- 3. LINK COMPLETION ICONS TO THEME SYNTAX
				-- This ensures icons match the color of the code in the current theme
				local kind_links = {
					-- Functions
					BlinkCmpItemKindFunction = "Function",
					BlinkCmpItemKindMethod = "Function",
					BlinkCmpItemKindConstructor = "Function",
					CmpItemKindFunction = "Function",
					CmpItemKindMethod = "Function",
					CmpItemKindConstructor = "Function",

					-- Variables / Data
					BlinkCmpItemKindVariable = "Identifier",
					BlinkCmpItemKindField = "@field", -- Fallback to Identifier if theme doesn't support treesitter
					BlinkCmpItemKindProperty = "@property",
					CmpItemKindVariable = "Identifier",
					CmpItemKindField = "@field",
					CmpItemKindProperty = "@property",

					-- Types
					BlinkCmpItemKindClass = "Type",
					BlinkCmpItemKindStruct = "Structure",
					BlinkCmpItemKindInterface = "Type",
					BlinkCmpItemKindEnum = "Type",
					BlinkCmpItemKindEnumMember = "Constant",
					CmpItemKindClass = "Type",
					CmpItemKindStruct = "Structure",
					CmpItemKindInterface = "Type",
					CmpItemKindEnum = "Type",
					CmpItemKindEnumMember = "Constant",

					-- Keywords
					BlinkCmpItemKindKeyword = "Keyword",
					BlinkCmpItemKindOperator = "Operator",
					CmpItemKindKeyword = "Keyword",
					CmpItemKindOperator = "Operator",

					-- Constants
					BlinkCmpItemKindConstant = "Constant",
					BlinkCmpItemKindValue = "Constant",
					CmpItemKindConstant = "Constant",
					CmpItemKindValue = "Constant",

					-- Misc
					BlinkCmpItemKindModule = "Include",
					BlinkCmpItemKindFile = "Directory",
					BlinkCmpItemKindFolder = "Directory",
					BlinkCmpItemKindSnippet = "Special",
					BlinkCmpItemKindText = "Comment",
					CmpItemKindModule = "Include",
					CmpItemKindFile = "Directory",
					CmpItemKindFolder = "Directory",
					CmpItemKindSnippet = "Special",
					CmpItemKindText = "Comment",
				}

				for kind_group, target_group in pairs(kind_links) do
					-- Force the link to update even if it exists
					vim.api.nvim_set_hl(0, kind_group, { link = target_group, default = false })
				end

				-- Force GRUVBOX-like Text Styles (Bold/Italic)
				-- We do this by retrieving the current color and adding attributes
				local styles = {
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
					Statement = { bold = true }, -- Often includes keywords, be careful
				}

				for group, style_opts in pairs(styles) do
					-- Get current definition (resolving links to get actual color)
					local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
					if hl and not vim.tbl_isempty(hl) then
						-- Merge existing color/style with forced style
						local new_hl = vim.tbl_extend("force", hl, style_opts)
						vim.api.nvim_set_hl(0, group, new_hl)
					end
				end
				-- 4. DYNAMIC CURSOR COLOR (Matches Theme Accent)
				-- We try to find the "accent" color of the theme (often Function or Keyword)
				local accent_group = "Function"
				local accent_hl = vim.api.nvim_get_hl(0, { name = accent_group, link = false })
				
				-- If we can't find a color directly, try resolving links
				if not accent_hl or not accent_hl.fg then
					accent_hl = vim.api.nvim_get_hl(0, { name = accent_group, link = true })
				end

				if accent_hl and accent_hl.fg then
					-- Set the cursor background to the theme's accent color
					-- And text inside cursor to black for contrast
					vim.api.nvim_set_hl(0, "Cursor", { bg = accent_hl.fg, fg = "#000000" })
					vim.api.nvim_set_hl(0, "TermCursor", { bg = accent_hl.fg, fg = "#000000" })
					
					-- Ensure the terminal knows about this color change (for some terminals)
					vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
				end
			end

			-- Apply overrides whenever colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = apply_black_fog,
			})


			-- 2. TRANSPARENCY TOGGLE COMMAND
			vim.api.nvim_create_user_command("ToggleTransparency", function()
				vim.g.transparent_enabled = not vim.g.transparent_enabled
				
				-- Save new state
				local current_state = load_state() or {}
				current_state.transparent = vim.g.transparent_enabled
				save_state(current_state)

				-- Reload current colorscheme to re-trigger the autocmd
				if vim.g.colors_name then
					vim.cmd.colorscheme(vim.g.colors_name)
				end
				print("Transparency: " .. (vim.g.transparent_enabled and "ON" or "OFF"))
			end, {})

			vim.keymap.set("n", "<leader>bg", "<cmd>ToggleTransparency<cr>", { desc = "Toggle Transparency" })


			-- 3. THEME SELECTOR (Smart Detection)
			-- Defines variants for themes that support them
			local theme_variants = {
				catppuccin = {
					{ name = "Mocha",     id = "catppuccin-mocha" },
					{ name = "Macchiato", id = "catppuccin-macchiato" },
					{ name = "Frappe",    id = "catppuccin-frappe" },
					{ name = "Latte",     id = "catppuccin-latte" },
				},
				tokyonight = {
					{ name = "Night", id = "tokyonight-night" },
					{ name = "Storm", id = "tokyonight-storm" },
					{ name = "Moon",  id = "tokyonight-moon" },
					{ name = "Day",   id = "tokyonight-day" },
				},
				sonokai = {
					base = "sonokai",
					variants = {
						{ name = "Default",   style = "default" },
						{ name = "Atlantis",  style = "atlantis" },
						{ name = "Andromeda", style = "andromeda" },
						{ name = "Shusia",    style = "shusia" },
						{ name = "Maia",      style = "maia" },
						{ name = "Espresso",  style = "espresso" },
					}
				},
				everforest = {
					base = "everforest",
					variants = {
						{ name = "Hard",   style = "hard" },
						{ name = "Medium", style = "medium" },
						{ name = "Soft",   style = "soft" },
					}
				},
				material = {
					base = "material",
					variants = {
						{ name = "Darker",     style = "darker" },
						{ name = "Lighter",    style = "lighter" },
						{ name = "Oceanic",    style = "oceanic" },
						{ name = "Palenight",  style = "palenight" },
						{ name = "Deep Ocean", style = "deep ocean" },
					}
				},
				gruvbox = {
					base = "gruvbox",
					variants = {
						{ name = "Hard",   style = "hard" },
						{ name = "Medium", style = "medium" },
						{ name = "Soft",   style = "soft" },
					}
				},
				monokai = {
					base = "monokai",
					variants = {
						{ name = "Pro",       type = "pro" },
						{ name = "Classic",   type = "classic" },
						{ name = "Machine",   type = "machine" },
						{ name = "Ristretto", type = "ristretto" },
						{ name = "Spectrum",  type = "spectrum" },
					}
				},
				zenbones = {
					base = "zenbones",
					variants = {
						{ name = "Zenbones",       id = "zenbones" },
						{ name = "Zenwritten",     id = "zenwritten" },
						{ name = "Duckbones",      id = "duckbones" },
						{ name = "Forestbones",    id = "forestbones" },
						{ name = "Kanagawabones",  id = "kanagawabones" },
						{ name = "Neobones",       id = "neobones" },
						{ name = "Nordbones",      id = "nordbones" },
						{ name = "Rosebones",      id = "rosebones" },
						{ name = "Seoulbones",     id = "seoulbones" },
						{ name = "Tokyobones",     id = "tokyobones" },
						{ name = "Vimbones",       id = "vimbones" },
						{ name = "Zenburned",      id = "zenburned" },
					}
				},
			}

			local function activate_theme(choice)
				if choice.type == "simple" then
					vim.cmd.colorscheme(choice.id)
				elseif choice.type == "sonokai" then
					vim.g.sonokai_style = choice.variant.style
					vim.cmd.colorscheme("sonokai")
				elseif choice.type == "everforest" then
					vim.g.everforest_background = choice.variant.style
					vim.cmd.colorscheme("everforest")
				elseif choice.type == "material" then
					vim.g.material_style = choice.variant.style
					vim.cmd.colorscheme("material")
				elseif choice.type == "gruvbox" then
					require("gruvbox").setup({ contrast = choice.variant.style, transparent_mode = true })
					vim.cmd.colorscheme("gruvbox")
				elseif choice.type == "monokai" then
					local palette = require("monokai")[choice.variant.type]
					require("monokai").setup({ palette = palette })
					vim.cmd.colorscheme("monokai")
				elseif choice.type == "catppuccin" then
					if choice.variant.id then vim.cmd.colorscheme(choice.variant.id) end
				elseif choice.type == "tokyonight" then
					if choice.variant.id then vim.cmd.colorscheme(choice.variant.id) end
				elseif choice.type == "zenbones" then
					if choice.variant.id then vim.cmd.colorscheme(choice.variant.id) end
				end
				
				-- Save selection
				local current_state = load_state() or {}
				current_state.theme = choice
				save_state(current_state)
			end
			
			-- LOAD SAVED THEME ON STARTUP
			vim.schedule(function()
				local saved = load_state()
				if saved and saved.theme then
					activate_theme(saved.theme)
				else
					-- Default fallback
					vim.cmd.colorscheme("catppuccin")
				end
			end)

			vim.api.nvim_create_user_command("ThemeSelect", function()
				local options = {}
				
				-- Get list of currently installed/available themes
				local installed_themes = vim.fn.getcompletion("", "color")
				local installed_map = {}
				for _, t in ipairs(installed_themes) do installed_map[t] = true end

				-- A. Add variants for ALL supported themes (Unconditionally)
				-- We assume these plugins are installed via this very file.
				local handled_ids = {} -- Keep track of IDs we've already added
				
				for key, config in pairs(theme_variants) do
					local variants = config.variants or config
					for _, v in ipairs(variants) do
						table.insert(options, {
							label = "🎨 " .. key:gsub("^%l", string.upper) .. ": " .. v.name,
							type = key,
							variant = v
						})
						
						-- Store handled IDs to prevent duplicates in the generic list
						if v.id then handled_ids[v.id] = true end
						if config.base then handled_ids[config.base] = true end
					end
				end

				-- B. Add other detected themes (that aren't in our variant list)
				local ignored = { "blue", "darkblue", "default", "delek", "desert", "elflord", "evening", "industry", "koehler", "morning", "murphy", "pablo", "peachpuff", "ron", "shine", "slate", "torte", "quiet", "vim", "lunaperche", "habamax", "zaibatsu", "retrobox", "sorbet", "wildcharm", "zellner", "unokai", "random" }
				
				for _, name in ipairs(installed_themes) do
					local is_handled = false
					
					-- Check against our explicit handled list first
					if handled_ids[name] then
						is_handled = true
					else
						-- Fallback: Check if theme name contains a key (e.g. "tokyonight-storm" contains "tokyonight")
						for key, _ in pairs(theme_variants) do
							if name:find(key) then is_handled = true break end
						end
					end
					
					local is_ignored = false
					for _, ignore in ipairs(ignored) do
						if name == ignore then is_ignored = true break end
						-- Ignore random/utility themes often included in packs
						if name:find("random") then is_ignored = true break end
					end

					if not is_handled and not is_ignored then
						table.insert(options, {
							label = "🖌️  " .. name,
							type = "simple",
							id = name
						})
					end
				end

				table.sort(options, function(a, b) return a.label < b.label end)

				vim.ui.select(options, {
					prompt = "Select Theme",
					format_item = function(item) return item.label end,
				}, function(choice)
					if not choice then return end
					
					-- Wrap in pcall to handle cases where plugin might be missing
					local ok, err = pcall(function() activate_theme(choice) end)
					if ok then
						print("Switched to " .. choice.label)
					else
						print("Error switching theme: " .. err)
					end
				end)
			end, {})

			vim.keymap.set("n", "<leader>th", "<cmd>ThemeSelect<cr>", { desc = "Select Theme" })
		end,
	},

	-- ============================================================================
	-- INSTALLED THEMES
	-- ============================================================================
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				integrations = {
					cmp = true, gitsigns = true, nvimtree = true, treesitter = true,
					mini = { enabled = true }, telescope = { enabled = true },
					blink_cmp = true, mason = true, native_lsp = { enabled = true }
				}
			})
			-- Removed explicit colorscheme call here to let the manager handle it
		end,
	},
	{ "folke/tokyonight.nvim", lazy = true, opts = { style = "night", transparent = true } },
	{ "sainnhe/sonokai", lazy = true, config = function() vim.g.sonokai_transparent_background = 1 end },
	{ "sainnhe/everforest", lazy = true, config = function() vim.g.everforest_transparent_background = 1 end },
	{ "marko-cerovac/material.nvim", lazy = true, config = function() vim.g.material_style = "deep ocean" end },
	{ "shaunsingh/nord.nvim", lazy = true, config = function() vim.g.nord_disable_background = true end },
	{ "tanvirtin/monokai.nvim", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true, opts = { transparent_mode = true } },
	{ "zenbones-theme/zenbones.nvim", lazy = true, dependencies = "rktjmp/lush.nvim" },
}
