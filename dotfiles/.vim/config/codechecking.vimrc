if has('nvim')
    nnoremap <leader>m :Neomake<CR>
    " Automatically open the error window
    let g:neomake_open_list = 0
    let g:neomake_python_enabled_makers = [ 'flake8' ]
    " augroup vimrc_neomake
    "     autocmd!
    "     autocmd BufWritePost * silent Neomake
    "     autocmd VimLeave * let g:neomake_verbose = 0
    " augroup END
    " Python
    let g:neomake_python_flake8_maker = {
                \ 'exe': '/home/shankar/anaconda3/envs/neovim3/bin/flake8',
                \ 'args': ['--max-line-length=100', '--ignore=E402']
                \ }
else
    nnoremap <leader>m :SyntasticCheck<CR>
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_python_checkers = ['flake8']

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

endif
