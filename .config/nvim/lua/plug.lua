local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- html
Plug("tronikelis/ts-autotag.nvim")

-- java
Plug("mfussenegger/nvim-jdtls")
Plug("mfussenegger/nvim-lint")

-- DB
Plug("tpope/vim-dadbod")
Plug("kristijanhusak/vim-dadbod-ui")

-- tests
Plug("vim-test/vim-test")

-- git
Plug("tpope/vim-fugitive")

-- misc
Plug("tpope/vim-surround")
Plug("tpope/vim-unimpaired")

-- file explorer
Plug("justinmk/vim-dirvish")

-- undo list visualizier
Plug("mbbill/undotree")

-- ui
Plug("romainl/vim-cool")
Plug("sainnhe/sonokai")
Plug("yorickpeterse/nvim-pqf")

-- language server protocol
Plug("williamboman/mason.nvim")
Plug("neovim/nvim-lspconfig")

-- replace terminal multiplexers
Plug("samjwill/nvim-unception")

-- telescope
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-telescope/telescope-fzy-native.nvim")

-- treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/nvim-treesitter-textobjects", { ["branch"] = "main" })
Plug("nvim-treesitter/nvim-treesitter-context")

-- autocompletion
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lua")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")

-- formatting
Plug("stevearc/conform.nvim")

vim.call("plug#end")
