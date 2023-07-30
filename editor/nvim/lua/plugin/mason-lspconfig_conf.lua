local lsp_servers = require("..lsp_servers")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers
})

