require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'cssls',
    'html',
    'lua_ls',
    'marksman',
    'pyright',
    'sqlls',
    'tailwindcss',
    'tsserver',
    'vimls',
  }
})
