-- Setup language servers.
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

vim.lsp.config("bashls", {
	capabilities = capabilities,
})
vim.lsp.enable("bashls")

vim.lsp.config("clangd", {
	capabilities = capabilities,
})
vim.lsp.enable("clangd")

vim.lsp.config("lua_ls", {
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
vim.lsp.enable("lua_ls")

vim.lsp.config("ts_ls", {
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

vim.lsp.enable("ts_ls")

vim.lsp.config("eslint", {
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
vim.lsp.enable("eslint")

vim.lsp.config("html", {
	capabilities = capabilities,
	init_options = {
		provideFormatter = false,
	},
})
vim.lsp.enable("html")

vim.lsp.config("cssls", {
	capabilities = capabilities,
})
vim.lsp.enable("cssls")

vim.lsp.config("rust_analyzer", {
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
vim.lsp.enable("rust_analyzer")
