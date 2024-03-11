-- For selecting DAP adapter with one keybind
local function dap_select(commands)
	vim.ui.select(vim.tbl_keys(commands), {
		prompt = "Select a debug adapter to run",
	}, function(item)
		if item == nil then
			return
		end
		local func = commands[item]
		require("notify")("Running " .. item, "info", {
			title = "DAP",
		})
		func()
	end)
end

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
					local commands = {
						go = dap_go.debug_test,
					}

					vim.keymap.set("n", "<Leader>db", function()
						dap_select(commands)
					end, { desc = "Dap: Select a debug adapter" })
				end,
			},
			{
				"mfussenegger/nvim-dap-python",
				config = function()
					local dap_python = require("dap-python")
					dap_python.setup("/home/dillon/.virtualenvs/debugpy/bin/python")
					local commands = {
						["python - test method"] = dap_python.test_method,
						["python - test class"] = dap_python.test_class,
						["python - debug selection"] = dap_python.debug_selection,
					}

					vim.keymap.set("n", "<Leader>db", function()
						dap_select(commands)
					end, { desc = "Dap: Select a debug adapter" })
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
