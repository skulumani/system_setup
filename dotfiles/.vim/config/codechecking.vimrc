if has('nvim')
    " call neomake#configure#automake('nw', 1000)
    let g:neomake_open_list = 1

    " Automatically open the error window
    let g:neomake_python_enabled_makers = ['pylint', 'flake8' ]
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
    let g:neomake_python_pylint_maker = {
                \ 'exe': '/home/shankar/anaconda3/envs/neovim3/bin/pylint'
                \ }
    let g:neoformat_python_autopep8 = {
            \ 'exe': '/home/shankar/anaconda3/envs/neovim3/bin/autopep8',
            \ }
    let g:neoformat_python_yapf = {
            \ 'exe': '/home/shankar/anaconda3/envs/neovim3/bin/yapf',
            \ }
    let g:neoformat_enabled_python = ['autopep8', 'yapf']

    " C++ makers
    let g:neomake_cpp_enabled_makers = ['clang']
    let g:neomake_cpp_clang_maker = {
        \ 'exe': 'clang++',
        \ 'args': ['-Iinclude', '-Wall', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion'],
        \ }
endif
