if has('nvim')
    let g:deoplete#enable_at_startup = 1
    " let g:deoplete#max_list = 10
    let g:deoplete#enable_refresh_always = 0
    " call deoplete#custom#option({
    "             \ 'auto_complete_delay': 10,
    "             \ 'num_processes': 4,
    "             \ 'auto_complete': v:false,
    "             \ })

    command! DeopleteToggle call deoplete#toggle()
    " autocmd CompleteDone * pclose!
        
    " use tab to forward cycle
    inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
    " use tab to backward cycle
    inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

    " manual completion for deoplete
    " inoremap <silent><expr> <TAB>
    "             \ pumvisible() ? "\<C-n>" :
    "             \ <SID>check_back_space() ? "\<TAB>" :
    "             \ deoplete#mappings#manual_complete()
    " function! s:check_back_space() abort "{{{
    "     let col = col('.') - 1
    "     return !col || getline('.')[col - 1]  =~ '\s'
    " endfunction"}}}
else
    " Remove old neocomplete shit
endif

" NeoSnippet options
let g:neosnippet#snippets_directory='~/.vim/snippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"             \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

set completeopt+=preview
let g:neosnippet#enable_preview = 1

" For conceal markers.
set conceallevel=0 concealcursor=niv

" Echodoc settings
set noshowmode

let g:echodoc#enable_at_startup = 1

" Hide matches from deoplete in status line area
if has("patch-7.4.314")
    set shortmess+=c
endif

" Autocmoplete for C++ using clang
let g:clang_library_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
let g:clang_auto_select = 2
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1


