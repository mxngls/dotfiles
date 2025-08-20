-- go to the last cursor position
vim.api.nvim_create_augroup("restore_cursor", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
	group = "restore_cursor",
	callback = function()
		local line = vim.fn.line("'\"")
		local last_line = vim.fn.line("$")
		local filetype = vim.bo.filetype

		if
			line >= 1
			and line <= last_line
			and filetype ~= "commit"
			and filetype ~= "xxd"
			and filetype ~= "gitrebase"
		then
			vim.cmd('normal! g`"')
		end
	end,
})

-- let's keep things concise
vim.api.nvim_create_augroup("text_files", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text", "markdown", "gitcommit", "mail" },
	group = "text_files",
	callback = function()
		vim.bo.textwidth = 72
		vim.wo.colorcolumn = "72"

		vim.wo.spell = true
		vim.bo.spelllang = "en_us"
	end,
})

-- show us what we yanked
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})
