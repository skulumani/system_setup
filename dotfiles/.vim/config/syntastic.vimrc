
" Syntastic settings
let g:syntastic_mode_map = { 'mode': 'passive' } 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>

