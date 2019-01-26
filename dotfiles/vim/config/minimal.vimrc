filetype plugin indent on
set nocompatible
set autoindent
" text encoding
set encoding=utf8

" use 4 spaces for tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

" Keep x lines below and above the cursor
set scrolloff=5 
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
" set listchars=tab:▸\ ,eol:¬" ,space:␣
set listchars=tab:▸\ ,eol:¬"

" Highlight searching
set incsearch
set showmatch
set hlsearch
if has("nvim")
    set inccommand="nosplit"
endif
" set completeopt+=preview

" make file compilation
" let makeprg=make

" Everything to figure out the correct python environment to use
if has("nvim")
    " neomake settings
    let g:neomake_python_enable_makers = ['flake8, pylint']

    " Set important paths
    if has('unix')
        " check for mac vs. linux
        let s:uname = system("uname")

        " You have to set these up using pip install.
        " I have conda environments setup already
        "
        " $ conda env create -f neovim2
        " $ conda env create -f neovim3
        " ... 
        "
        if s:uname == "Darwin\n"

            if glob('/Users/shankar/anaconda3/envs/neovim2/bin/python') != ''
                let g:python_host_prog = expand('/Users/shankar/anaconda3/envs/neovim2/bin/python')
                let g:python2_host_prog = expand('/Users/shankar/anaconda3/envs/neovim2/bin/python')
            else
                echom "Use conda to install neovim2"
                let g:python_host_prog = 'python'
                let g:python2_host_prog = 'python2'
            endif

            if glob('/Users/shankar/anaconda3/envs/neovim3/bin/python') != ''
                let g:python3_host_prog = expand('/Users/shankar/anaconda3/envs/neovim3/bin/python')
            else
                echom "Use conda to install neovim3"
                let g:python3_host_prog = 'python3'
            endif
        else " linux
            if glob('~/anaconda3/envs/neovim2/bin/python') != ''
                let g:python_host_prog = expand('/home/shankar/anaconda3/envs/neovim2/bin/python')
                let g:python2_host_prog = expand('/home/shankar/anaconda3/envs/neovim2/bin/python')
            else
                echom "Use conda to install neovim2"
                let g:python_host_prog = 'python'
                let g:python2_host_prog = 'python2'
            endif

            if glob('~/anaconda3/envs/neovim3/bin/python') != ''
                let g:python3_host_prog = expand('/home/shankar/anaconda3/envs/neovim3/bin/python')
            else
                echom "Use conda to install neovim3"
                let g:python3_host_prog = 'python3'
            endif

        endif

    endif
endif
