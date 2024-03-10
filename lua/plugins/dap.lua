return {
	{
		"mfussenegger/nvim-dap",
		ft = { "python", "go" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",

			--  Adapter configuration for specific languages
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap, dapui, dap_python, dap_go, dap_virtual_text =
				require("dap"),
				require("dapui"),
				require("dap-python"),
				require("dap-go"),
				require("nvim-dap-virtual-text")

			-- Setup
			dap_python.setup("~/.virtualenvs/debugpy/bin/python")
			dap_go.setup()
			dapui.setup()
			dap_virtual_text.setup({})

			-- Configuration

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
			local function dap_select()
				local commands = {
					["python - test method"] = dap_python.test_method,
					["python - test class"] = dap_python.test_class,
					["python - debug selection"] = dap_python.debug_selection,
					go = dap_go.debug_test,
				}

				vim.ui.select(vim.tbl_keys(commands), {
					prompt = "Select a debug adapter to run",
				}, function(item)
					if item == nil then
						return
					end
					local func = commands[item]
					func()
				end)
			end

			-- Keymaps
			vim.keymap.set("n", "<Leader>df", dapui.toggle, { desc = "Dap: Toggle DAP ui" })
			vim.keymap.set("n", "<Leader>db", dap_select, { desc = "Dap: Select a debug adapter" })
		end,
	},
}
