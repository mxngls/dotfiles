---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter").setup({
	-- A list of parser names, or 'all' (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
