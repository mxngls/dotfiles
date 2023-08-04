"Protect our keymaps from beeing overwritten bey netrw
set bufhidden=wipe
nmap .     <C-l>    <CR>
nmap <C-l> :wincmd l<CR>
nmap c     %        <CR>
autocmd FileType netrw setl bufhidden=delete
