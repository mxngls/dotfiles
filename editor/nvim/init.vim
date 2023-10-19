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
set switchbuf=uselast           " Reuse windows if possible
set laststatus=0                " Never show the status line
set path+=**                    " Recursively traverse directories
set splitbelow                  " Open split below the current window
set splitright                  " Open split to the right of the current window
set scrolloff=10                " Minumum number of lines to keep above/below the cursor
set syntax=on                   " Enable syntax highlighting
set spelllang=en_us             " Set the spell check language to English
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set signcolumn=no               " Disable the sign column
set pumheight=10                " Don't make the completion window too heigh
set noswapfile                  " Disable swap files
set clipboard=unnamed           " Use the system clipboard
set colorcolumn=80              " Limit the visual available width to 80 characters
set textwidth=80                " And do the same practically as well

set wildmenu                    " Enable command-line completion menu
set wildmode=longest:full       " Complete longest match, list other matches in wildmenu
set wildignorecase              " Case is ignored when completing file names and directories
set wildoptions=pum             " Show pop-up menu
set completeopt=menu,noselect   " Enable enhanced completion menu

set nohlsearch                  " Clear search highlighting
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

filetype plugin indent on

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

set undofile

" }}}
" {{{ Colors

function! PatchColors()
  " Syntax
  hi Type cterm=None
  hi Label cterm=None
  hi htmlTag ctermfg=white
  hi htmlEndTag ctermfg=white

  " TUI
  hi Folded cterm=NONE ctermfg=255 ctermbg=236
  hi FloatBorder ctermbg=NONE
  hi Visual ctermfg=238 ctermbg=255
  hi ErrorMsg cterm=NONE ctermbg=160 ctermfg=white

  " Statusline
  hi Statusline ctermbg=235 ctermfg=White cterm=NONE
  hi StatuslineNC ctermbg=235 ctermfg=DarkGrey cterm=NONE
  hi MainBranch ctermbg=235 ctermfg=White cterm=BOLD
  hi OtherBranch ctermbg=235 ctermfg=White
  hi BufNr ctermbg=235 ctermfg=Yellow

  " Vm-Signify
  hi DiffAdd ctermfg=green ctermbg=NONE
  hi DiffChange ctermfg=yellow ctermbg=NONE
  hi DiffDelete ctermfg=red ctermbg=NONE
  hi DiffText ctermfg=yellow ctermbg=NONE
  hi SignColumn ctermbg=NONE
  hi FoldColumn ctermbg=NONE

  " Vim-fugitive
  hi diffAdded ctermfg=green ctermbg=NONE
  hi diffChanged ctermfg=yellow ctermbg=NONE
  hi diffRemoved ctermfg=red ctermbg=NONE
endfunction

" }}}
" {{{ Functions

" Show the number of the current hunk relative to the total number
" of hunks
function! s:ShowCurrentHunk() abort
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

" Set the background to match our terminal (currently Kitty)
function! SetBackground() abort
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
  if &t_Co < 256
    colorscheme default
  else
    " let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    " colorscheme solarized
    colorscheme zenburn
  endif
  " Allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^Eterm'
    set t_Co=16
  endif
endfunction

" Get the current head when in a Git repository
function! GetGitHead() abort
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

" Get truncated path
function! GetTruncatedPath() abort
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

" Custom statusline
function! SetStatusline() abort
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

" Stop large files from crippling Vim
function! LargeFile() abort
  setlocal eventignore+=Filetype
  setlocal bufhidden=unload
  setlocal buftype=nowrite
  setlocal undolevels=-1
  autocmd VimEnter * echo "The file is larger than "
        \ . (g:large_file / 1024 / 1024)
        \ . " MB, so some options are changed (see .vimrc for details)."
endfunction

" If we are already in a Dirvish buffer and we have another buffer open
" we want to go back to the previously opened buffer
function ToggleExplorer() abort
  if &ft == "dirvish"
    if expand('#:t') != ''
      b#
    else
      quit
    endif
  else
    if empty(bufname('%'))
      quit
    else
      Dirvish
    endif
  endif
endfunction

function! ExplorerSplit() abort
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

