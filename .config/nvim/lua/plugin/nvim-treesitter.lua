---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or 'all' (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",

				["ac"] = "@class.outer",
				["ic"] = "@class.inner",

				["aco"] = "@conditional.outer",
				["ico"] = "@conditional.inner",

				["al"] = "@loop.outer",
				["il"] = "@loop.inner",

				["ca"] = "@call.outer",
				["ci"] = "@call.inner",
			},
			include_surrounding_whitespace = true,
		},
	},
})
