return {
    'jiaoshijie/undotree',
    config = function ()
        vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })
	    require('undotree').setup()
    end
}
