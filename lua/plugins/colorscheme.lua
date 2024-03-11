return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd.colorscheme("kanagawa")
	end,
}
