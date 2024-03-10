return {
	{
		"mfussenegger/nvim-dap",
		ft = { "python", "go" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap, dapui, dap_virtual_text = require("dap"), require("dapui"), require("nvim-dap-virtual-text")

			-- Setup
			dapui.setup()
			dap_virtual_text.setup({})

			-- Configuration
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- For selecting DAP adapter with one keybind
			function Dap_select(commands)
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

			-- Keymaps
			vim.keymap.set("n", "<Leader>df", dapui.toggle, { desc = "Dap: Toggle DAP ui" })
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = { "go" },
		config = function()
			local dap_go = require("dap-go")
			dap_go.setup()
			local commands = {
				go = dap_go.debug_test,
			}

			vim.keymap.set("n", "<Leader>db", function()
				Dap_select(commands)
			end, { desc = "Dap: Select a debug adapter" })
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = { "python" },
		config = function()
			local dap_python = require("dap-python")
			dap_python.setup("/home/dillon/.virtualenvs/debugpy/bin/python")
			local commands = {
				["python - test method"] = dap_python.test_method,
				["python - test class"] = dap_python.test_class,
				["python - debug selection"] = dap_python.debug_selection,
			}

			vim.keymap.set("n", "<Leader>db", function()
				Dap_select(commands)
			end, { desc = "Dap: Select a debug adapter" })
		end,
	},
}
