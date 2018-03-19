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
if has('nvim')
    call plug#begin('~/.config/nvim/plug.vim')
else
    call plug#begin('~/.vim/plug.vim')
endif

" Productivity
" Plug 'ervandew/supertab'
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'freitass/todo.txt-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'

" Appearance
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-highlightedyank' " highlight yanked text
Plug 'octol/vim-cpp-enhanced-highlight' " c++ highlighting
Plug 'ryanoasis/vim-devicons' " provides cool icons

" Programming plugins
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/indentLine'
if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'zchee/deoplete-jedi'
    " Plug 'Shougo/echodoc.vim'
else
    " Plug 'davidhalter/jedi-vim'
endif
" Code linting
if has("nvim")
    Plug 'neomake/neomake'
    Plug 'sbdchd/neoformat'
else
    " Plug 'vim-syntastic/syntastic', { 'on': 'SyntasticCheck' }
endif
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
" Plug 'Rip-Rip/clang_complete' " autcomplete for C++

" set rtp+=~/.fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Tmux plugins
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'tmux-plugins/vim-tmux'
Plug 'edkolev/tmuxline.vim' " makes tmux look like vim-airline


call plug#end()
" start all the plugins above
filetype plugin indent on
