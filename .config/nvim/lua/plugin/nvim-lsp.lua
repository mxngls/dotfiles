-- Setup language servers.
local lspconfig = require("lspconfig")

-- Global diagnostic config
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = true,
	float = {
		source = true,
	},
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(config_opts)
		-- Global mappings.
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "<leader>v", vim.diagnostic.setqflist)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = 1 })
		end)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end)

		-- Buffer local mappings.
		local opts = { buffer = config_opts.buf }
		vim.keymap.set("n", "<leader>fp", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, opts)
	end,
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Server setup --------------------------------------------------------

lspconfig.bashls.setup({
	capabilities = capabilities,
})

lspconfig.clangd.setup({
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	settings = {
		workingDirectories = { mode = "auto" },
	},
})

lspconfig.html.setup({
	capabilities = capabilities,
	init_options = {
		provideFormatter = false,
	},
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	settings = {
		html = {
			format = {
				unformatted = "pre",
			},
		},
	},
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true,
			check = {
				command = "clippy",
				extraArgs = {
					"--",
					"-W",
					"clippy::pedantic",
					"-W",
					"clippy::nursery",
					"-A",
					"clippy::missing_errors_doc",
				},
			},
		},
	},
})
