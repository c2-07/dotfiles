return {
	{
		"Bekaboo/dropbar.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		opts = {
			menu = {
				win_configs = {
					border = "rounded",
					style = "minimal",
					col = nil,
					row = nil,
					width = nil,
					height = nil,
					relative = "mouse",
					-- Transparency/Blur - Reduced to 0 (no blur) to fix text readability issues
					winblend = 0, 
				},
			},
			bar = {
				enable = true,
				attach_events = {
					"BufWinEnter",
					"BufWritePost",
				},
			},
			icons = {
				kinds = {
					File = "󰈙 ",
					Module = " ",
					Namespace = "󰌗 ",
					Package = " ",
					Class = "󰌗 ",
					Method = "󰆧 ",
					Property = " ",
					Field = " ",
					Constructor = " ",
					Enum = "󰕘",
					Interface = "󰕘",
					Function = "󰊕 ",
					Variable = "󰆧 ",
					Constant = "󰏿 ",
					String = "󰀬 ",
					Number = "󰎠 ",
					Boolean = "✜ ",
					Array = "󰅪 ",
					Object = "󰅩 ",
					Key = "󰌋 ",
					Null = "󰟢 ",
					EnumMember = " ",
					Struct = "󰌗 ",
					Event = " ",
					Operator = "󰆕 ",
					TypeParameter = "󰊄 ",
				},
			},
			-- Ensure winbar is persistent to avoid shaking
			general = {
				update_interval = 50,
			}
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in dropbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
}
