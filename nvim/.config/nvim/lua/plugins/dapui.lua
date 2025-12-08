return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		require("dapui").setup()
		local dapui = require("dapui")
		vim.keymap.set("n", "<leader>do", dapui.open, { desc = "Dapui open " })
	end,
}
