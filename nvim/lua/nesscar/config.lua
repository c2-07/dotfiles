-- Configuration module for filetype and diagnostics settings
-- Consolidates global language-specific indentation and diagnostic display

-- ============================================================================
-- FILETYPE CONFIGURATION
-- ============================================================================
-- Global language-specific indentation settings
-- Based on .editorconfig best practices and language conventions

local indent_config = {
	-- C/C++ and similar languages: 2-space indent
	c = 2,
	cpp = 2,
	cc = 2,
	cxx = 2,
	h = 2,
	hpp = 2,
	hxx = 2,
	hh = 2,

	-- JavaScript/TypeScript: 2-space indent
	javascript = 2,
	typescript = 2,
	javascriptreact = 2,
	typescriptreact = 2,
	jsx = 2,
	tsx = 2,

	-- Web languages: 2-space indent
	html = 2,
	css = 2,
	scss = 2,
	sass = 2,
	less = 2,
	json = 2,
	jsonc = 2,
	yaml = 2,
	xml = 2,

	-- Python: 4-space indent
	python = 4,

	-- Rust: 4-space indent
	rust = 4,

	-- Go: 4-space (we use spaces, not tabs)
	go = 4,

	-- Java: 4-space indent
	java = 4,

	-- C#: 4-space indent
	cs = 4,

	-- PHP: 4-space indent
	php = 4,

	-- Shell scripts: 2-space indent
	bash = 2,
	sh = 2,
	zsh = 2,

	-- Lua: 2-space indent
	lua = 2,

	-- Ruby: 2-space indent
	ruby = 2,

	-- SQL: 2-space indent
	sql = 2,

	-- Markdown: 2-space indent
	markdown = 2,

	-- Dockerfile: 2-space indent
	dockerfile = 2,

	-- Default for unknown types: 2 spaces
}

-- Apply indentation settings on FileType change
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("GlobalIndentConfig", { clear = true }),
	callback = function(event)
		local filetype = event.match
		local indent = indent_config[filetype] or 2 -- Default to 2 spaces

		-- Set indent for the current buffer
		vim.bo.shiftwidth = indent
		vim.bo.softtabstop = indent
		vim.bo.tabstop = indent
	end,
})

-- Optional: Command to check current indentation
vim.api.nvim_create_user_command("IndentWidth", function()
	vim.notify(
		string.format(
			"Current indent settings:\n  shiftwidth: %d\n  softtabstop: %d\n  tabstop: %d\n  filetype: %s",
			vim.bo.shiftwidth,
			vim.bo.softtabstop,
			vim.bo.tabstop,
			vim.bo.filetype
		),
		vim.log.levels.INFO
	)
end, {})

-- ============================================================================
-- DIAGNOSTICS CONFIGURATION
-- ============================================================================
-- Configuration is handled by lsp-lines plugin.
-- See plugins/lsp-lines.lua for details.

