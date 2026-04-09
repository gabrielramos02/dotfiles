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
			dev_log = {
				enabled = true,
				filter = nil, -- optional callback to filter the log
				-- takes a log_line as string argument; returns a boolean or nil;
				-- the log_line is only added to the output if the function returns true
				notify_errors = false, -- if there is an error whilst running then notify the user
				open_cmd = "belowright 15new", -- command to use to open the log buffer
				focus_on_open = true, -- focus on the newly opened log window
			},
			debugger = {
				enabled = true,
				run_via_dap = true,
				register_configurations = function(paths)
					local dap = require("dap")
					dap.adapters.dart = {
						type = "executable",
						command = paths.flutter_bin,
						args = { "debug-adapter" },
					}
				end,
			},
		})
		vim.keymap.set("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>")
		vim.keymap.set("n", "<leader>dd", ":lua require('dap').continue()<CR>")
		vim.keymap.set("n", "<leader>do", ":lua require('dap').step_over()<CR>")
		vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>")
		-- Telescope flutter
		require("telescope").load_extension("flutter")
		local flutter = require("telescope")
		vim.keymap.set("n", "<leader>fc", flutter.extensions.flutter.commands)
	end,
}
