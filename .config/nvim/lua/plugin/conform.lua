require("conform").setup({
	formatters = {
		prettier = {
			prepend_args = function()
				return {
					"--print-width", vim.o.textwidth,
					"--tab-width", vim.o.tabstop,
					"--use-tabs", vim.o.expandtab and "false" or "true",
				}
			end,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		htm = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		c = { "clang-format" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})
