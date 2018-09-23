"Necessary to figure out filetypes, I imagine
set nocompatible

"vsplits
set splitright
set splitbelow

filetype plugin on
syntax on

set number
set relativenumber
set numberwidth=3
set cpoptions+=n

"Custom colours for numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"Relative line numbers are good for command mode but not so good when editing:
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END



"Crazy stuff

"Remember cursor position of last edit
"   '10    - marks will be remembered for up to 10 previously edited files
"   "100   - will save up to 100 lines for each register
"   :20    - up to 20 lines of command-line history will be remembered
"   %      - saves and restores the buffer list
"   n      - where to save viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
"Function to restore last cursor position
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END 

"Template for Go
autocmd BufNewFile *.go so template.go
autocmd BufNewFile *.go exe "1," . 10 . "g/Program Name:.*/s//Program Name: " .expand("%")
autocmd BufNewFile *.go exe "1," . 10 . "g/Creation Date:.*/s//Creation Date: " .strftime("%d-%m-%Y")
"Causes the cursor to return to the previous position after editing by marking where it is
autocmd Bufwritepre,filewritepre *.go execute "normal ma"
autocmd Bufwritepre,filewritepre *.go exe "1," . 10 . "g/Last Modified:.*/s/Last Modified:.*/Last Modified: " .strftime("%c")
autocmd Bufwritepre,filewritepre *.go execute "normal `a"
