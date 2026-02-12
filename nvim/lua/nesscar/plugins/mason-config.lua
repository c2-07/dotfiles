return {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"ts_ls",
			"html",
			"cssls",
			"clangd",
			"rust_analyzer",
			"ruff",
			"lua_ls",
			"ty",
		},
	},
}
