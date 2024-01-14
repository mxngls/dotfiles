" Name:     Custom
" Author:   Maximilian Engels <maximilian.e.hoenig@gmail.com>
" URL:      http://mxngls.github.io

" Basic editor settings {{{

set nocompatible                " Disable compatibility with vi
let mapleader="\<Space>"        " Use Space key as the map leader
set ttyfast                     " Improve redraw speed for terminals
set syntax=on                   " Enable syntax highlighting
set timeout                     " Enable timeout for mappings
set timeoutlen=300              " Set timeout length to 300ms
set updatetime=300              " Trigger the CursorHold autocomommand event
set spelllang=en_us             " Set the spell check language to English
set noswapfile                  " Disable swap files
set confirm                     " Confirm before overwriting a file
set autoread                    " Automatically read a file when it changes
set regexpengine=2              " Use improved regular expression engine
set path+=**                    " Recursively traverse directories
set clipboard=unnamed           " Use the system clipboard
set undofile

set backspace=indent,eol,start  " Allow backspacing over everything
set showmatch                   " Show matching brackets
set matchpairs+=(:),[:],{:},<:> " Additional characters for matchpairs
set iskeyword-=_                " Use the undersore character to split words

set switchbuf=uselast           " Reuse windows if possible
set splitbelow                  " Open split below the current window
set splitright                  " Open split to the right of the current window

set showmode                    " Show current mode in the command line
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set signcolumn=auto:3
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
set smartcase                   " Search case-sensetive in certain cases (lol)

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

set noruler
set laststatus=2
set statusline=%!SetStatusline() " Set custom status ruler

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

function! PatchColors()
  " Vim-Signify
  hi DiffAdd ctermbg=NONE guibg=NONE
  hi DiffChange ctermbg=NONE guibg=NONE
  hi DiffDelete ctermbg=NONE guibg=NONE
  hi DiffText ctermbg=NONE guibg=NONE
endfunction

" }}}
" {{{ Functions

" Show the number of the current hunk relative to the total number
" of hunks
function! s:ShowCurrentHunk() abort "{{{
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction
" }}}

" Count the number of open folds, which can we useful
" when working with large JSON arrays and we want to know
" how many elements the array holds
function! CountFolds() "{{{
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
" }}}

" Set the background to match our terminal (currently Kitty)
function! SetBackground() abort "{{{
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
" }}}

" Set the colorscheme
function! SetColors() "{{{
  if &t_Co < 256
    colorscheme default
  else
    " colorscheme menguless
    " set termguicolors
    colorscheme default
  endif
  " Allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^Eterm'
    set t_Co=16
  endif
endfunction
"}}}

" Get the current head when in a Git repository
function! GetGitHead() abort "{{{
  let b:gitbranch=''
  if &modifiable
    try
      lcd %:p:h
    catch
      return
    endtry
    let l:gitrevparse=system('echo "${$((git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null)#(refs/heads/|tags/)}"')
    lcd -
    if l:gitrevparse!~'fatal: not a git repository'
      let b:gitbranch=substitute(l:gitrevparse, '\n', '', 'g')
    endif
  endif
endfunction
"}}}

" Get truncated path
function! GetTruncatedPath() abort "{{{
  let b:path = ' '
  let b:path = expand('%:p')
  if b:path != ""
    let b:parts = split(b:path, '/')
    let b:last_two = ''

    if len(b:parts) > 2
      let b:last_two = join(b:parts[-2:], '/')
      let b:path = '.../' . b:last_two
    else
      let b:path = b:last_two
    endif
  endif
endfunction
"}}}

" Custom statusline
function! SetStatusline() abort "{{{
	let active = g:statusline_winid == win_getid(winnr())

  let l:stl  = ''

  " Current buffer number
  let l:stl .= active ? '%#BufNr#[%n]%* ' : '[%n] '

  " Truncated path
  if exists('b:path')
    let l:stl .= '%(%{b:path} %)'
  endif

  " File flags
  let l:stl .= '%(%m%r%h%w %)'

  " Current Git branch
  if exists('b:gitbranch')
    if active
      if b:gitbranch ==# 'main' || b:gitbranch ==# 'master'
        let l:stl .= '%#MainBranch#%(%{b:gitbranch}%* %)'
      else
        let l:stl .= '%#OtherBranch#%(%{b:gitbranch} %)%*'
      endif
    else
      let l:stl .= '%{b:gitbranch}'
    endif
  endif

  " Right aligned
  let l:stl .= '%='

  " Current cursor position
  let l:stl .= '%(%l:%02v %)'
  let l:stl .= '%P '

  return stl
endfunction
"}}}

function! ExplorerSplit() abort "{{{
  if &ft != "dirvish"
    let path = expand('%:p:h')
    if winwidth('%') > 160
      execute 'vnew'
    else
      execute 'new'
    endif
    execute 'Dirvish' . path
  else
    quit
  endif
endfunction
"}}}

" Just used for the quickfix window
function! AdjustWindowHeight(minheight, maxheight) abort "{{{
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction "}}}

