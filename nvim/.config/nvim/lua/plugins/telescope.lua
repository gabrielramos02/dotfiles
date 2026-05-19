return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Telescope buffers" })
	end,
}
