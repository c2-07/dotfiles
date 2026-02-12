return {
	"dmtrKovalenko/fff.nvim",
	build = 'export OPENSSL_DIR=$(/opt/homebrew/bin/brew --prefix openssl@3) && export OPENSSL_LIB_DIR=$OPENSSL_DIR/lib && export OPENSSL_INCLUDE_DIR=$OPENSSL_DIR/include && export LIBRARY_PATH=$OPENSSL_LIB_DIR && export INCLUDE_PATH=$OPENSSL_INCLUDE_DIR && export CFLAGS="-Wno-error=unused-but-set-variable -Wno-error=unused-variable -Wno-error=unknown-warning-option" && rustup run nightly-2025-01-01 cargo build --release --lib && cp "$(rustup run nightly-2025-01-01 cargo metadata --format-version 1 | grep -o \'"target_directory":"[^"]*"\' | head -1 | cut -d\'"\' -f4)/release/libfff_nvim.dylib" lua/fff.so',
	config = function()
		local fff = require("fff")

		-- Keymaps
		vim.keymap.set("n", "<leader>ff", fff.find_files, { desc = "fff: Find files" })
		vim.keymap.set("n", "<leader><leader>", fff.find_files, { desc = "fff: Find files" })

		vim.keymap.set("n", "<leader>gr", fff.refresh_git_status, { desc = "fff: Refresh Git" })

		-- FFF Setup
		fff.setup({
			-- Core
			prompt = " > ",
			title = "Find Files", -- no title = cleaner
			max_results = 15,
			lazy_sync = true,

			layout = {
				height = 0.45, -- smaller container
				width = 0.5,
				prompt_position = "top",
			},

			-- No preview
			preview = {
				enabled = false,
			},

			-- Minimal UI
			icons = { enabled = true },
			git = { status_text_color = true },

			-- Optional: keep or kill history
			history = {
				enabled = true,
			},
		})
	end,
}
