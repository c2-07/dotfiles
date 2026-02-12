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
				local has_formatter = false

				for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
					if c.name == "null-ls" or c.name == "none-ls" then
						has_formatter = true
						break
					end
				end

				if has_formatter then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			end

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.config.ts_ls = { on_attach = on_attach, capabilities = capabilities }
			vim.lsp.config.lua_ls = {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			}
			vim.lsp.config.clangd = { on_attach = on_attach, capabilities = capabilities }
			vim.lsp.config.ruff = {
				capabilities = capabilities,
				on_attach = function(client)
					-- Ruff = formatter only
					client.server_capabilities.diagnosticProvider = false

					-- keep formatting
					client.server_capabilities.documentFormattingProvider = true
					client.server_capabilities.documentRangeFormattingProvider = true
				end,
			}
			vim.lsp.config.ty = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.enable({
				"ruff",
				"ts_ls",
				"lua_ls",
				"clangd",
				"ty",
			})
		end,
	},
}
