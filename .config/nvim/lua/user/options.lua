-- more responsive
vim.o.timeoutlen = 300
vim.o.updatetime = 300

-- personal preference
vim.o.swapfile = false
vim.o.confirm = true
vim.o.clipboard = "unnamed"

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = false

vim.o.inccommand = "split"

vim.o.foldenable = false
vim.o.foldmethod = "indent"

vim.opt.diffopt:append({ "iwhite" })

-- new buffers
vim.o.splitbelow = true
vim.o.splitright = true

-- ui
vim.o.termguicolors = false

vim.o.textwidth = 100
vim.o.wrap = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "100"
vim.o.cursorline = true

vim.o.pumheight = 12
vim.o.wildignorecase = true
vim.o.completeopt = 'menu,noselect'

vim.opt.fillchars = {
	diff = " ",
}
