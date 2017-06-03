if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

filetype indent plugin on
" ctags command
command! MakeTags !ctags -R .

" Hiddent characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Tab spacing
set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

set hidden
set laststatus=2

set number
set relativenumber
set wrap

set colorcolumn=80

" Code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Finding files
set path+=**
set wildchar=<Tab> wildmenu wildmode=full

" Search highlighting
set incsearch 
set showmatch
set hlsearch
set ignorecase
set smartcase

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Reformat text
vmap Q gq
nmap Q gqap

" Scroll through big lines easily
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

if has("autocmd")
    augroup vimrc 
        autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
    augroup END
endif

" Nerdtree hotkey to C-n
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" install plugins
call plug#begin('~/.config/nvim/plug.vim')
" Appearance
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Programming plugins
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'

" Productivity
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

call plug#end()

" Plugin options

" Neomake
autocmd! BufWritePost * Neomake

" Solarized
set termguicolors
set background=dark
colorscheme solarized8_dark

" Vim Airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

" Options for vimtex
if has('unix')
    if has('mac')
        let g:vimtex_view_method="skim"
        let g:vimtex_view_general_viewer
                \='/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options='-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_compiler_callback_hooks=['UpdateSkim']
        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:tex = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']
            if !empty(system('pgrep Skim'))
            call extend(l:cmd, ['-g'])
            endif
            if has('nvim')
            call jobstart(l:cmd + [line('.'), l:out, l:tex])
            elseif has('job')
            call job_start(l:cmd + [line('.'), l:out, l:tex])
            else
            call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
            endif
        endfunction
    else
        let g:latex_view_general_viewer="zathura"
        let g:vimtex_view_method="zathura"
    endif
elseif has('win32')

endif
let g:tex_flavor="latex"
let g:vimtex_quickfix_open_on_warning=0
if has('nvim')
    let g:vimtex_compiler_progname='nvr'
endif

" neomake settings
let g:neomake_python_enable_makers = ['flake8']

" vim-surround in LaTeX
augroup latexSurround
    autocmd!
    autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
    let b:surround_{char2nr("e")}
    \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
    let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

" Indent Lines coloring
let g:indentLine_setColors = 1

" UltiSnips Directory
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" Trigger configuration.
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" Python path setting
let g:python_host_prog = '/home/shankar/anaconda3/envs/neovim2/bin/python'
let g:python3_host_prog = '/home/shankar/anaconda3/envs/neovim3/bin/python'

" Deoplete settings
let g:deoplete#enable_at_startup = 1
command! DeopleteToggle call deoplete#toggle()
autocmd CompleteDone * pclose!
let g:deoplete#sources#jedi#show_docstring=1

