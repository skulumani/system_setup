filetype plugin indent on
syntax on
set nocompatible
set autoindent
set nomodeline " disable modeline vulnerability
" text encoding
set encoding=utf8

" directories for swap files and things
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/

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
set ruler
set colorcolumn=80

" minimum window size
set winwidth=85
set winheight=5
set winminheight=5

" Keep x lines below and above the cursor
set scrolloff=5 
set sidescroll=1
set sidescrolloff=15
" Folding in Vim
set foldmethod=indent
" set foldclose=all
set foldnestmax=3
set nofoldenable
set foldlevel=99
" finding files in vim
set path+=**
set wildchar=<Tab> wildmenu wildmode=full
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*

set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" Hiddent characters
" set listchars=tab:▸\ ,eol:¬" ,space:␣
set listchars=tab:▸\ ,eol:¬"

" opening new buffers
set switchbuf=usetab
" Highlight searching
set incsearch
set showmatch
set hlsearch
set ignorecase
set smartcase
if has("nvim")
    set inccommand="nosplit"
endif
set complete-=i
" set completeopt+=preview


set autoread " autoread files
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
set mouse=n " use mouse for scroll or window size

" make file compilation
" let makeprg=make

" Everything to figure out the correct python environment to use
if has("nvim")

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

