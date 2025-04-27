-- make saving and leaving a buffer more pleasant
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nw', ':noa w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

-- moving _between_ lines
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })

-- moving _in_ lines
vim.keymap.set('n', 'hh', '^', { noremap = true, silent = true })
vim.keymap.set('n', 'll', '$', { noremap = true, silent = true })

-- switch windows
vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true, silent = true })

-- create a new buffer in the current dir
vim.keymap.set('n', '<leader>o', ':e <c-r>=expand(\'%:p:h\') . \'/\'<cr>', { noremap = true, silent = false })

-- terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<leader>t", function()
	vim.cmd.new()
	vim.cmd.wincmd "J"
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)
