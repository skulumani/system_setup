" initialize vundle
set rtp+=~/.vim/bundle/Vundle.vim

filetype off 
call vundle#begin()
" All the plugins are listed here
Plugin 'VundleVim/Vundle.vim'
Plugin 'lervag/vimtex'
Plugin 'flazz/vim-colorschemes'
Plugin 'felixhummel/setcolors.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'vim-syntastic/syntastic'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'davidhalter/jedi-vim'
Plugin 'cjrh/vim-conda'

" start all the plugins above
call vundle#end()
filetype plugin indent on
