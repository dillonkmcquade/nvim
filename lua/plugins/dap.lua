return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				opts = {},
				config = function(_, opts)
					local dap, dapui = require("dap"), require("dapui")
					dapui.setup(opts)

					-- Change breakpoint icon
					vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open({})
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close({})
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close({})
					end
				end,
				-- stylua: ignore
				keys = {
					{ "<Leader>df", function() require("dapui").toggle() end, { desc = "Dap: Toggle DAP ui" }, },
				},
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
			{
				"leoluz/nvim-dap-go",
				config = function()
					local dap_go = require("dap-go")
					dap_go.setup()
				end,
			},
			{
				"mfussenegger/nvim-dap-python",
				config = function()
					require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
				end,
			},
		},
		-- stylua: ignore
		keys = {
			{ "<F5>", function() require("dap").continue() end, { desc = "Dap: continue" }, },
			{ "<F6>", function() require("dap").step_over() end, { desc = "Dap: step over" }, },
			{ "<F7>", function() require("dap").step_into() end, { desc = "Dap: step into" }, },
			{ "<F8>", function() require("dap").step_out() end, { desc = "Dap: step out" }, },
			{ "<Leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Dap: Toggle breakpoint" }, },
			{ "<Leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Dap: hover" }, },
			{ "<Leader>dp", function() require("dap.ui.widgets").preview() end, { desc = "Dap: preview" }, },
		},
	},
}
