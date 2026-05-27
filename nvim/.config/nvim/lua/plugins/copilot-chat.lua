return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			model = "auto",
			resources = { "buffer:listed" },
			window = { layout = "vertical", width = 0.4 },
			auto_insert_mode = true,
			-- See Configuration section for options
		},
		config = function(_, opts)
			local map = vim.keymap.set
			map({ "n", "v" }, "<leader>cc", function()
				require("CopilotChat").toggle()
			end, { desc = "[C]opilot [C]hat toggle" })
			map({ "n", "v" }, "<leader>cq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { resources = "selection" })
				end
			end, { desc = "[C]opilot [Q]uick Chat" })
			map("n", "<leader>cp", "<cmd>CopilotChatPrompts<CR>", { desc = "[C]opilot [P]rompts" })
			map("n", "<leader>cm", "<cmd>CopilotChatModels<CR>", { desc = "[C]opilot [M]odels" })
			map("n", "<leader>cr", "<cmd>CopilotChatReset<CR>", { desc = "[C]opilot [R]eset chat" })

			-- Hide Copilot inline suggestions when blink.cmp menu is open
			vim.api.nvim_create_autocmd("User", {
				pattern = "CopilotAttached",
				callback = function()
					vim.api.nvim_create_autocmd("User", {
						pattern = "BlinkCmpMenuOpen",
						callback = function()
							vim.b.copilot_suggestion_hidden = true
						end,
					})
					vim.api.nvim_create_autocmd("User", {
						pattern = "BlinkCmpMenuClose",
						callback = function()
							vim.b.copilot_suggestion_hidden = false
						end,
					})
				end,
			})
		end,
	},
}
