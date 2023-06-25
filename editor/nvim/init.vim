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
    set undodir=~/.config/nvim/undo-dir
  endif
else
  if !isdirectory($HOME.'/.vim/undo-dir')
    call mkdir($HOME.'/.vim/undo-dir', 'p', 0700)
    set undodir=~/.vim/undo-dir
  endif
endif 

set undofile

" }}}
" {{{ Cursor

" Get a consistent cursor when working with tmux
if has("gui")
  echo "GUI"
  set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

" }}}
" {{{ Functions

" Show the number of the current hunk relative to the total number
" of hunks
function! s:ShowCurrentHunk() 
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction

" Count the number of open folds, which can we useful
" when working with large JSON arrays and we want to know
" how many elements the array holds
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

" Set the background to match our terminal (currently Kitty)
function! SetBackground()
  if has('kitty')
    let bg_ = system('head -n 1 ~/dotfiles/shell/kitty/current-theme.conf 2> /dev/null')
    let bg_ = substitute(bg_, '\n', '', 'g')
    if bg_ == '#DARK'
      set background=dark
    else
      set background=light
    endif
  else
    set background=dark
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

" Get the current head when in a Git repository
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

" Custom statusline
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

" Stop large files from crippling Vim 
function! LargeFile()
  set eventignore+=Filetype
  setlocal bufhidden=unload
  setlocal buftype=nowrite
  setlocal undolevels=-1
  autocmd VimEnter *  echo "The file is larger than " . (g:large_file / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

" If we are already in Netrw and we have another buffer open 
" we want to go back to the buffer but leave Netrw open as well
" If we are in a buffer and we haven't opened Netrw yet we
" open with :Explore
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
    " If we opened Vim without specifying a buffer or directory
    if empty(bufname('%'))
      quit
    else
      let @/=expand('%:t') | Explore | normal n
    endif
  endif
endfunction

" }}}

" Colors {{{

call SetBackground()
call SetColors()
call PatchColors()

nmap <leader>ct :call jobstart('$HOME/dotfiles/shell/toggle_theme.sh -t')<CR>

" }}}

" Keymaps {{{1

" Make leaving and saving more more pleasent 
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
nmap <leader>nw : noa w<CR>
nmap <leader>q :q<CR>

inoremap jj <ESC>

" Instead of visual we want line movement
nnoremap j gj
nnoremap k gk


" Bring sanity to the command line
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-w> <S-Right>
cnoremap <C-b> <S-Left>
cnoremap <C-x> <Del>

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
nnoremap <M-Up> :res +5<CR>
nnoremap <M-Down> :res -5<CR>
nnoremap <M-Left> :vertical res +5<CR>
nnoremap <M-Right> :vertical res -5<CR>

" Create a new file in the current directory
nnoremap <leader>o :e <C-R>=expand('%:p:h') . '/'<CR>

" Easily source our vimrc
nnoremap <leader>so :so $MYVIMRC<CR>

" Navigate the quickfix list 
nnoremap <C-n> :cnext<CR>zz
nnoremap <C-p> :cprevious<CR>zz

" Keep the opened buffer with cc or close
" it with together with the quickfix window
nnoremap <leader>cc :cclose<CR>

" Toggle folds
nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fs :set foldmethod=syntax<CR>
nnoremap <leader>fn :call CountFolds()<CR>

" @ is just too far
nnoremap <C-m> @

nnoremap Q <nop>
" These as well
map H ^
map L $

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
" Neovim specific plugins {{{2

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

" Immediately go to the last curor position
augroup save_cursor
  autocmd!
  autocmd BufReadPost * ++once
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \ exe "normal g`\"" | 
    \ let b:doopenfold = 1 | 
    \ exe "normal zz" |
    \ endif 
augroup END

" Autoformat the current buffer when saving it
augroup autoformat_settings
  autocmd!
  autocmd Filetype html,css,sass,scss,less AutoFormatBuffer prettier
  autocmd Filetype javascript,javascriptreact,typescript,typescriptreact,vue,json AutoFormatBuffer prettier
  autocmd Filetype python AutoFormatBuffer yapf
augroup END

" See above
augroup singify
  autocmd!
  autocmd User SignifyHunk call s:ShowCurrentHunk()
augroup END

" See above
augroup get_git_head 
  autocmd!
  autocmd BufAdd,BufRead * call GetGitHead()
augroup END

" Patch colors whenever the background changes
augroup patch
  autocmd!
  autocmd OptionSet background call PatchColors()
augroup END

" Whenever we switch buffers or windows we want to rename the current tmux
" window to match the filename of the current buffer
augroup tmux
  autocmd!
  if exists('$TMUX')
    autocmd WinEnter,BufReadPost,FileReadPost,BufNewFile,FocusGained * 
          \ call system("[[ \"$(tmux display-message -p 
          \ '#W' | \ cut -c 1)\" != \"_\" ]] && tmux rename-window " 
          \ . expand("%:t"))
    autocmd VimLeave * call system("tmux set-window-option automatic-rename")
  endif
augroup END

autocmd VimEnter * so $MYVIMRC
" Don't cripple Vim when working with large files
let g:large_file = 5242880 " 5MB
augroup LargeFile
  autocmd!
  autocmd WinEnter * let f=getfsize(expand("<afile>")) 
        \| if f > g:large_file || f == -2 | call LargeFile() | endif
augroup END
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
