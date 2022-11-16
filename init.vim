set nocompatible " disable compatibility to old-time vi
let mapleader = "\<Space>"

" =============================================================================
" # Editor
" =============================================================================

" Misc
set hidden
set nojoinspaces
set autoindent
set timeoutlen=300
set encoding=utf-8
set scrolloff=10

" Sane splits
set splitright
set splitbelow

" Decent wildmenu
set wildmenu
set wildmode=list:longest

" Use wide tabs
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab
set expandtab
 
" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase

" =============================================================================
" # PLUGINS
" =============================================================================
call plug#begin()

" GUI
Plug 'nvim-lualine/lualine.nvim'
Plug 'machakann/vim-highlightedyank'

" Theme and icons
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'

" More highlighting
Plug 'sheerun/vim-polyglot'

" File and folder view
Plug 'nvim-tree/nvim-tree.lua'
 
" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html']}
 
" Language Support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}

" Syntactic language support
Plug 'fatih/vim-go'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'
	
call plug#end()

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
set relativenumber " Relative line numbers
set number " Also show current absolute line

lua << END
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), 
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }),
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    :}, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<typescript>'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['<javascript>'].setup {
    capabilities = capabilities
  }
END

" =============================================================================
" # Plugin Settings 
" =============================================================================

" Completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" nvimtree
lua require('nvimtree_config')
let g:NERDTreeIgnore = ['^node_modules$']


" =============================================================================
" # Keyboard shortcuts
" =============================================================================
nnoremap ; :

" Simplify sourcing
nnoremap<leader>sm :source $MYVIMRC<CR> 

" So we also map Ctrl+k
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
noremap  <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

" Files
" Open new file adjacent to currnt file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" Buffers
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
nnoremap <Leader>w :w<CR>

" Toggle file tree
nnoremap <leader>n :NvimTreeToggle<CR>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Move by line
nnoremap j gj
nnoremap k gk


" =============================================================================
" # Misc
" =============================================================================

" Jump to last edit position on opening file
" https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim#L489
if has("autocmd")
" https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" Colors
if !has('gui_running')
  set t_Co=256
endif
set background=dark
let g:gruvbox_contrast_dark = 'hard' 
colorscheme gruvbox
syntax on
hi Normal ctermbg=NONE
