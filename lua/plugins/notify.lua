return {
	"rcarriga/nvim-notify",
	lazy = false,
	config = function()
		require("notify").setup({
			top_down = false,
		})
		vim.notify = require("notify")
	end,
}
