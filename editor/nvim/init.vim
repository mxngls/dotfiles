" Name:     Custom
" Author:   Maximilian Engels <maximilian.e.hoenig@gmail.com>
" URL:      http://mxngls.github.io

" Set the background to match our terminal
function! SetBackground() abort "{{{
  let l:bg = system("defaults read -g AppleInterfaceStyle")
  if l:bg isnot v:null && trim(l:bg) == 'Dark'
    set background=dark
  else
    set background=light
  endif
endfunction
" }}}
call SetBackground()

" Basic editor settings {{{

set nocompatible                " Disable compatibility with vi
let mapleader="\<Space>"        " Use Space key as the map leader
set ttyfast                     " Improve redraw speed for terminals
set syntax=on                   " Enable syntax highlighting
set timeoutlen=300              " Set timeout length to 300ms
set updatetime=300              " Trigger the CursorHold autocomommand event
set noswapfile                  " Disable swap files
set confirm                     " Confirm before overwriting a file
set autoread                    " Automatically read a file when it changes
set path+=**                    " Recursively traverse directories
set clipboard=unnamed           " Use the system clipboard
set undofile

set backspace=indent,eol,start  " Allow backspacing over everything
set matchpairs+=<:>             " Additional characters for matchpairs
set spellsuggest=10,best        " Limit the size of spelling suggestions

set switchbuf=uselast           " Reuse windows if possible
set splitbelow                  " Open split below the current window
set splitright                  " Open split to the right of the current window

set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set signcolumn=yes
set colorcolumn=72              " Limit the visual available width to 72 characters
set textwidth=72                " And do the same practically as well
set nowrap                      " We don't want to wrap text
set pumheight=10                " Don't make the completion window too heigh
set cursorline
set cursorlineopt=screenline,number

set wildmenu                    " Enable command-line completion menu
set wildmode=longest:full       " Complete longest match, list other matches in wildmenu
set wildignorecase              " Case is ignored when completing file names and directories
set wildoptions=pum             " Show pop-up menu
set completeopt=menu,noselect   " Enable enhanced completion menu

set hlsearch                    " Set search highlighting
set incsearch                   " Enable incremental searching
set ignorecase                  " Ignore case when searching
set smartcase                   " Search case-sensetive in certain cases

set expandtab                   " Use spaces instead of tabs
set tabstop=4                   " Number of spaces for each tab
set shiftwidth=4                " Number of spaces to use for autoindenting
set softtabstop=4               " Number of spaces for backspace and <Tab>
set smarttab                    " Insert tabs on indents, spaces on alignment
set smartindent                 " Enable smart indenting

set foldmethod=indent           " Use indent-based folding
set foldlevelstart=0            " Set the initial folding level to 0
set foldnestmax=10              " Limit the maximum nested folds to 10
set nofoldenable                " Disable folding by default

set  laststatus=2                 " Always show the status line
setl statusline=%!statusline#SetStatus()

filetype plugin indent on       " Detect filetype and load options

" }}}
" Better safe than sorry {{{

" Create a vim directory
if !isdirectory($HOME.'/.vim')
  call mkdir($HOME.'/.vim', 'p', 0770)
endif

" Create a undo directory if it doesn't exist yet
" Unfortunately the type of the undofiles for Neovim
" and Vim are not compatible anymore
if has('nvim')
  if !isdirectory($HOME.'/.config/nvim/undo-dir')
    call mkdir($HOME.'/.config/nvim/undo-dir', 'p', 0700)
  endif
  set undodir=~/.config/nvim/undo-dir
else
  if !isdirectory($HOME.'/.vim/undo-dir')
    call mkdir($HOME.'/.vim/undo-dir', 'p', 0700)
  endif
  set undodir=~/.vim/undo-dir
endif


" }}}
" {{{ Colors

" {{{ Functions

" Set the colorscheme
function! SetColors() "{{{
  if &t_Co < 256
    colorscheme default
  else
    set termguicolors
    colorscheme default
  endif
