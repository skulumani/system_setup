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
set colorcolumn=80

" Folding in Vim
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
" finding files in vim
set path+=**
set wildchar=<Tab> wildmenu wildmode=full
set wildignore+=*.swp,*.pyc,*.zip,*.so,*/tmp/*,*/.git/*
" Hiddent characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Highlight searching
set incsearch
set showmatch
set hlsearch

" Autoreload VIMRC
if has("autocmd")
    augroup vimrc 
        au!
        autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
    augroup END
endif

if has("nvim")
    " neomake settings
    let g:neomake_python_enable_makers = ['flake8']

    " Python path setting
    let g:python_host_prog = '/home/shankar/anaconda3/envs/neovim2/bin/python'
    let g:python3_host_prog = '/home/shankar/anaconda3/envs/neovim3/bin/python'
endif
