vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.wrap = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.swapfile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.g.closetag_filenames = "*.html, *.xml, *.jsx, *.tsx, *.js"
vim.g.netrw_liststyle = 0
--vim.opt.autochdir = true
--vim.g.netrw_banner = 0
-- vim.opt.colorcolumn = "80"
--vim.g.netrw_keepdir = 0
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	command = "setlocal shiftwidth=4 tabstop=4",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local nmap = function(keys, action, desc)
			if desc then
				desc = "LSP: " .. desc
			end
			vim.keymap.set("n", keys, action, { buffer = ev.buf, remap = false, desc = desc })
		end
		nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		nmap("<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
		nmap("<leader>vd", vim.diagnostic.open_float, "Open float")
		nmap("<leader>pr", vim.lsp.buf.format, "Format")
		nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
		nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
		nmap("<leader>vca", vim.lsp.buf.code_action, "code actions")
		nmap("<leader>vrr", vim.lsp.buf.references, "Open references")
		nmap("<leader>vrn", vim.lsp.buf.rename, "Rename")
		nmap("<leader>D", vim.lsp.buf.type_definition, "Type definition")
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, { buffer = ev.buf, remap = false, desc = "Signature help" })
	end,
})
