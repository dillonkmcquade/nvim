return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Test adapters
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
	},
	-- stylua: ignore
	keys = {
		{"<Leader>db", function () require("neotest").run.run({strategy = "dap"}) end, desc = "Debug nearest test"},
		{"<Leader>ta", function () require("neotest").run.run() end, desc = "Run the nearest test"},
		{ "<Leader>1", function () require("neotest").summary.toggle() end, { desc = "Toggle neotest summary" } },
		{ "<Leader>!", function () require("neotest").output.open() end, { desc = "Open neotest output" } },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-go")({
					recursive_run = true,
				}),
			},
			summary = {
				mappings = {
					watch = "<Leader>tw",
				},
			},
			status = { enabled = true, virtual_text = true, signs = true },
			output = { enabled = true, open_on_run = true },
		})
	end,
}
