return {
	--Easy commenting
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},

	--Auto finish tags
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	--Wrap blocks of text
	"tpope/vim-surround",
	"tpope/vim-sleuth",

	--Workflow
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Undo tree toggle" },
		},
	},
}
