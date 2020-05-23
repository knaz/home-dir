execute pathogen#infect()

nnoremap Y y$
nnoremap T :tabe <C-R>"
nnoremap tn :tabe 
set ai
set mouse=a
set expandtab
set sw=4
set ts=4
syntax on
set timeoutlen=1000 ttimeoutlen=0
set laststatus=2 statusline=%f\ %=line\ %l\ column\ %c

" from https://stackoverflow.com/questions/14079149/vim-automatically-show-left-tab-after-closing-tab
" declare function for moving left when closing a tab.
function! TabCloseLeft(cmd)
    if winnr('$') == 1 && tabpagenr('$') > 1 && tabpagenr() > 1 && tabpagenr() < tabpagenr('$')
        exec a:cmd | tabprevious
    else
        exec a:cmd
    endif
endfunction

" define :Q command
command Q call TabCloseLeft('q')
command QQ call TabCloseLeft('q!')

au! InsertLeave * set nopaste

function KeithsAlign(...) range
    let pattern = get(a:, 1, '=')

    let max_col = 0

    for line_number in range(a:firstline, a:lastline)
        let match = matchlist(getline(line_number), '\(.\{-}\)' . pattern)

        if len(match) > 0 && len(match[1]) > max_col
            let max_col = len(match[1])
        endif
    endfor

    for line_number in range(a:firstline, a:lastline)
        let current_line = getline(line_number)
        let current_line_commented = substitute(current_line, '^', '# ', "")

        let match = matchlist(getline(line_number), '\(.\{-}\)\(' . pattern . '.*\)')

        if len(match) > 0
            let padding = repeat(' ', max_col - len(match[1]))

            call setline(line_number, match[1] . padding . match[2])
        endif
    endfor
endfunction

command! -range -nargs=? On <line1>,<line2>call KeithsAlign('<args>')
command! -range -nargs=? ON <line1>,<line2>call KeithsAlign('<args>')
