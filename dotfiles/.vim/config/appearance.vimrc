

" ColorScheme 
if has("nvim")
    set termguicolors
else
    set t_Co=256
endif

syntax enable
set background=dark
colorscheme flattened_dark

" vim-airline theme
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:arline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1

" lightline settings
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
" let g:lightline.separator = {
" 	\   'left': '', 'right': ''
"   \}
" let g:lightline.subseparator = {
" 	\   'left': '', 'right': '' 
"   \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=1  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" font settings
set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono\ 12
