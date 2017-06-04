if has('nvim')
    let g:deoplete#enable_at_startup = 1
    command! DeopleteToggle call deoplete#toggle()
    autocmd CompleteDone * pclose!
    " <CR>: close popup.
    " inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    " function! s:my_cr_function()
    "     return deoplete#mappings#close_popup()
    " endfunction
    let g:jedi#goto_command = '<leader>d'
    let g:jedi#goto_assignments_command = '<leader>g'
    let g:jedi#documentation_command = 'K'
    let g:jedi#show_call_signatures = '1'

    let g:deoplete#sources#jedi#show_docstring = 1
    let g:deoplete#sources#jedi#enable_cache = 1
    let g:deoplete#sources#jedi#worker_threads = 2
else
    let g:neocomplete#enable_at_startup = 1
    let g:acp_enableAtStartup = 0
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    " inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    " function! s:my_cr_function()
    "     return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    "     " For no inserting <CR> key.
    "     "return pumvisible() ? "\<C-y>" : "\<CR>"
    " endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
    
    " Jedi autocomplete
    let g:jedi#use_splits_not_buffers = "top"
endif

" NeoSnippet options
let g:neosnippet#snippets_directory='~/.vim/snippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
