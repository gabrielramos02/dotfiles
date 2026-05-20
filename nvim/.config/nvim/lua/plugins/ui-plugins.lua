return {
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Fugitive" })
        end
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        enabled = false,
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    {
        'jiaoshijie/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', require('undotree').toggle,
                { desc = "Open Undotree", noremap = true, silent = true })
            require('undotree').setup()
        end
    }
}
