-- make saving and leaving a buffer more pleasant
vim.keymap.set("n", "<leader>w", ":w<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>nw", ":noa w<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":q<cr>", { noremap = true, silent = true })

-- moving _between_ lines
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })

-- moving _in_ lines
vim.keymap.set("", "H", "^", { noremap = false, silent = true })
vim.keymap.set("", "L", "$", { noremap = false, silent = true })

-- switch windows
vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { noremap = true, silent = true })

-- create a new buffer in the current dir
vim.keymap.set("n", "<leader>o", ":e <c-r>=expand('%:p:h') . '/'<cr>", { noremap = true, silent = false })

-- folds _can_ be useful
vim.keymap.set("n", "<leader>fm", function()
	vim.o.foldmethod = vim.o.foldmethod == "indent" and "manual" or "indent"
end, { noremap = true, silent = false })

-- terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<leader>t", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)

-- copy path of current buffer to clipboard
vim.keymap.set("n", "<leader>cp", function()
	local full_path = vim.fn.expand("%:p")
	vim.fn.setreg("+", full_path)
	print("Copied: " .. full_path)
end, { noremap = true, silent = true, desc = "Copy full path of current buffer" })

-- misc
vim.keymap.set("n", "<leader>s", ":s/<c-r><c-w>//g<left><left>", { noremap = true, silent = false })
