return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettierd" },
			javascript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascriptreact = { "prettierd" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			json = { "prettierd" },
			css = { "prettierd" },
			html = { "djlint", "prettierd" },
			htmldjango = { "djlint" },
			go = { "gofumpt" },
			php = { "pint" },
			sh = { "beautysh" },
			markdown = { "prettierd" },
			yaml = { "prettierd" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		notify_on_error = true,
	},
}
