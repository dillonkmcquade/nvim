return {
	--colorscheme
	{
		"rmehri01/onenord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onenord").setup({
				disable = {
					background = true,
				},
			})
		end,
	},

	--Easy commenting
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
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

	--Workflow
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Undo tree toggle" },
		},
	},
}
