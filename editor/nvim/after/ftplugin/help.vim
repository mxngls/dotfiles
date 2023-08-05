" Open the help window on the right and set the width to 78
" if the current window width is more than 160 terminal cells
autocmd BufWinEnter <buffer> if winwidth('%') >= 160 | wincmd L | vertical resize 78 | endif
set cursorline
