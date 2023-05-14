" Basic editor settings {{{1

let mapleader="\<Space>" 
set mouse=a
set timeout
set timeoutlen=400
set backspace=indent,eol,start
set confirm
set showmatch
set ttyfast
set noshowmode
set shortmess+=I

set splitbelow
set splitright

set syntax=on
set spelllang=en_us

set number
set relativenumber
set scrolloff=10
set pumheight=10

set noswapfile
set clipboard="unnamedplus"
set wildmode=longest,list
set wildmenu
set completeopt="menuone,noinsert,noselect"

" Statusline {{{2

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set laststatus=2
set statusline=
set statusline+=\ \
set statusline+=%{toupper(g:currentmode[mode()])}\
set statusline+=%{expand('%:p:h:t')}/%t\
set statusline+=%{&modified?'[+]\ ':''}
set statusline+=%{&readonly?'[RO]\ ':''}
set statusline+=\ %{FugitiveStatusline()}
set statusline+=%h%r\ \
set statusline+=%=
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}\ \
set statusline+=%p%%\
set statusline+=%12([%l:%02v/%L]%)\ \

" }}}

" Searching {{{2

set nohlsearch"{{{}}}
set incsearch
set ignorecase
set smartcase
set gdefault

" }}}

" Better safe than sorry {{{

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "p", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "p", 0700)
set undodir=~/.vim/undodir
endi
set undodir=~/.vim/undo-dir
set undofile

" }}}

" Indentiation and folding {{{

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set wrap

set smartindent
set foldmethod=indent
set foldcolumn=auto
set foldlevelstart=10   
set foldnestmax=10
set nofoldenable

" }}}

" {{{ Functions

function! s:ShowCurrentHunk() abort
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction

function! CountFolds()
  let count = 0
  let level = 1
  let current_line = 1
  let last_line = line("$")
  while current_line <= last_line
    if foldlevel(current_line) == level && foldclosedend(current_line) != -1
      let count += 1
      let current_line = foldclosedend(current_line) + 1
    else
      let current_line += 1
    endif
  endwhile
  echo "Active folds: " . count
endfunction

function! PatchColors()
  hi VertSplit ctermfg=250
  hi Visual ctermbg=NONE ctermbg=LightYellow
  hi Folded ctermbg=92 guibg=92
  hi FoldColumn ctermbg=92 guibg=92
  hi SignColumn ctermbg=234
  hi StatusLine cterm=bold ctermfg=245 ctermbg=235
  hi StatusLineNC cterm=bold ctermfg=245 ctermbg=235
  hi FloatBorder  guibg=NONE ctermbg=NONE 
  hi NormalFloat guibg=NONE ctermbg=NONE
  hi Float guibg=NONE ctermbg=NONE
endfunction

function! SetColors()
  if has('gui_running')
    autocmd vimenter * ++nested colorscheme solarized8
    colorscheme solarized8
  elseif &t_Co < 256
    colorscheme default
    set nocursorline
  else
    set termguicolors
    autocmd vimenter * ++nested colorscheme solarized8
    call PatchColors()
  endif
endfunction

" }}}

" Colors {{{

call PatchColors()
call SetColors()

nmap <leader>ct :call jobstart('$HOME/dotfiles/shell/toggle_theme.sh -t')<CR>

" }}}

" }}}

" Keymaps {{{1

nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
nmap <leader>q :q<CR>

nmap <leader>jj <ESC>
vmap <leader>jj <ESC>
imap <leader>jj <ESC>

nnoremap j gj
nnoremap k gk

noremap <C-z> <C-a>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

map H ^
map L $

nmap <leader>d "_d
vmap <leader>d "_d

nmap <leader>y "+y
nmap <leader>d "+d
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

nnoremap <leader>h :wincmd h <CR> 
nnoremap <leader>j :wincmd j <CR> 
nnoremap <leader>k :wincmd k <CR> 
nnoremap <leader>l :wincmd l <CR> 
nnoremap <leader><leader> <c-w><c-p><CR>

nnoremap <M-Up> :res +5<CR>
nnoremap <M-Down> :res -5<CR>
nnoremap <M-Left> :vertical res +5<CR>
nnoremap <M-Right> :vertical res -5<CR>

map <C-n> :cn<CR>zz
map <C-p> :cp<CR>zz
map <C-n> :lne<CR>zz
map <C-p> :lpe<CR>zz

nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/"<CR>
nnoremap <leader>so :so $MYVIMRC<CR>

"inoremap " ""<left>
"onoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

nnoremap <C-n> :cnext<CR>zz
nnoremap <C-p> :cprevious<CR>zz
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :cclose<CR>

nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fn :call CountFolds()<CR>

nnoremap Q <nop>

" Plugin related {{{2

nnoremap <leader>gg :Git<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle%<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

nnoremap <leader>fc :FormatCode<CR>
vnoremap <leader>fl :FormatLines<CR>

nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

nnoremap <leader>gd :SignifyHunkDiff<CR>
nnoremap <leader>gn <plug>(signify-next-hunk)
nnoremap <leader>gp <plug>(signify-prev-hunk)
nnoremap <leader>gN 9999<plug>(signify-next-hunk)
nnoremap <leader>gP 9999<plug>(signify-prev-hunk)

" }}}

" }}}

" Plugins {{{

call plug#begin()

" Colorschemes & Statusline
Plug 'Mofiqul/vscode.nvim'
Plug 'lifepillar/vim-solarized8'

" File and folder view
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git 
" Plug 'airblade/vim-gitgutter' 
Plug 'mhinz/vim-signify'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'

" Formatting
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'ElPiloto/luaformatterfiveone'

" NEOVIM specific plugins {{{2

if has('nvim')

  " Language server protocol
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  
  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  
  " Autocompletion
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  Plug 'windwp/nvim-ts-autotag'
  Plug 'windwp/nvim-autopairs'
  
  " Search
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

endif

" }}}

call plug#end()

" }}}

" Autocommands {{{

autocmd VimEnter * so $MYVIMRC

autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup autoformat_settings
  autocmd FileType html,css,sass,scss,less AutoFormatBuffer prettier
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,vue,json AutoFormatBuffer prettier
  autocmd FileType python AutoFormatBuffer yapf
  autocmd Filetype lua AutoFormatBuffer luaformatterfiveone
augroup END

augroup help
  autocmd!
  autocmd FileType help wincmd L
augroup END

augroup singify
  autocmd!
  autocmd User SignifyHunk call s:ShowCurrentHunk()
augroup END

" }}}

" Plugin Settings {{{

let g:NERDTreeShowLineNumbers=1
autocmd BufEnter NERD_* setlocal rnu

call glaive#Install()
Glaive codefmt luaformatterfiveone_executable='/Users/Max/.luarocks/bin/luaformatterfiveone'
Glaive codefmt prettier_options=`['--tab-width=2']`

" }}}

if has('nvim')
  :lua require("init")
endif
