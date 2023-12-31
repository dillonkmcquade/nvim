return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			typescript = { "prettierd" },
			javascript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			go = { "gofumpt" },
			java = { "google-java-format" },
			php = { "pint" },
			sh = { "beautysh" },
			markdown = { "prettierd" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
