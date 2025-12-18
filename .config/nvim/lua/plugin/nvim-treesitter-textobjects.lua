-- configuration
require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		include_surrounding_whitespace = true,
	},
	move = {
		set_jumps = true,
	},
})

-- keymaps for select
vim.keymap.set({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "aco", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ico", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "al", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "il", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "aa", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@assignment.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@assignment.inner", "textobjects")
end)
