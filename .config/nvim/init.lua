-- set before anything else
vim.g.mapleader = ' '

-- config
require 'user.autocommands'
require 'user.options'
require 'user.keymaps'

-- plugins
require 'plug'
require 'plugin'

vim.cmd.colorscheme('sonokai')
