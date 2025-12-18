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
	require("user.colorscheme")
else
	-- Enable key repeat for VSCode
	os.execute("defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false")
end
