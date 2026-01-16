local textobjects = require("nvim-treesitter-textobjects")
local select = require("nvim-treesitter-textobjects.select")

textobjects.setup({
	select = {
		lookahead = true,
		include_surrounding_whitespace = true,
	},
	move = {
		set_jumps = true,
	},
})

-- Helper function to create text object keymaps
local function map_textobject(lhs, query)
	vim.keymap.set({ "x", "o" }, lhs, function()
		select.select_textobject(query, "textobjects")
	end)
end

-- Text object keymaps
local keymaps_to_textobjects = {
	{ "af",  "@function.outer" },
	{ "if",  "@function.inner" },
	{ "ac",  "@class.outer" },
	{ "ic",  "@class.inner" },
	{ "aco", "@conditional.outer" },
	{ "ico", "@conditional.inner" },
	{ "al",  "@loop.outer" },
	{ "il",  "@loop.inner" },
	{ "aa",  "@assignment.outer" },
	{ "ia",  "@assignment.inner" },
	{ "ak",  "@call.outer" },
	{ "ik",  "@call.inner" },
	{ "ab",  "@block.outer" },
	{ "ib",  "@block.inner" },
	{ "am",  "@comment.outer" },
}

for _, mapping in ipairs(keymaps_to_textobjects) do
	map_textobject(mapping[1], mapping[2])
end
