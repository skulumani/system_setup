
" UltiSnips Directory
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" Trigger configuration.
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
