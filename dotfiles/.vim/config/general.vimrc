filetype plugin indent on
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

    " Set important paths
    if has('unix')
        " You have to set these up using pip install.
        " I have conda environments setup already
        "
        " $ conda env create -f neovim2
        " $ conda env create -f neovim3
        " ... 
        "
        if glob('~/anaconda3/envs/neovim2/bin/python') != ''
            let g:python_host_prog = expand('~/anaconda3/envs/neovim2/bin/python')
            let g:python2_host_prog = expand('~/anaconda3/envs/neovim2/bin/python')
        else
            echom "Use conda to install neovim2"
            let g:python_host_prog = 'python'
            let g:python2_host_prog = 'python2'
        endif

        if glob('~/anaconda3/envs/neovim3/bin/python') != ''
            let g:python3_host_prog = expand('~/anaconda3/envs/neovim3/bin/python')
        else
            echom "Use conda to install neovim3"
            let g:python3_host_prog = 'python3'
        endif
    endif
endif
