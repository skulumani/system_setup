" initialize vundle
set rtp+=~/.vim/bundle/Vundle.vim

filetype off 
call vundle#begin()
" All the plugins are listed here
Plugin 'VundleVim/Vundle.vim'
Plugin 'lervag/vimtex'
Plugin 'scrooloose/nerdtree'
Plugin 'lifepillar/vim-solarized8'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'vim-syntastic/syntastic'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'davidhalter/jedi-vim'
Plugin 'Yggdroot/indentLine'
" start all the plugins above
call vundle#end()
filetype plugin indent on
