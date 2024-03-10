return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap_python = require("dap-python")

			-- Setup
			dap_python.setup("~/.virtualenvs/debugpy/bin/python")
			require("dap-go").setup()
			require("nvim-dap-virtual-text").setup({})

			-- Configuration

			dap_python.test_runner = "pytest"

			local dap, dapui = require("dap"), require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>df", dapui.toggle)

			local function dap_select()
				local dap_python_db = dap_python.test_method
				local dap_go_db = require("dap-go").debug_test
				vim.ui.select({ "python", "go" }, {
					prompt = "Select a debug adapter to run",
				}, function(item)
					if item == "python" then
						dap_python_db()
					elseif item == "go" then
						dap_go_db()
					end
				end)
			end

			vim.keymap.set("n", "<Leader>db", dap_select)
		end,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",

			--  Adapter configuration for specific languages
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
		},
	},
}
