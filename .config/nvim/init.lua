-- set before anything else
vim.g.mapleader = " "

-- config
require("user.autocommands")
require("user.options")
require("user.keymaps")

-- plugins
if not vim.g.vscode then
	require("plug")
	require("plugin")
	vim.cmd.colorscheme("sonokai")
end
