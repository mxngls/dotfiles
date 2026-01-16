-- plugins
require("plugin/conform")
require("plugin/dirvish")
require("plugin/mason")
require("plugin/nvim-cmp")
require("plugin/nvim-lsp")
require("plugin/nvim-treesitter")
require("plugin/nvim-treesitter-context")
require("plugin/telescope")

local ts_autotag = require("ts-autotag")
local pqf = require("pqf")

ts_autotag.setup()
pqf.setup()

-- plugins (written in Vimscript)
require("plugin/fugitive")
