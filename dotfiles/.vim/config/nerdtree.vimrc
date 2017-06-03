autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" This two lines will automatically open Nerdtree on startup
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
