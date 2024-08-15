" Open the help window on the right if the current window width is more 
" than or equal to 160 terminal cells
autocmd BufWinEnter <buffer> if winwidth('%') >= 160 | 
            \   wincmd L | 
            \   vertical | 
            \ endif
setl cursorline
setl colorcolumn=
