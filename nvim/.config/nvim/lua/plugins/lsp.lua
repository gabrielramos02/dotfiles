return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			-- optional: provides snippets for the snippet source
			"rafamadriz/friendly-snippets",
			{
				"giuxtaposition/blink-cmp-copilot",
				dependencies = {
					{
						"zbirenbaum/copilot.lua",
						opts = {
							suggestion = { enabled = false },
							panel = { enabled = false },
						},
					},
				},
			},
		},
		build = function()
			-- build the fuzzy matcher, wait up to 60 seconds
			-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
			require("blink.cmp").build():wait(60000)
		end,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "enter" },
			signature = { enabled = true },

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true } },

			-- (Default) list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"`
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "lua" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		opts = {
			servers = { lua_ls = {} },
		},
		config = function(_, opts)
			-- This will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = "yes"
			--			local lsp = vim.lsp
			--			for server, config in pairs(opts.servers) do
			--				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			--				lsp.config(server, config)
			--			end
			vim.diagnostic.config({ virtual_text = true })
			-- This is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					if vim.bo.filetype ~= "oil" then
						local opts = { buffer = event.buf }
						vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover" })
						vim.keymap.set(
							"n",
							"gd",
							"<cmd>lua vim.lsp.buf.definition()<cr>",
							{ desc = "Go to definition" }
						)
						vim.keymap.set(
							"n",
							"gD",
							"<cmd>lua vim.lsp.buf.declaration()<cr>",
							{ desc = "Go to declaration" }
						)
						vim.keymap.set(
							"n",
							"gi",
							"<cmd>lua vim.lsp.buf.implementation()<cr>",
							{ desc = "Go to implementation" }
						)
						vim.keymap.set(
							"n",
							"go",
							"<cmd>lua vim.lsp.buf.type_definition()<cr>",
							{ desc = "Go to type definition" }
						)
						vim.keymap.set(
							"n",
							"gr",
							"<cmd>lua vim.lsp.buf.references()<cr>",
							{ desc = "Go to references" }
						)
						vim.keymap.set(
							"n",
							"gs",
							"<cmd>lua vim.lsp.buf.signature_help()<cr>",
							{ desc = "Go to signature_help" }
						)
						vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
						vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
						vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
						vim.keymap.set("n", "<CR>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
						vim.keymap.set(
							"n",
							"gn",
							"<cmd>lua vim.diagnostic.jump({count = 1})<cr>",
							{ desc = "Next diagnostic" }
						)
						vim.keymap.set(
							"n",
							"gN",
							"<cmd>lua vim.diagnostic.jump({count = -1})<cr>",
							{ desc = "Previous diagnostic" }
						)
						vim.keymap.set(
							"n",
							"ge",
							"<cmd>lua vim.diagnostic.open_float()<CR>",
							{ noremap = true, silent = true }
						)
					end
				end,
			})
		end,
	},
}
