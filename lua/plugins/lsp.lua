return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "Mason" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/neodev.nvim", opts = {} },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
		config = function()
			-- broadcast cmp_nvim capabilities to language servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- servers and their configurations
			local servers = {
				tsserver = {},
				gopls = {},
				cssls = {},
				html = { filetypes = { "html", "twig", "hbs" } },
				eslint = {},
				ruff_lsp = {},
				bashls = {},
				dockerls = {},
				docker_compose_language_service = {},
				texlab = {},
				pyright = {},
				jdtls = {
					cmd = {
						"jdtls",
						"--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							telemetry = { enable = false },
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								disable = {
									"missing-fields",
								},
							},
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})

			vim.list_extend(ensure_installed, {
				-- Other tools to have installed
				"stylua",
				"prettierd",
				"gofumpt",
				"google-java-format",
				"pint",
				"beautysh",
				"delve",
				"debugpy",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			local function set_sign_icons(opts)
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
			{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			--Autocomplete plugin
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
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
				formatting = {
					format = require("lspkind").cmp_format({
						with_text = true,
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							path = "[Path]",
						},
					}),
				},
			})
			--Required by friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
