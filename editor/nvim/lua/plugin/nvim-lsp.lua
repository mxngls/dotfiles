-- Setup language servers.
local lspconfig = require('lspconfig')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(config_opts)
    -- Global config
    vim.diagnostic.config({
      severity_sort = true,
      virtual_text = false,
      float = {
        source = true
      }
    })

    -- Global mappings.
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>v', vim.diagnostic.setloclist)

    -- Buffer local mappings.
    local opts = { buffer = config_opts.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>fp', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup completion
require 'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- Setup the language servers
local lsp_servers = require('mason-lspconfig').get_installed_servers()
for _, language_server in ipairs(lsp_servers) do
  lspconfig[language_server].setup({
    capabilities = capabilities,
  })
end

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Neovim uses LuaJIT. See h: lua-luajit
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Recognize the Neovim specific 'vim' lua module
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('*', true),
      },
      telemetry = {
        -- We value our privacy
        enable = false,
      },
    },
  },
}
