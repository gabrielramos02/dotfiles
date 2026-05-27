vim.g.mapleader = " "

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>Y", '"+Y')

vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>ec", function()
	local config_path = vim.fn.stdpath("config")
	vim.cmd("vsplit " .. config_path)
end, { desc = "Open Neovim Config Folder" })

--vim.keymap.set('n', '<leader>pe', ':Explore<CR>', { silent = true })
