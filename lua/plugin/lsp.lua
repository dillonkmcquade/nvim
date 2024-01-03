return {
	{
		"williamboman/mason-lspconfig.nvim",
		cmd = { "LspInfo", "Mason" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/neodev.nvim" },
		},
		config = function()
			-- broadcast cmp_nvim capabilities to language servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- servers and their configurations
			local servers = {
				tsserver = {},
				gopls = {},
				html = { filetypes = { "html", "twig", "hbs" } },
				eslint = {},
				bashls = {},
				dockerls = {},
				docker_compose_language_service = {},
				tailwindcss = {},
				jdtls = {
					cmd = {
						"jdtls",
						"--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
					},
				},
				lua_ls = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			}

			-- Provides a lua_ls configuration
			require("neodev").setup()

			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							settings = servers[server_name],
							filetypes = (servers[server_name] or {}).filetypes,
						})
					end,
				},
			})

			-- lsp keymaps, loaded on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					local nmap = function(keys, action, desc)
						if desc then
							desc = "LSP: " .. desc
						end
						vim.keymap.set("n", keys, action, { buffer = ev.buf, remap = false, desc = desc })
					end
					nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
					nmap("K", vim.lsp.buf.hover, "Hover Documentation")
					nmap("<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
					nmap("<leader>vd", vim.diagnostic.open_float, "Open float")
					nmap("<leader>pr", vim.lsp.buf.format, "Format")
					nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
					nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
					nmap("<leader>vca", vim.lsp.buf.code_action, "code actions")
					nmap("<leader>vrr", vim.lsp.buf.references, "Open references")
					nmap("<leader>vrn", vim.lsp.buf.rename, "Rename")
					nmap("<leader>D", vim.lsp.buf.type_definition, "Type definition")
					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, { buffer = ev.buf, remap = false, desc = "Signature help" })
				end,
			})

			--Gutter icons
			--[[ lsp.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "»",
			}) ]]
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			--Autocomplete plugin
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n"] = cmp.mapping.select_next_item(cmp_select),
					["<Tab>"] = cmp.mapping.confirm({ select = false }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
			})

			--Required by friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
