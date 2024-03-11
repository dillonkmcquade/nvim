return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"html",
			"javascript",
			"go",
			"typescript",
			"tsx",
			"json",
			"python",
			"css",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"yaml",
			"bash",
		},
		ignore_install = {},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
	},
	config = function(_, opts)
		local configs = require("nvim-treesitter.configs")
		configs.setup(opts)
	end,
}
