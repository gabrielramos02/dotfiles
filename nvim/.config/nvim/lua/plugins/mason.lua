return {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            -- Replace the language servers listed here
            -- with the ones you want to install
            ensure_installed = { "lua_ls", "bashls", "basedpyright" },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_init = function(client, _)
                            client.server_capabilities.semanticTokensProvider = nil
                        end,
                    })
                end,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = { globals = { 'vim' } },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME,
                                        vim.fn.stdpath('config'), -- Esto es clave para autocompletar tu config
                                    },
                                },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
            },
        })
    end,
}
