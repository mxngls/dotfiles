local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		live_grep = {
			hidden = true,
		},
	},
})

-- load extensions
telescope.load_extension("fzy_native")

-- keybindings
vim.keymap.set("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fw", ":Telescope lsp_workspace_symbols<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { noremap = true, silent = true })
