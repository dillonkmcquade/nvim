return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "Telescope" },
	keys = {
		{ "<leader>ff" },
		{ "<leader>gs" },
		{ "<leader><Tab>" },
		{ "<leader>fh" },
		{ "<leader>gr" },
	},
	opts = {
		file_ignore_patterns = {
			".git/",
			".cache",
			"%.o",
			"%.a",
			"%.out",
			"%.class",
			"%.pdf",
			"%.mkv",
			"%.mp4",
			"%.zip",
			"%.png",
			"%.jpg",
		},
	},
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
		vim.keymap.set("n", "<leader><Tab>", builtin.buffers, {})
		vim.keymap.set("n", "<leader>gr", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
