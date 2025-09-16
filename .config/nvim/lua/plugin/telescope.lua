local telescope = require("telescope")
local builtin = require("telescope.builtin")

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

telescope.load_extension("fzy_native")

-- keybindings using the Lua API
vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fq", builtin.quickfix, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fd", function()
	vim.cmd('vsplit')
	vim.lsp.buf.definition()
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { noremap = true, silent = true })

-- autocommands
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	group = vim.api.nvim_create_augroup("UserTelescopeConfig", {}),
	callback = function()
		vim.wo.number = true
	end,
})
