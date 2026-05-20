return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
    enabled = false,
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
            actions = {
                open_file = {
                    quit_on_open = true
                }
            }
        })
		vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, {desc = "Open Tree"})
	end,
}
