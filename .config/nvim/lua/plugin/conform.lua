require("conform").setup({
	formatters = {
		prettier = {
			require_cwd = false,
			---@diagnostic disable-next-line: param-type-mismatch
			prepend_args = function()
				local textwidth = vim.bo.textwidth ~= 0 and vim.bo.textwidth or vim.o.textwidth
				local args = {
					"--print-width",
					tostring(textwidth),
					"--tab-width",
					tostring(vim.bo.tabstop),
					"--use-tabs",
					tostring(not vim.bo.expandtab),
				}
				return args
			end,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		c = { "clang-format" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
