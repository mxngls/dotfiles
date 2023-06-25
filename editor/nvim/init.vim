" Basic editor settings {{{

let mapleader="\<Space>"        " Use Space key as the map leader
set nocompatible                " Disable compatibility with vi
set mouse=a                     " Enable mouse support
set timeout                     " Enable timeout for mappings
set timeoutlen=300              " Set timeout length to 300ms
set backspace=indent,eol,start  " Allow backspacing over everything
set confirm                     " Confirm before overwriting a file
set showmatch                   " Show matching brackets
set ttyfast                     " Improve redraw speed for terminals
set lazyredraw                  " Delay redraw in macros and scripts
set showmode                    " Show current mode in the command line
set autoread                    " Automatically read a file when it changes
set matchpairs+=(:),[:],{:},<:> " Additional characters for matchpairs
set regexpengine=2              " Use improved regular expression engine
set switchbuf=useopen,uselast   " Reuse windows if possible
set laststatus=2                " Always show the status line
set path+=**                    " Recursively traverse directories
set splitbelow                  " Open split below the current window
set splitright                  " Open split to the right of the current window
set scrolloff=10                " Minumum number of lines to keep above/below the cursor
set syntax=on                   " Enable syntax highlighting
set spelllang=en_us             " Set the spell check language to English
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set pumheight=10                " Don't make the completion window too heigh
set noswapfile                  " Disable swap files
set clipboard=unnamedplus       " Use the system clipboard

set wildmenu                    " Enable command-line completion menu
set wildmode=longest:full       " Complete longest match, list other matches in wildmenu
set wildignorecase              " Case is ignored when completing file names and directories
set wildoptions=pum             " Show pop-up menu
set completeopt=menuone,preview,noselect " Enable enhanced completion menu

set nohlsearch                  " Clear search highlighting after completing a search
set incsearch                   " Enable incremental searching
set ignorecase                  " Ignore case when searching
set smartcase                   " Use case-sensitive search if the pattern contains an uppercase character

set expandtab                   " Use spaces instead of tabs
set tabstop=2                   " Number of spaces for each tab
set shiftwidth=2                " Number of spaces to use for autoindenting
set softtabstop=2               " Number of spaces for backspace and <Tab>
set smarttab                    " Insert tabs on indents, spaces on alignment

set smartindent                 " Enable smart indenting
set foldmethod=indent           " Use indent-based folding
set foldlevelstart=0            " Set the initial folding level to 0
set foldnestmax=10              " Limit the maximum nested folds to 10
set nofoldenable                " Disable folding by default

set statusline=%!SetStatusLine() " Set custom status line

filetype plugin on

" }}}

" Better safe than sorry {{{

if !isdirectory($HOME.'/.vim')
  call mkdir($HOME.'/.vim', 'p', 0770)
endif

if !isdirectory($HOME.'/.vim/undo-dir')
  call mkdir($HOME.'/.vim/undo-dir', 'p', 0700)
elseif !isdirectory($HOME.'/.config/nvim/undo-dir')
  call mkdir($HOME.'/.config/nvim/undo-dir', 'p', 0700)
endif

if has('nvim')
  set undodir=~/dotfiles/editor/nvim/undo-dir
else
  set undodir=~/.vim/undo-dir
endif 

set undofile

" }}}
" {{{ Cursor

if has("gui")
  echo "GUI"
  set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

" }}}

" {{{ Functions

function! s:ShowCurrentHunk() 
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction

function! CountFolds()
  let count = 0
  let current_line = 1
  let last_line = line('$')
  while current_line <= last_line
    let last_fold_line = foldclosedend(current_line)
    if  last_fold_line != -1
      let count += 1
      let current_line = last_fold_line + 1
    else
      let current_line += 1
    endif
  endwhile
  echo 'Active folds: ' . count
endfunction

function! PatchColors()
  hi Cursor guifg=#fdf6e3 guibg=#268bd2 gui=NONE cterm=NONE
  hi FloatBorder  guibg=NONE ctermbg=NONE 
  hi NormalFloat guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE ctermbg=NONE
  hi FoldColumn guibg=NONE ctermbg=NONE

  hi DiffAdd guibg=NONE ctermbg=NONE
  hi DiffChange guibg=NONE ctermbg=NONE 
  hi DiffDelete guibg=NONE ctermbg=NONE 
endfunction

function! SetBackground()
  let bg_ = system('head -n 1 ~/dotfiles/shell/kitty/current-theme.conf 2> /dev/null')
  let bg_ = substitute(bg_, '\n', '', 'g')
  if bg_ == '#DARK'
    set background=dark
  else
    set background=light
  endif
endfunction

function! SetColors()
  if has('gui_running')
    colorscheme solarized_custom
  elseif &t_Co < 256
    colorscheme default
    set nocursorline
  else
    set termguicolors
    colorscheme solarized_custom
  endif
endfunction

function! GetGitHead()
  let b:gitbranch=' '
  if &modifiable
    try
      lcd %:p:h
    catch
      return
    endtry
    let l:gitrevparse=system('git rev-parse --abbrev-ref HEAD')
    lcd -
    if l:gitrevparse!~'fatal: not a git repository'
      let b:gitbranch=substitute(l:gitrevparse, '\n', '', 'g')
    endif
  endif
endfunction

function! SetStatusLine()
  " Left aligned
  let l:stl = '   %F '
  let l:stl .= '%y%w%m%r '
  if exists('b:gitbranch')
    let l:stl .= '%{b:gitbranch}'
  endif

  " Right aligned
  let l:stl .= '%='
  let l:stl .= '%-8.(%l:%02v%)'
  let l:stl .= '%P  '
  return stl
