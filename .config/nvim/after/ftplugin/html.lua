vim.bo.textwidth = 120

vim.wo.conceallevel = 1
vim.wo.foldmethod = "syntax"
vim.api.nvim_set_hl(0, "Conceal", {})

-- vim.api.nvim_create_autocmd({ "BufLeave", "FileType" }, {
-- 	buffer = 0,
-- 	callback = function()
-- 		vim.fn.clearmatches()
-- 		-- Reset the Conceal highlight group to its original state
-- 		vim.api.nvim_set_hl(0, "Conceal", original_conceal)
-- 	end,
-- })

vim.fn.matchadd("Conceal", "\\(href\\|src\\|cite\\)=[\"']\\zs.\\{-\\}\\ze[\"']", 10, -1, { conceal = "X" })
