" Get truncated path
function! statusline#GetTruncatedFilepath(filepath) abort
    let l:truncated_path = ' '
    let l:truncated_path = a:filepath
    if l:truncated_path != ""
        let b:parts = split(l:truncated_path, '/')
        let l:last_two = ''

        if len(b:parts) > 2
            let l:last_two = join(b:parts[-2:], '/')
            let l:truncated_path = '.../' . l:last_two
        endif
        return l:truncated_path
    endif
endfunction

" Get the current head when in a Git repository
function! statusline#GetGitHead(filepath) abort
    let l:gitbranch=''
    let l:gitrevparse=system('echo "${$((git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null)#(refs/heads/|tags/)}"')
    if l:gitrevparse!~'fatal: not a git repository'
        let l:gitbranch=substitute(l:gitrevparse, '\n', '', 'g')
    endif
    return l:gitbranch
endfunction

" Custom statusline
function! statusline#SetStatus() abort
    let l:active = g:statusline_winid == win_getid(winnr())

    let s:stl  = ''

    " Current buffer number
    let s:stl .= '[%n] '

    if l:active
        " Truncated path
        let l:truncated_path = statusline#GetTruncatedFilepath(expand('%:p'))
        let s:stl .= l:truncated_path . ' '

        " Current Git branch
        let l:gitbranch = statusline#GetGitHead(expand('%:p'))
        let s:stl .= l:gitbranch
    else 
        " Truncated path
        let l:winid = g:statusline_winid
        let l:bufnr = winbufnr(l:winid)
        let l:filename = bufname(l:bufnr)
        let l:filepath = fnamemodify(filename, ':p')
        let l:truncated_path = statusline#GetTruncatedFilepath(l:filepath)
        let s:stl .= l:truncated_path . ' '

        " Current Git branch
        let l:gitbranch = statusline#GetGitHead(l:filepath)
        let s:stl .= l:gitbranch
    endif


    " File flags
    let s:stl .= '%(%m%r%h%w %)'


    " Right aligned
    let s:stl .= '%='

    " Current cursor position
    let s:stl .= '%(%l:%02v %)'
    let s:stl .= '%P '

    return s:stl
endfunction
