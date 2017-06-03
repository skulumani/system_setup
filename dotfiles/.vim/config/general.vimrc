set autoindent
" use 4 spaces for tabs
set expandtab
set softtabstop =4
set shiftwidth =4
set shiftround

set backspace =indent,eol,start
set hidden
set laststatus =2

" Set linenumbers
set number
set relativenumber
set wrap

" column ruler at 100
set colorcolumn=100

" Folding in Vim
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
" finding files in vim
set path+=**
set wildchar=<Tab> wildmenu wildmode=full

" Highlight searching
set incsearch
set showmatch
set hlsearch

" Autoreload VIMRC
if has("autocmd")
    augroup vimrc 
        autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
    augroup END
endif
