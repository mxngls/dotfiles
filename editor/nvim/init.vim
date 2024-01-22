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

" Show the number of the current hunk relative to the total number
" of hunks
function! ShowCurrentHunk() abort "{{{
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
  let l:count = 0
  let l:current_line = 1
  let l:last_line = line('$')
  while l:current_line <= last_line
    let l:last_fold_line = foldclosedend(current_line)
    if  l:last_fold_line != -1
      let l:count += 1
      let l:current_line = last_fold_line + 1
    else
      let l:current_line += 1
    endif
  endwhile
  echo 'Active folds: ' . count
endfunction
" }}}

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

" Patch statusline
function! PatchStatusline() "{{{
  if g:colors_name == 'default'
    if &bg == 'dark'
      hi StatusLine ctermbg=232 guibg=#d7dae1 ctermfg=232 guifg=#0a0b10
      hi StatusLineNC ctermbg=236 guibg=#4f5258 ctermfg=235 guifg=#0a0b10
    else
      hi StatusLine ctermbg=239 guibg=#4f5258 ctermfg=232 guifg=#ebeef5
      hi StatusLineNC ctermbg=236 guibg=#236 ctermfg=239 guifg=#4f5258
    endif
  endif
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
  endif
endfunction
"}}}

" Simplify finding files and avoid heavy plugins
function! CFind(filename) abort "{{{
  if executable('fd')
    let l:cmd = 'fd -a --hidden --type f --type d --type l -p "'.a:filename.'"'
  else
    let l:cmd = 'find . -type f -type d --path -name "*'.a:filename.'*"
          \ -o -type l -name "*'.a:filename.'*"'
  endif

  let l:fp = system(l:cmd)
  let l:bufnr = bufadd('find_results')
  let l:winnr = bufwinnr(l:bufnr)

  call bufload(l:bufnr)
  call setbufline(l:bufnr, 1, split(l:fp, "\n"))

  execute l:bufnr . 'sbuf'
  8 wincmd _ 

  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  setlocal nomodifiable ro
  setlocal number
  setlocal norelativenumber
  setlocal colorcolumn=

  " Local keymap to open in vertical split
  nnoremap <buffer> vs :wincmd L \| execute 'normal gf'<CR>

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
nnoremap <leader>ff :Find 
map gr :Grep <C-r><C-w><CR>
map ff :Find <C-r><C-w><CR>

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

" Toggle signcolumn
nnoremap <silent> <leader>ss :SignifyToggle<CR>

" Insert a HTML tag
inoremap <C-t> <C-o>b<C-o>diw<<C-r>"></<C-r>"><C-o>T>

" Terminal mode
tnoremap <C-w>n <C-\><C-n>

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
augroup restore_cursor
  autocmd!
  autocmd BufRead *
    \ let s:line = line("'\"")
    \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \ |   execute "normal! g`\""
    \ | endif
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

" Show the number of the current hunk
augroup Singify
  autocmd!
  autocmd User SignifyHunk call ShowCurrentHunk()
augroup END

" Whenever we switch buffers or windows we want to rename the current tmux
" window to match the filename of the current buffer
augroup tmux
  autocmd!
  if exists('$TMUX')
    autocmd BufEnter,FocusGained,FocusLost *
          \ call system("[[ \"$(tmux display-message -p
          \ '#W' | \ cut -c 1)\" != \"_\" ]] && tmux rename-window "
          \ . expand("%:t"))
    " Cant use VimLeave here due to https://github.com/neovim/neovim/issues/21856
    autocmd UILeave * call system("tmux set-window-option automatic-rename")
  endif
augroup END

" Open a quickfix or location list when viewing results of command that 
" gets triggered by QuickfixCmdPost
augroup quickfix
  autocmd!
  autocmd VimEnter * delmarks Q
  autocmd VimEnter * let g:saved_pos = getcursorcharpos()
  autocmd QuickFixCmdPost * if getpos("'Q")[0] == 0
        \|   execute "mark Q"
        \|   let g:saved_pos = getcursorcharpos()
        \| endif
        \| lopen
        \| wincmd k
augroup END

augroup theme
  autocmd!
  autocmd VimEnter * call SetColors()
  autocmd VimEnter,Colorscheme * call PatchStatusline()
augroup END

augroup eslint
  autocmd!
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact
        \ setl makeprg=npx\ eslint\ -f\ unix\ --quiet\ 'src/**/*.{js,ts,jsx,tsx}'

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

" Finding files
command! -nargs=1 -complete=file -bar Find
      \ call CFind(<f-args>)

" }}}
" Plugin Settings {{{

" Vim-codefmt
call glaive#Install()

" Signify
let g:signify_disable_by_default = 1

" Ctrl-P and (R-)Grep
if executable('rg')
  " Grep
  set grepprg=rg\ -S\ -o\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Fuzzy file finding
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
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
