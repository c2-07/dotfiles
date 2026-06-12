return {
	"saghen/blink.cmp",
	version = "1.*",

	opts = {
		cmdline = { enabled = true },

		snippets = {
			expand = function(snippet)
				local ok, err = pcall(vim.snippet.expand, snippet)
				if not ok then
					local cursor = vim.api.nvim_win_get_cursor(0)
					local row, col = cursor[1] - 1, cursor[2]
					vim.api.nvim_buf_set_text(0, row, col, row, col, { snippet })
					vim.api.nvim_win_set_cursor(0, { row + 1, col + #snippet })
				end
			end,
		},

		keymap = {
			preset = "enter",
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
		},

		completion = {
			trigger = {
				show_on_trigger_character = true,
				show_on_blocked_trigger_characters = { " ", "\n", "\t" },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 300,
				update_delay_ms = 300,
				window = { border = "single" },
			},
			ghost_text = {
				enabled = true,
				show_with_menu = true,
			},
			menu = {
				auto_show = true,
				border = "single",
				draw = {
					columns = {
						{ "kind_icon", gap = 1 },
						{ "label", "label_description", gap = 1 },
						{ "kind", gap = 1 },
					},
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local kind_icons = {
									Text = "󰉿",
									Method = "󰆧",
									Function = "󰊕",
									Constructor = "",
									Field = "󰜢",
									Variable = "󰀫",
									Class = "󰠱",
									Interface = "",
									Module = "",
									Property = "󰜢",
									Unit = "󰑭",
									Value = "󰎠",
									Enum = "",
									Keyword = "󰌋",
									Snippet = "",
									Color = "󰏘",
									File = "󰈙",
									Reference = "󰈇",
									Folder = "󰉋",
									EnumMember = "",
									Constant = "󰏿",
									Struct = "󰙅",
									Event = "",
									Operator = "󰆕",
									TypeParameter = "󰏿",
								}
								return (kind_icons[ctx.kind] or "󰈚") .. " "
							end,
							highlight = function(ctx)
								return "BlinkCmpKind" .. ctx.kind
							end,
						},
						kind = {
							ellipsis = false,
							text = function(ctx)
								return ctx.kind
							end,
							highlight = function(ctx)
								return "BlinkCmpKind" .. ctx.kind
							end,
						},
					},
				},
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust" },
	},
	opts_extend = { "sources.default" },
}
