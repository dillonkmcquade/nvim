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

			local set_sign_icons = function(opts)
				opts = opts or {}

				local sign = function(args)
					if opts[args.name] == nil then
						return
					end

					vim.fn.sign_define(args.hl, {
						texthl = args.hl,
						text = opts[args.name],
						numhl = "",
					})
				end

				sign({ name = "error", hl = "DiagnosticSignError" })
				sign({ name = "warn", hl = "DiagnosticSignWarn" })
				sign({ name = "hint", hl = "DiagnosticSignHint" })
				sign({ name = "info", hl = "DiagnosticSignInfo" })
			end

			--Gutter icons
			set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "»",
			})
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
