return {
	"stevearc/overseer.nvim",
	opts = {},
	keys = {
		{ "<Leader>!", ":OverseerRun<CR>", { desc = "Overseer: Run" } },
		{ "<Leader>1", ":OverseerToggle<CR>", { desc = "Overseer: Toggle" } },
	},
	config = function(_, opts)
		require("overseer").setup(opts)
	end,
}
