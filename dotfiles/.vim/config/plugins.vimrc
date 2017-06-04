" Autoload vim plug if not already there

if has("nvim")
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif
else 
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif
endif
" All the plugins are listed here
call plug#begin('~/.vim/plug.vim')
" Appearance
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Programming plugins
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/indentLine'
if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-jedi'
else
    Plug 'davidhalter/jedi-vim'
endif
" Code linting
if has("nvim")
    " Plug "neomake/neomake"
else
    " Plug 'vim-syntastic/syntastic'
endif

" Productivity
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

call plug#end()
" start all the plugins above
filetype plugin indent on
