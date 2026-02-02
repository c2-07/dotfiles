return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			end

			local on_attach = function(client, bufnr)
				-- check if any external formatter is attached to this buffer
				local has_formatter = false

				for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
					if c.name == "null-ls" or c.name == "none-ls" then
						has_formatter = true
						break
					end
				end

				-- disable LSP formatting ONLY if external formatter exists
				if has_formatter then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			end

			-- Hover popup
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			-- Servers
			-- TypeScript/JavaScript (using ts_ls)
			vim.lsp.config.ts_ls = { on_attach = on_attach, capabilities = capabilities }
			-- vim.lsp.config.eslint = { on_attach = on_attach, capabilities = capabilities }

			vim.lsp.config.lua_ls = {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			}
			vim.lsp.config.clangd = { on_attach = on_attach, capabilities = capabilities }

		-- Python: Ruff handles all linting and formatting
		vim.lsp.config.ruff = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		vim.lsp.enable({
			"ruff",      -- Python linting & formatting
			"ts_ls",     -- TypeScript/JavaScript
			"lua_ls",    -- Lua
			"clangd",    -- C/C++
			"ty",        -- Rust (improved type checking)
		})
		end,
	},
}
