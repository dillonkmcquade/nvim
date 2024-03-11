return {
	"stevearc/overseer.nvim",
	opts = {},
	config = function()
		require("overseer").setup()
		vim.keymap.set("n", "<Leader>!", ":OverseerRun<CR>", { desc = "Overseer: Run" })
		vim.keymap.set("n", "<Leader>1", ":OverseerToggle<CR>", { desc = "Overseer: Toggle" })
	end,
}
