return {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			-- Web/JavaScript
			"ts_ls",     -- TypeScript/JavaScript
			"eslint",    -- JavaScript linting
			"html",      -- HTML
			"cssls",     -- CSS

			-- Systems
			"clangd",         -- C/C++
			"rust_analyzer",  -- Rust LSP (note: ty provides better type checking)

			-- Python
			"ruff",      -- Python linting & formatting (all-in-one)

			-- Lua
			"lua_ls",    -- Lua LSP

			-- Rust type checking (better than rust_analyzer for types)
			"ty",
		},
	},
}
