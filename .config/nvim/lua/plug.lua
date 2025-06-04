local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- git
Plug("tpope/vim-fugitive")

-- Misc
Plug("tpope/vim-surround")
Plug("tpope/vim-unimpaired")

-- file explorer
Plug("justinmk/vim-dirvish")

-- undo list visualizier
Plug("mbbill/undotree")

-- ui
Plug("romainl/vim-cool")
Plug("sainnhe/sonokai")

-- Language server protocol
Plug("williamboman/mason.nvim")
Plug("neovim/nvim-lspconfig")

-- Replace terminal multiplexers
Plug("samjwill/nvim-unception")

-- Telescope
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })
Plug("nvim-telescope/telescope-fzy-native.nvim")

-- Treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/nvim-treesitter-textobjects")

-- Autocompletion
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lua")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")

-- Formatting
Plug("stevearc/conform.nvim")

vim.call("plug#end")
