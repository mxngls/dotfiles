vim.bo.textwidth = 120

vim.wo.conceallevel = 1
vim.wo.foldmethod = "syntax"
vim.api.nvim_set_hl(0, "Conceal", {})

vim.fn.matchadd("Conceal", "\\(href\\|src\\|cite\\)=[\"']\\zs.\\{-\\}\\ze[\"']", 10, -1, { conceal = "X" })