endfunction

function ToggleExplorer()
  if &ft == "netrw"
    if exists("w:netrw_rexfile")
      if w:netrw_rexfile == "" || w:netrw_rexfile == "NetrwTreeListing"
        quit
      else
        exec 'e ' . w:netrw_rexfile
      endif
    else
      if exists("w:netrw_rexlocal") && w:netrw_rexlocal != 1
        Rexplore
      else
        quit
      endif
    endif
  else
    let @/=expand('%:t') | Explore | normal n
  endif
endfun

" }}}

" Colors {{{

call SetBackground()
call SetColors()
call PatchColors()

nmap <leader>ct :call jobstart('$HOME/dotfiles/shell/toggle_theme.sh -t')<CR>

" }}}

" Keymaps {{{1

nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
nmap <leader>nw : noa w<CR>
nmap <leader>q :q<CR>

inoremap jj <ESC>

nnoremap j gj
nnoremap k gk


cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

noremap <C-z> <C-a>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

map H ^
map L $

nnoremap <leader>d "_d
nnoremap <leader>d "_d
vnoremap <leader>d "_D
vnoremap <leader>D "_D

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j 
nnoremap <C-k> <C-w>k 
nnoremap <C-l> <C-w>l 
nnoremap <leader><leader> <c-w><c-p><CR>

nnoremap <M-Up> :res +5<CR>
nnoremap <M-Down> :res -5<CR>
nnoremap <M-Left> :vertical res +5<CR>
nnoremap <M-Right> :vertical res -5<CR>

nnoremap <leader>o :e <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <leader>so :so $MYVIMRC<CR>

nnoremap <C-n> :cnext<CR>zz
nnoremap <C-p> :cprevious<CR>zz
nnoremap <leader>cc :cclose<CR>

nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fn :call CountFolds()<CR>

nnoremap <C-m> @

nnoremap Q <nop>

" Plugin related {{{2

nnoremap <leader>gg :Git<CR>

" Fugitive
nnoremap <leader>gg :vertical Git<CR>

" Vim-codefmt
nnoremap <leader>fc :FormatCode<CR>
vnoremap <leader>fl :FormatLines<CR>

" Signify
nnoremap <leader>hd :SignifyHunkDiff<CR>
nnoremap <leader>hu :SignifyHunkUndo<CR>

" Netrw
nnoremap <leader>l  :call ToggleExplorer()<CR>
nnoremap <leader>L  :vnew \| :Ex<CR>

if has('nvim')
  " Telescop
  nnoremap <leader>ff :Telescope find_files<CR>
  nnoremap <leader>fg :Telescope live_grep<CR>
  nnoremap <leader>fb :Telescope buffers<CR>
  nnoremap <leader>fh :Telescope help_tags<CR>
endif


" }}}

" }}}

" Plugins {{{

call plug#begin()

" Git 
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Formatting
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

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

augroup save_cursor
  autocmd!
  autocmd BufReadPost * ++once
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \ exe "normal g`\"" | 
    \ let b:doopenfold = 1 | 
    \ exe "normal zz" |
    \ endif 
augroup END

augroup autoformat_settings
  autocmd!
  autocmd Filetype html,css,sass,scss,less AutoFormatBuffer prettier
  autocmd Filetype javascript,javascriptreact,typescript,typescriptreact,vue,json AutoFormatBuffer prettier
  autocmd Filetype python AutoFormatBuffer yapf
augroup END

augroup singify
  autocmd!
  autocmd User SignifyHunk call s:ShowCurrentHunk()
augroup END

augroup spell_git
  autocmd!
  autocmd Filetype gitcommit setlocal spell
  autocmd Filetype gitcommit setlocal spelllang=en_us
augroup END

augroup get_git_head 
  autocmd!
  autocmd BufAdd,BufRead * call GetGitHead()
augroup END

augroup patch
  autocmd!
  autocmd OptionSet background call PatchColors()
augroup END

augroup tmux
  autocmd!
  if exists('$TMUX')
    autocmd WinEnter,BufReadPost,FileReadPost,BufNewFile,FocusGained * call system("[[ \"$(tmux display-message -p '#W' | cut -c 1)\" != \"_\" ]] && tmux rename-window " . expand("%:t"))
    autocmd VimLeave * call system("tmux set-window-option automatic-rename")
  endif
augroup END

autocmd VimEnter * so $MYVIMRC
augroup netrw
  autocmd!
  autocmd Filetype netrw nmap <buffer> <C-l> :wincmd l<CR>
  autocmd Filetype netrw nmap <buffer> l <CR>
augroup END

" }}}

" Plugin Settings {{{

" Vim-codefmt
call glaive#Install()
Glaive codefmt prettier_options=`['--tab-width=2']`

" Signify
let g:signify_sign_add               = '┃'
let g:signify_sign_change            = '┃'
let g:signify_sign_change_delete     = '╋'
let g:signify_sign_delete            = '┃'
let g:signify_sign_delete_first_line = '▔'

" Netrw
let g:netrw_banner          = 0
let g:netrw_liststyle       = 3
let g:eetrw_browse_split    = 4
let g:netrw_altv            = 1
let g:netrw_bufsettings     = 'noma nomod nu rnu nobl nowrap ro'
let g:netrw_use_errorwindow = 2
let g:netrw_fastbrowse		  = 2

" }}}

if has('nvim')
  :lua require('init')
endif
