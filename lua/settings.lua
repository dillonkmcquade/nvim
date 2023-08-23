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
--vim.opt.autochdir = true
--vim.g.netrw_banner = 0
vim.g.closetag_filenames = "*.html, *.xml, *.jsx, *.tsx, *.js"
vim.g.netrw_liststyle = 0
-- vim.opt.colorcolumn = "80"
--vim.g.netrw_keepdir = 0
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	command = "setlocal shiftwidth=4 tabstop=4",
})
