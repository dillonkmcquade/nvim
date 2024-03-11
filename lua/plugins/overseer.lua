return {
	"stevearc/overseer.nvim",
	opts = {},
	config = function(_, opts)
		require("overseer").setup(opts)
		vim.keymap.set("n", "<Leader>!", ":OverseerRun<CR>", { desc = "Overseer: Run" })
		vim.keymap.set("n", "<Leader>1", ":OverseerToggle<CR>", { desc = "Overseer: Toggle" })
	end,
}
