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
-- Clean and minimal inline diagnostics configuration
-- CUSTOMIZATION: Adjust icons here for each severity level

local diagnostic_signs = {
	[vim.diagnostic.severity.ERROR] = "󰅚 ", -- Edit this icon for errors
	[vim.diagnostic.severity.WARN] = "󰀪 ", -- Edit this icon for warnings
	[vim.diagnostic.severity.INFO] = "󰋽 ", -- Edit this icon for info
	[vim.diagnostic.severity.HINT] = "󰌶 ", -- Edit this icon for hints
}

vim.diagnostic.config({
	-- Virtual text (inline diagnostics)
	virtual_text = {
		prefix = function(diagnostic)
			return diagnostic_signs[diagnostic.severity]
		end,
		spacing = 2, -- CUSTOMIZATION: Adjust spacing between icon and message (increase for more gap)
		source = "if_many", -- Only show source if multiple diagnostics
		format = function(diagnostic)
			-- CUSTOMIZATION: Truncate messages longer than 80 chars to keep inline clean
			-- Press 'K' on the diagnostic to see full message in floating window
			if #diagnostic.message > 80 then
				return diagnostic.message:sub(1, 77) .. "..."
			end
			return diagnostic.message
		end,
	},
	-- Gutter signs
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs[vim.diagnostic.severity.ERROR],
			[vim.diagnostic.severity.WARN] = diagnostic_signs[vim.diagnostic.severity.WARN],
			[vim.diagnostic.severity.INFO] = diagnostic_signs[vim.diagnostic.severity.INFO],
			[vim.diagnostic.severity.HINT] = diagnostic_signs[vim.diagnostic.severity.HINT],
		},
		linehl = {}, -- CUSTOMIZATION: Add line highlighting if desired (e.g., linehl = { [vim.diagnostic.severity.ERROR] = "ErrorLine" })
		numhl = {}, -- CUSTOMIZATION: Add number line highlighting if desired
	},
	-- Underlines
	underline = true,
	-- Don't update diagnostics while in insert mode
	update_in_insert = false,
	-- Sort by severity
	severity_sort = true,
	-- Floating window config
	float = {
		border = "rounded",
		source = "if_many",
		max_width = 80,
		max_height = 20,
		focusable = true,
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
	-- Jump to diagnostics behavior
	jump = {
		float = false,
	},
})

-- Optional: Add custom highlighting for better visibility
-- CUSTOMIZATION: Modify the hex color codes below to change diagnostic highlight colors
-- ERROR: #ff6b6b (red), WARN: #ffd93d (yellow), INFO: #6bcf7f (green), HINT: #4a9eff (blue)
vim.cmd([[
	highlight DiagnosticUnderlineError cterm=underline gui=underline guisp=#ff6b6b
	highlight DiagnosticUnderlineWarn cterm=underline gui=underline guisp=#ffd93d
	highlight DiagnosticUnderlineInfo cterm=underline gui=underline guisp=#6bcf7f
	highlight DiagnosticUnderlineHint cterm=underline gui=underline guisp=#4a9eff
]])
