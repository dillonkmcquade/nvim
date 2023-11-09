return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			typescript = { { "prettierd", "prettier" } },
			javascript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			go = { "gofumpt" },
			java = { "google-java-format" },
			php = { "pint" },
			sh = { "beautysh" },
			markdown = { { "prettierd", "prettier" } },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