" Simplify finding and grepping and avoid heavy plugins
function! CFind(filename) abort "{{{
  if executable('fd')
    let l:cmd = 'fd --hidden --type f --type d --type l -p "'.a:filename.'"
          \ | xargs file | sed "s/:/:1:/"'
  else
    let l:cmd = 'find . -type f -type d --path -name "*'.a:filename.'*"
          \ -o -type l -name "*'.a:filename.'*"
          \ | xargs file | sed "s/:/:1:/"'
  endif
  setlocal errorformat=%f:%l:%m
  return system(l:cmd)
endfunction
"}}}

" See above
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
nnoremap <S-Up> :res +5<CR>
nnoremap <S-Down> :res -5<CR>
nnoremap <S-Left> :vertical res +5<CR>
nnoremap <S-Right> :vertical res -5<CR>

" Create a new file in the current directory
nnoremap <leader>o :e <C-R>=expand('%:p:h') . '/'<CR>

" Easily source our vimrc
nnoremap <leader>so :so $MYVIMRC<CR>

" Navigate the quickfix and location list
nnoremap <C-n> :cnext<CR>zz
nnoremap <C-p> :cprevious<CR>zz
nnoremap <M-j> :lnext<CR>zz
nnoremap <M-k> :lprevious<CR>zz
nnoremap <leader>r :execute "normal 'Q" <Bar> 
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
nnoremap <leader>ff :Find 
map gr :Grep <C-r><C-w><CR>
map ff :Find <C-r><C-w><CR>

" @ is just too far
nnoremap <C-m> @

" These as well
map H ^
map L $

" Toggle signcolumn
nnoremap <silent> <leader>ss :SignifyToggle<CR>

" Insert a HTML tag
inoremap <C-t> <C-o>b<C-o>diw<<C-r>"></<C-r>"><C-o>T>

" Plugin related {{{2

" Fugitive
nnoremap <leader>gg :Git<CR>

" Vim-codefmt
nnoremap <leader>fc :FormatCode<CR>
vnoremap <leader>fl :FormatLines<CR>

" Signify
nnoremap <leader>hd :SignifyHunkDiff<CR>
nnoremap <leader>hu :SignifyHunkUndo<CR>

" Dirvish
nnoremap <leader>L  :call ExplorerSplit()<CR>

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

" Misc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" File explorer
Plug 'justinmk/vim-dirvish'

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

  " LSP and CMP support for Vim related plugins
  Plug 'folke/neodev.nvim'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Autocompletion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

endif

" }}}

call plug#end()

" }}}
" Autocommands {{{

" Immediately go to the last curor position
augroup save_cursor
  autocmd!
  autocmd BufReadPost *
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
  autocmd Filetype javascript,javascriptreact,
        \typescript,typescriptreact,
        \vue,
        \json
        \ AutoFormatBuffer prettier
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

" Set truncated path for the current buffer
augroup get_truncated_path
  autocmd!
  autocmd BufAdd,BufRead * call GetTruncatedPath()
augroup END

" Patch colors whenever the background changes
augroup patch
  autocmd!
  autocmd Colorscheme * call PatchColors()
augroup END

" Whenever we switch buffers or windows we want to rename the current tmux
" window to match the filename of the current buffer
augroup tmux
  autocmd!
  if exists('$TMUX')
    autocmd FocusGained *
          \ call system("[[ \"$(tmux display-message -p
          \ '#W' | \ cut -c 1)\" != \"_\" ]] && tmux rename-window "
          \ . expand("%:t"))
    " Cant use VimLeave here due to https://github.com/neovim/neovim/issues/21856
    autocmd UILeave * call system("tmux set-window-option automatic-rename")
  endif
augroup END

" Open a quickfix or location list when viewing results of command that gets
" triggered by QuickfixCmdPost and adjust the height of said window
augroup quickfix
  autocmd!
  autocmd FileType qf call AdjustWindowHeight(3, 10)
  autocmd VimEnter * delmarks Q
  autocmd VimEnter * let g:saved_pos = [0,0,0,0,0]
  autocmd QuickFixCmdPost * if getpos("'Q")[0] == 0
        \|   execute "mark Q"
        \|   let g:saved_pos = getcursorcharpos()
        \| endif
        \| lopen
augroup END

augroup theme
  autocmd!
  autocmd VimEnter * call SetBackground()
  autocmd VimEnter * call SetColors()
  autocmd VimEnter * call PatchColors()
augroup END

augroup eslint
  autocmd!
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact
        \ setl makeprg=npx\ eslint\ -f\ unix\ --quiet\ 'src/**/*.{js,ts,jsx,tsx}'
augroup END

" }}}
" {{{ Customize Commands

" Grepping stuff
command! -nargs=+ -complete=file -bar Grep
      \ lgetexpr CGrep(<f-args>) |
      \ ll |

" Finding files
command! -nargs=1 -complete=file -bar Find
      \ lgetexpr CFind(<f-args>) |
      \ ll

" }}}
" Plugin Settings {{{

" Vim-codefmt
call glaive#Install()

" Signify
let g:signify_disable_by_default     = 1

" Grep
if executable('ag')
  set grepprg=ag\ -S\ -o\ --vimgrep\ --silent
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Dirvish / Netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" }}}
" {{{ NVIM

if has('nvim')
  :lua require('init')
endif

" }}}
