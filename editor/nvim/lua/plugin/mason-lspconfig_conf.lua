require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'lua_ls',
    'pyright',
    'sqlls',
    'tailwindcss',
    'tsserver',
    'vimls',
  }
})
