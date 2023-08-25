return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		config = function()
			require("lsp-zero.settings").preset({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		config = function()
			local lsp = require("lsp-zero")

			-- lsp keymaps, loaded on attach
			lsp.on_attach(function(_, bufnr)
				local nmap = function(keys, action, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, action, { buffer = bufnr, remap = false, desc = desc })
				end
				lsp.default_keymaps({ buffer = bufnr })
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
				end, { buffer = bufnr, remap = false, desc = "Signature help" })
			end)

			--Configure lua language server for neovim
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			-- Format on save
			lsp.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = {
						"javascript",
						"typescript",
						"css",
						"html",
						"json",
						"jsonc",
						"markdown",
						"java",
						"javascriptreact",
						"typescriptreact",
						"lua",
						"sh",
						"go",
					},
				},
			})

			lsp.ensure_installed({
				"tsserver",
				"lua_ls",
				"html",
				"cssls",
			})

			--Gutter icons
			lsp.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "»",
			})
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.formatting.gofumpt,
				},
			})

			lsp.setup()
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
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n"] = cmp.mapping.select_next_item(cmp_select),
					["<Tab>"] = cmp.mapping.confirm({ select = false }),
					["<C-Space>"] = cmp.mapping.complete(),
				},
				preselect = cmp.PreselectMode.None,
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
			})

			--Required by friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
