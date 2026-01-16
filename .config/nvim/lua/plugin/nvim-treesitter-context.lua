local ts_context = require("treesitter-context")

ts_context.setup({
	multiwindow = true,
	max_lines = 2,
	multiline_threshold = 1,
	trim_scope = "inner",
})

-- Jump to context
vim.keymap.set("n", "<leader>c", function()
	ts_context.go_to_context(vim.v.count1)
end, { silent = true })
