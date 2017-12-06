

" ColorScheme 
if has("nvim")
    set termguicolors
else
    set t_Co=256
endif

syntax enable
set background=dark
colorscheme afterglow

" vim-airline theme
let g:airline_theme='afterglow'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" font settings
set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono\ 12
