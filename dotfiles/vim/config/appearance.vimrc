

if (has("nvim"))
	"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
	set termguicolors
endif

" ColorScheme 
if has("nvim")
else
    set t_Co=256
endif

set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono\ 12
set background=dark
let g:onedark_termcolors=16
colorscheme onedark

" base16 vim
" if filereadable(expand("~/.vimrc_background"))
"     " let base16colorspace=256
"     source ~/.vimrc_background
" endif

" vim-airline theme
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:arline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1

function! LightlineObsession()
    return '%{ObsessionStatus(''S'', '''')}'
endfunction

function! LightlineTags()
    return '%{gutentags#statusline()}'
endfunction

" lightline settings
let g:lightline = {
  \   'colorscheme': 'wombat',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified', ]
  \     ],
    \  'right': [
    \ [ 'lineinfo' ], [ 'percent' ], 
    \ [ 'fileformat' , 'fileencoding' , 'filetype' ] ]
  \   },
    \ 'inactive' : {
    \   'left': [ [ 'filename', 'modified' ] ]
    \ },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
    \     'helloworld': 'Hello, world',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   },
    \ 'component_expand': {
    \   'obsession': 'LightlineObsession',
    \   'tags' : 'LightlineTags'
    \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ [ 'close', 'obsession', 'tags'] ]
  \ }

" font settings
" git gutter settings
set updatetime=250
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
