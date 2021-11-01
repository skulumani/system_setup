
" Autoreload VIMRC
if has("autocmd")
    augroup vimrc 
        autocmd!
        " autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
        " Makfile needs tabs and not spaces
        autocmd FileType make setlocal noexpandtab
        " autocmd InsertEnter * call deoplete#enable()
        autocmd BufNewFile,BufReadPost *.tikz set filetype=tex
    augroup END
    
    
    " augroup vimwiki
"     autocmd!
"     autocmd BufWritePost C:\Users\skuluman\Documents\_todo\*
"         \ execute '!cd ' . expand("<amatch>:p:h")
"         \ . ' && git commit -m "Auto commit of ' 
"         \ . expand("<afile>:t") . '." "' . expand("<afile>") . '"'
" augroup END



" augroup vimwiki
"     autocmd!
"     autocmd BufWritePost C:/Users/skuluman/Documents/_todo/* :Git add -A | :Gcommit -m "Auto commit wiki"
" augroup END

endif

" Autoread a buffer if it's changed
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
" autocmd FileChangedShellPost *
  " \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

