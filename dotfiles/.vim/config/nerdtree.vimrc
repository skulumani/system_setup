" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" This two lines will automatically open Nerdtree on startup
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
"
" Ignore files
let NERDTreeIgnore = ['\.pyc$', 'tags.lock', 'tags', 'tags.temp']
let NERDTreeHijackNetrw=1
" let g:NERDTreeWinSize=40

" Netrw options
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split =4
let g:netrw_altv =1
let g:netrw_winsize=40

