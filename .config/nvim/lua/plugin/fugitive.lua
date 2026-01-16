local function FugitiveGitUI()
	vim.cmd.tabnew()
	vim.cmd.Git()
	vim.cmd.only()

	local git_root = vim.fn.FugitiveWorkTree()
	local repo_name = vim.fn.fnamemodify(git_root, ":t")
	local tab_title = "Git:" .. " " .. repo_name

	vim.api.nvim_buf_set_name(0, tab_title)
end

vim.keymap.set("n", "<leader>G", FugitiveGitUI, { noremap = true, silent = true })
