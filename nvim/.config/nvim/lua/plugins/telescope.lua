return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
        local map = vim.keymap.set
		map("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
		map("n", "<leader>pg", builtin.live_grep, { desc = "Telescope live grep" })
		map("n", "<leader>pb", builtin.buffers, { desc = "Telescope buffers" })
	end,
}