endfunction
"}}}

" Custom grep
function! CGrep(...) abort "{{{
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
"}}}

" Keymaps {{{1

" Make leaving and saving more more pleasent
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
nmap <leader>nw : noa w<CR>
nmap <leader>q :q<CR>

" Instead of visual we want line movement
nnoremap j gj
nnoremap k gk

" Bring sanity to the command line
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Always center
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Delete and immediately throw away
nnoremap <leader>d "_d
nnoremap <leader>d "_d
vnoremap <leader>d "_D
vnoremap <leader>D "_D

" Easier navigate between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader><leader> <c-w><c-p><CR>

" Resizing
nnoremap <S-Up> :res +5<CR>
nnoremap <S-Down> :res -5<CR>
nnoremap <S-Left> :vertical res +5<CR>
nnoremap <S-Right> :vertical res -5<CR>

" Create a new file in the current directory
nnoremap <leader>o :e <C-R>=expand('%:p:h') . '/'<CR>

" Easily source our vimrc
nnoremap <leader>so :so $MYVIMRC<CR>

" Jump back to where we were
nnoremap <leader>cc  :cclose<CR>
nnoremap <leader>lc  :lclose<CR>
nnoremap <leader>r   :execute "normal 'Q" <Bar> 
      \ call setcursorcharpos(g:saved_pos[1],g:saved_pos[2]) <Bar> 
      \ delmarks Q <Bar> 
      \ lclose <Bar>
      \ execute "normal zz" <CR>

" Toggle folds
nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fs :set foldmethod=syntax<CR>
nnoremap <leader>fn :call CountFolds()<CR>

" So annoying...
nnoremap q: :q

" Custom functions
nnoremap <leader>gr :Grep 
map gr :Grep <C-r><C-w><CR>

" @ is just too far
nnoremap <C-m> @

" make
nnoremap <leader>ma :!make <CR>

" These as well
map H ^
map L $

" Buffers
nnoremap <leader>ls :ls<CR>:b<Space>
nnoremap <leader>bd :ls<CR>:bd<Space>

" Sessions
nnoremap <leader>ms :execute "mks! " . trim(system('realpath $(dirname "$(git rev-parse --git-dir 2>/dev/null)")')) . '/.vim-session'<CR>

" Insert a HTML tag
inoremap <C-t> <C-o>b<C-o>diw<<C-r>"></<C-r>"><C-o>T>

" Terminal mode
tnoremap <C-w>n <C-\><C-n>

" Plugin related {{{2

" Fugitive
nnoremap <leader>gg :Git<CR>

" Dirvish
nnoremap <leader>L  :call ExplorerSplit()<CR>

" }}}

" }}}
" Plugins {{{
call plug#begin()

" Git
Plug 'tpope/vim-fugitive'

" Misc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" File explorer
Plug 'justinmk/vim-dirvish'

" Fuzzy finding
Plug 'ctrlpvim/ctrlp.vim'

" Undo list visualizier
Plug 'mbbill/undotree'

" TUI
Plug 'romainl/vim-cool'

" Neovim specific plugins {{{2

if has('nvim')

  " Language server protocol
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Autocompletion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/vim-vsnip'

endif

" }}}

call plug#end()

" }}}
" Autocommands {{{

" Immediately go to the last curor position
augroup restore_cursor
  autocmd!
  autocmd BufRead *
    \ let s:line = line("'\"")
    \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \ |   execute "normal! g`\""
    \ | endif
augroup END

" Conflicts with Ctrl-P's default mapping
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
augroup END

" }}}
" {{{ Customize Commands

" Grepping stuff
command! -nargs=+ -complete=file -bar Grep
      \ lgetexpr CGrep(<f-args>) <Bar>
      \ lopen <Bar>
      \ ll

" }}}
" Plugin Settings {{{

" Dirvish / Netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

call SetColors()

" }}}
" {{{ NVIM

if has('nvim')
  :lua require('init')
endif

" }}}
