local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("tpope/vim-fugitive")     -- Git

Plug("folke/persistence.nvim") -- improving Vim
Plug("justinmk/vim-dirvish")
Plug("mbbill/undotree")
Plug("romainl/vim-cool")
Plug("samjwill/nvim-unception")
Plug("tpope/vim-surround")
Plug("tpope/vim-unimpaired")
Plug("tronikelis/ts-autotag.nvim")
Plug("yorickpeterse/nvim-pqf")

Plug(vim.fn.expand("~/dev/rustdoc.nvim")) -- colorscheme
Plug(vim.fn.expand("~/dev/simple"))

Plug("williamboman/mason.nvim") -- LSP
Plug("neovim/nvim-lspconfig")

Plug("nvim-lua/plenary.nvim") -- Telescope
Plug("nvim-telescope/telescope.nvim")

-- Treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["branch"] = "main", ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/nvim-treesitter-textobjects", { ["branch"] = "main" })
Plug("nvim-treesitter/nvim-treesitter-context")

Plug("hrsh7th/nvim-cmp") -- autocompletion
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lua")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")

Plug("stevearc/conform.nvim") -- formatting

vim.call("plug#end")