" Just used for the quickfix window
function! AdjustWindowHeight(minheight, maxheight) abort
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Make simplify finding and avoid heavy plugins
function! CFind(filename) abort
  if executable('fd')
    let l:cmd = 'fd --hidden --type f --type l "'.a:filename.'"
          \ | xargs file | sed "s/:/:1:/"'
  else
    let l:cmd = 'find . -type f -name "*'.a:filename.'*"
          \ -o -type l -name "*'.a:filename.'*"
          \ | xargs file | sed "s/:/:1:/"'
  endif
  setlocal errorformat=%f:%l:%m
  return system(l:cmd)
endfunction

function! CGrep(...) abort
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

function! IsMarkSet(mark) abort
  let l:marks = getmarklist()
  let l:m = 0
  let mark_set = 1

  while l:m < len(l:marks)
    if get(l:marks[l:m], 'mark') == '''' . a:mark
      echo 'SET'
      let l:mark_set = 0
      break
    endif
    let l:m += 1
  endwhile
  return l:mark_set
endfunction

function! OpenQuickfix() abort
  let l:qfl = len(getqflist())
  if l:qfl > 0
    if IsMarkSet('Q') != 0
      mark Q
    endif
    let @/ = expand('<cword>')
    cwindow
    execute 'set hls'
  endif
endfunction

" Close the quickfix list
function! CloseQuickfixList(close_current = 0) abort
  if !empty(getqflist())
    cclose
    if a:close_current != 1
      bdelete
    set nohls
    endif
    normal `Q zz
    delmarks Q
    wincmd =
    call setqflist([])
  endif
endfunction


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

" Navigate the quickfix list
nnoremap <C-n> :cnext<CR>zz
nnoremap <C-p> :cprevious<CR>zz

" Keep the opened buffer with cc or close
" it with together with the quickfix window
nnoremap <leader>cc :call CloseQuickfixList()<CR>
nnoremap <leader>cd :call CloseQuickfixList(1)<CR>

" Toggle folds
nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fs :set foldmethod=syntax<CR>
nnoremap <leader>fn :call CountFolds()<CR>

" Toggle the sign column
nnoremap <silent> <leader>sc :if &signcolumn == 'yes' <Bar>
  \   set signcolumn=no <Bar>
  \ else <Bar>
  \   set signcolumn=yes <Bar>
  \ endif<CR>

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

" Toggle search highlighting
nnoremap <silent> <leader>ll :if &hls && v:hlsearch <Bar>
  \   set nohls <Bar>
  \ else <Bar>
  \    set hls <Bar>
  \ endif<CR>

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
nnoremap <leader>l  :call ToggleExplorer()<CR>
nnoremap <leader>L  :call ExplorerSplit()<CR>
nnoremap <leader>sh :Shdo

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
        \AutoFormatBuffer prettier
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
    autocmd WinEnter,BufReadPost,FileReadPost,BufNewFile,FocusGained *
          \ call system("[[ \"$(tmux display-message -p
          \ '#W' | \ cut -c 1)\" != \"_\" ]] && tmux rename-window "
          \ . expand("%:t"))
    autocmd VimLeave * call system("tmux set-window-option automatic-rename")
  endif
augroup END

" Don't cripple Vim when working with large files
let g:large_file = 5242880 " 5MB
augroup LargeFile
  autocmd!
  autocmd BufReadPre * let f = getfsize(expand('%')) * 8
        \| if f > g:large_file || f == -2 | call LargeFile() | endif
augroup END

" Open a quickfix when viewing results of grep (if there are any)
" and adjust the height of our quickfix window
" When pressing CTRL_:h
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr call OpenQuickfix()
  autocmd FileType qf call AdjustWindowHeight(3, 10)
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
      \ cgetexpr CGrep(<f-args>) |
      \ cc |
      \ set hls

" Finding files
command! -nargs=1 -complete=file -bar Find
      \ cgetexpr CFind(<f-args>) |
      \ cc |
      \ set hls

" }}}
" Plugin Settings {{{

" Vim-codefmt
call glaive#Install()

" Signify
let g:signify_sign_add               = '┃'
let g:signify_sign_change            = '┃'
let g:signify_sign_change_delete     = '╋'
let g:signify_sign_delete            = '┃'
let g:signify_sign_delete_first_line = '▔'


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

call SetBackground()
call SetColors()
call PatchColors()

" }}}
