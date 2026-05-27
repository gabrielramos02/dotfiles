return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			-- Replace the language servers listed here
			-- with the ones you want to install
			ensure_installed = { "lua_ls" },
			handlers = {
				function(server_name)
					local capabilities = require("blink.cmp").get_lsp_capabilities()
					vim.lsp.config(server_name, {
						on_init = function(client, _)
							client.server_capabilities.semanticTokensProvider = nil
						end,
						capabilities = capabilities,
					})
				end,
				vim.lsp.config("lua_ls", {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									vim.fn.stdpath("config"), -- Esto es clave para autocompletar tu config
								},
							},
							telemetry = { enable = false },
						},
					},
				}),
			},
		})
	end,
}
