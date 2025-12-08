return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	ft = dart,
	config = function()
		require("flutter-tools").setup({
			outline = {
				open_cmd = "30vnew", -- command to use to open the outline buffer
				auto_open = false, -- if true this will open the outline automatically when it is first populated
			},
		})
		-- Telescope flutter
		require("telescope").load_extension("flutter")
		local flutter = require("telescope")
		vim.keymap.set("n", "<leader>fc", flutter.extensions.flutter.commands)
	end,
}
